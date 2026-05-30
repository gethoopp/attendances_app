class ChatbotMessageItem {
  final String text;
  final bool isUserMessage;
  final bool isStreaming;

  const ChatbotMessageItem({
    required this.text,
    required this.isUserMessage,
    this.isStreaming = false,
  });

  ChatbotMessageItem copyWith({
    String? text,
    bool? isUserMessage,
    bool? isStreaming,
  }) {
    return ChatbotMessageItem(
      text: text ?? this.text,
      isUserMessage: isUserMessage ?? this.isUserMessage,
      isStreaming: isStreaming ?? this.isStreaming,
    );
  }
}

class ChatbotState {
  final List<ChatbotMessageItem> messages;
  final bool isLoadingResponse;
  final String? errorMessage;

  const ChatbotState({
    required this.messages,
    required this.isLoadingResponse,
    this.errorMessage,
  });

  factory ChatbotState.initial() {
    return const ChatbotState(
      messages: [
        ChatbotMessageItem(
          text: "Halo, ada yang bisa saya bantu?",
          isUserMessage: false,
        ),
      ],
      isLoadingResponse: false,
    );
  }

  ChatbotState copyWith({
    List<ChatbotMessageItem>? messages,
    bool? isLoadingResponse,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ChatbotState(
      messages: messages ?? this.messages,
      isLoadingResponse: isLoadingResponse ?? this.isLoadingResponse,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
