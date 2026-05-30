import 'dart:convert';

import 'package:attendance_app/component/url.dart';
import 'package:attendance_app/interceptor/dio_client_interceptor.dart';
import 'package:attendance_app/repository/chatbot/base_chatbot.dart';
import 'package:dio/dio.dart';

class ChatbotRepository implements BaseChatbotRepository {
  final Dio dio = DioClientInterceptor.createDio();

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

      final response = await dio.post<ResponseBody>(
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

      await for (final line
          in responseBody.stream
              .map((chunk) => chunk.toList())
              .transform(utf8.decoder)
              .transform(const LineSplitter())) {
        final trimmed = line.trim();
        if (trimmed.isEmpty) {
          continue;
        }

        final decoded = jsonDecode(trimmed);
        if (decoded is! Map<String, dynamic>) {
          continue;
        }

        final reply = decoded["reply"]?.toString() ?? "";
        final done = decoded["done"] == true;
        final errorValue = decoded["error"]?.toString();
        final error = (errorValue == null || errorValue.isEmpty)
            ? null
            : errorValue;

        yield ChatbotStreamChunk(reply: reply, done: done, error: error);
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
}
