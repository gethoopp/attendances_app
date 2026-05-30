import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:attendance_app/bloc/chatbot/chatbot_cubit.dart';
import 'package:attendance_app/bloc/chatbot/chatbot_state.dart';
import 'package:attendance_app/component/screen_argument.dart';
import 'package:attendance_app/repository/chatbot/base_chatbot.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  ChatbotCubit? _chatbotCubit;
  ScreenArguments? _args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _args = ModalRoute.of(context)?.settings.arguments as ScreenArguments?;
    _chatbotCubit ??= ChatbotCubit(context.read<BaseChatbotRepository>());
  }

  @override
  void dispose() {
    _messageController.dispose();
    _chatbotCubit?.close();
    super.dispose();
  }

  void _sendMessage() {
    final args = _args;
    final message = _messageController.text.trim();
    if (message.isEmpty || args == null) {
      return;
    }

    context.read<ChatbotCubit>().sendMessage(
      message: message,
      token: args.token,
    );

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _chatbotCubit!,
      child: BlocConsumer<ChatbotCubit, ChatbotState>(
        listener: (context, state) {
          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Chatbot')),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return Align(
                          alignment: message.isUserMessage
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            constraints: const BoxConstraints(maxWidth: 280),
                            decoration: BoxDecoration(
                              color: message.isUserMessage
                                  ? Theme.of(context).primaryColor.withAlpha(35)
                                  : Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              message.isStreaming && message.text.isEmpty
                                  ? "..."
                                  : message.text,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border(
                        top: BorderSide(
                          color: Theme.of(context).dividerColor.withAlpha(120),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _sendMessage(),
                            enabled: !state.isLoadingResponse,
                            decoration: const InputDecoration(
                              hintText: 'Tulis pesan...',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: state.isLoadingResponse
                              ? null
                              : _sendMessage,
                          icon: state.isLoadingResponse
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.send),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
