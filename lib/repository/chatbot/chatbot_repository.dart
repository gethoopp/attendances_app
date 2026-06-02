import 'dart:convert';

import 'package:attendance_app/component/url.dart';
import 'package:attendance_app/interceptor/dio_client_interceptor.dart';
import 'package:attendance_app/repository/chatbot/base_chatbot.dart';
import 'package:dio/dio.dart';

class ChatbotRepository implements BaseChatbotRepository {
  final Dio dio = DioClientInterceptor.createDio(includeChucker: false);

  @override
  Stream<ChatbotStreamChunk> streamChat({
    required String token,
    required String prompt,
    List<ChatbotRequestMessage> messages = const [],
  }) async* {
    try {
      final payload = <String, dynamic>{
        "prompt": prompt,
        "stream": true,
        if (messages.isNotEmpty)
          "messages": messages.map((message) => message.toJson()).toList(),
      };

      final response = await dio.post(
        Url.chatUrl,
        data: payload,
        options: Options(
          responseType: ResponseType.stream,
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      final responseBody = response.data;
      if (responseBody == null) {
        throw Exception("Respons stream chatbot tidak tersedia");
      }

      final rawResponseBuffer = StringBuffer();
      var hasParsedChunk = false;
      await for (final line
          in responseBody.stream
              .map((chunk) => chunk.toList().cast<int>())
              .transform(utf8.decoder)
              .transform(const LineSplitter())) {
        rawResponseBuffer.writeln(line);
        final trimmed = line.trim();
        if (trimmed.isEmpty) {
          continue;
        }

        final chunk = _parseStreamChunk(trimmed);
        if (chunk == null) {
          continue;
        }

        hasParsedChunk = true;
        yield chunk;
      }

      if (!hasParsedChunk) {
        final fallbackRawPayload = rawResponseBuffer.toString().trim();
        final fallbackChunk = _parseStreamChunk(fallbackRawPayload);
        if (fallbackChunk != null) {
          yield fallbackChunk;
          return;
        }

        throw Exception("Format response chatbot tidak dikenali");
      }
    } on DioException catch (e) {
      throw Exception(_mapDioException(e));
    } on FormatException {
      throw Exception("Format stream chatbot tidak valid");
    }
  }

  String _mapDioException(DioException e) {
    final statusCode = e.response?.statusCode;
    switch (statusCode) {
      case 401:
        return "Sesi login berakhir, silakan login ulang";
      case 400:
        return "Request chatbot tidak valid";
      case 404:
        return "Endpoint chatbot tidak ditemukan";
      case 500:
        return "Server chatbot sedang bermasalah";
      case 502:
      case 503:
        return "Layanan chatbot sedang tidak tersedia";
      default:
        return e.message ?? "Terjadi kesalahan saat memanggil chatbot";
    }
  }

  ChatbotStreamChunk? _parseStreamChunk(String rawChunk) {
    final trimmedChunk = rawChunk.trim();
    if (trimmedChunk.isEmpty) {
      return null;
    }

    var payload = trimmedChunk;
    if (payload.startsWith("data:")) {
      payload = payload.substring(5).trim();
    }

    if (payload == "[DONE]") {
      return const ChatbotStreamChunk(done: true);
    }

    dynamic decoded;
    try {
      decoded = jsonDecode(payload);
    } on FormatException {
      return null;
    }
    if (decoded is! Map) {
      return null;
    }

    final decodedMap = Map<String, dynamic>.from(
      decoded.map((key, value) => MapEntry(key.toString(), value)),
    );

    final dynamic messageObject = decodedMap["message"];
    String reply = decodedMap["reply"]?.toString() ?? "";
    if (reply.isEmpty) {
      reply = decodedMap["response"]?.toString() ?? "";
    }
    if (reply.isEmpty && messageObject is Map) {
      final messageMap = Map<String, dynamic>.from(
        messageObject.map((key, value) => MapEntry(key.toString(), value)),
      );
      reply = messageMap["content"]?.toString() ?? "";
    }

    final done = decodedMap["done"] == true;
    final error = _extractErrorMessage(decodedMap["error"]);
    return ChatbotStreamChunk(reply: reply, done: done, error: error);
  }

  String? _extractErrorMessage(dynamic errorValue) {
    if (errorValue == null) {
      return null;
    }

    if (errorValue is String) {
      final cleaned = errorValue.trim();
      return cleaned.isEmpty ? null : cleaned;
    }

    if (errorValue is Map) {
      final errorMap = Map<String, dynamic>.from(
        errorValue.map((key, value) => MapEntry(key.toString(), value)),
      );
      final nested = errorMap["message"]?.toString().trim();
      if (nested != null && nested.isNotEmpty) {
        return nested;
      }
    }

    return errorValue.toString();
  }
}
