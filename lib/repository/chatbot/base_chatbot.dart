class ChatbotRequestMessage {
  final String role;
  final String content;

  const ChatbotRequestMessage({required this.role, required this.content});

  Map<String, dynamic> toJson() => {"role": role, "content": content};
}

class ChatbotStreamChunk {
  final String reply;
  final bool done;
  final String? error;

  const ChatbotStreamChunk({this.reply = "", required this.done, this.error});
}

abstract class BaseChatbotRepository {
  Stream<ChatbotStreamChunk> streamChat({
    required String token,
    required String prompt,
    List<ChatbotRequestMessage> messages,
  });
}
