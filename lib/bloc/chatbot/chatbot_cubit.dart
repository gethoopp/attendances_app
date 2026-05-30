import 'package:attendance_app/bloc/chatbot/chatbot_state.dart';
import 'package:attendance_app/repository/chatbot/base_chatbot.dart';
import 'package:bloc/bloc.dart';

class ChatbotCubit extends Cubit<ChatbotState> {
  final BaseChatbotRepository chatbotRepository;

  ChatbotCubit(this.chatbotRepository) : super(ChatbotState.initial());

  Future<void> sendMessage({
    required String message,
    required String token,
  }) async {
    final trimmedMessage = message.trim();
    if (trimmedMessage.isEmpty || state.isLoadingResponse) {
      return;
    }

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

    try {
      await for (final chunk in chatbotRepository.streamChat(
        token: token,
        prompt: trimmedMessage,
      )) {
        if (chunk.error != null && chunk.error!.isNotEmpty) {
          throw Exception(chunk.error);
        }

        if (chunk.reply.isNotEmpty) {
          hasReceivedReply = true;
          buffer.write(chunk.reply);
        }

        final updatedMessages = [...state.messages];
        updatedMessages[updatedMessages.length - 1] = ChatbotMessageItem(
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
      }

      if (!hasReceivedReply) {
        throw Exception("Respons chatbot kosong");
      }

      if (state.isLoadingResponse) {
        final updatedMessages = [...state.messages];
        updatedMessages[updatedMessages.length - 1] = updatedMessages.last
            .copyWith(isStreaming: false);
        emit(
          state.copyWith(messages: updatedMessages, isLoadingResponse: false),
        );
      }
    } catch (e) {
      final errorMessage = e.toString().replaceFirst("Exception: ", "");
      final failedMessages = [...state.messages];
      if (failedMessages.isNotEmpty && failedMessages.last.text.isEmpty) {
        failedMessages[failedMessages.length - 1] = ChatbotMessageItem(
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
  }
}
