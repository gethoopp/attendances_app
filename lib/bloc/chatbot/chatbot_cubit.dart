import 'dart:async';

import 'package:attendance_app/bloc/chatbot/chatbot_state.dart';
import 'package:attendance_app/repository/chatbot/base_chatbot.dart';
import 'package:bloc/bloc.dart';

class ChatbotCubit extends Cubit<ChatbotState> {
  final BaseChatbotRepository chatbotRepository;
  StreamSubscription<ChatbotStreamChunk>? _streamSubscription;
  Completer<void>? _activeRequestCompleter;

  ChatbotCubit(this.chatbotRepository) : super(ChatbotState.initial());

  Future<void> sendMessage({
    required String message,
    required String token,
  }) async {
    final trimmedMessage = message.trim();
    if (trimmedMessage.isEmpty || state.isLoadingResponse) {
      return;
    }

    await _streamSubscription?.cancel();

    final nextMessages = [
      ...state.messages,
      ChatbotMessageItem(text: trimmedMessage, isUserMessage: true),
      const ChatbotMessageItem(
        text: "",
        isUserMessage: false,
        isStreaming: true,
      ),
    ];

    emit(
      state.copyWith(
        messages: nextMessages,
        isLoadingResponse: true,
        clearError: true,
      ),
    );

    final buffer = StringBuffer();
    var hasReceivedReply = false;
    final assistantMessageIndex = nextMessages.length - 1;
    final completer = Completer<void>();
    _activeRequestCompleter = completer;

    _streamSubscription = chatbotRepository
        .streamChat(token: token, prompt: trimmedMessage)
        .listen(
          (chunk) async {
            if (isClosed) {
              return;
            }

            if (chunk.error != null && chunk.error!.isNotEmpty) {
              _handleStreamFailure(
                message: chunk.error!,
                assistantMessageIndex: assistantMessageIndex,
              );
              if (!completer.isCompleted) {
                completer.complete();
              }
              await _streamSubscription?.cancel();
              return;
            }

            if (chunk.reply.isNotEmpty) {
              hasReceivedReply = true;
              buffer.write(chunk.reply);
            }

            final updatedMessages = [...state.messages];
            if (assistantMessageIndex >= updatedMessages.length) {
              return;
            }

            updatedMessages[assistantMessageIndex] = ChatbotMessageItem(
              text: buffer.toString(),
              isUserMessage: false,
              isStreaming: !chunk.done,
            );

            emit(
              state.copyWith(
                messages: updatedMessages,
                isLoadingResponse: !chunk.done,
              ),
            );

            if (chunk.done) {
              if (!hasReceivedReply) {
                _handleStreamFailure(
                  message: "Respons chatbot kosong",
                  assistantMessageIndex: assistantMessageIndex,
                );
              } else if (state.isLoadingResponse) {
                emit(state.copyWith(isLoadingResponse: false));
              }

              if (!completer.isCompleted) {
                completer.complete();
              }
              await _streamSubscription?.cancel();
            }
          },
          onError: (error) {
            _handleStreamFailure(
              message: error.toString().replaceFirst("Exception: ", ""),
              assistantMessageIndex: assistantMessageIndex,
            );
            if (!completer.isCompleted) {
              completer.complete();
            }
          },
          onDone: () {
            if (isClosed) {
              if (!completer.isCompleted) {
                completer.complete();
              }
              return;
            }

            if (state.isLoadingResponse) {
              if (!hasReceivedReply) {
                _handleStreamFailure(
                  message: "Respons chatbot kosong",
                  assistantMessageIndex: assistantMessageIndex,
                );
              } else {
                final updatedMessages = [...state.messages];
                if (assistantMessageIndex < updatedMessages.length) {
                  updatedMessages[assistantMessageIndex] =
                      updatedMessages[assistantMessageIndex].copyWith(
                        isStreaming: false,
                      );
                }
                emit(
                  state.copyWith(
                    messages: updatedMessages,
                    isLoadingResponse: false,
                  ),
                );
              }
            }

            if (!completer.isCompleted) {
              completer.complete();
            }
          },
          cancelOnError: false,
        );

    await completer.future;
    if (identical(_activeRequestCompleter, completer)) {
      _activeRequestCompleter = null;
    }
  }

  void _handleStreamFailure({
    required String message,
    required int assistantMessageIndex,
  }) {
    if (isClosed) {
      return;
    }

    final errorMessage = message.replaceFirst("Exception: ", "");
    final failedMessages = [...state.messages];
    if (assistantMessageIndex < failedMessages.length &&
        failedMessages[assistantMessageIndex].text.isEmpty) {
      failedMessages[assistantMessageIndex] = ChatbotMessageItem(
        text: "Maaf, $errorMessage",
        isUserMessage: false,
      );
    }

    emit(
      state.copyWith(
        messages: failedMessages,
        isLoadingResponse: false,
        errorMessage: errorMessage,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    if (_activeRequestCompleter != null &&
        !_activeRequestCompleter!.isCompleted) {
      _activeRequestCompleter!.complete();
    }
    return super.close();
  }
}
