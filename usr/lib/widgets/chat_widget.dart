import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final List<types.Message> _messages = [];
  final types.User _user = const types.User(id: 'user1');

  @override
  void initState() {
    super.initState();
    // Add some mock messages
    _messages.addAll([
      types.TextMessage(
        author: const types.User(id: 'doctor'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: '1',
        text: 'Hello, how can I help you today?',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Chat(
      messages: _messages,
      onSendPressed: _handleSendPressed,
      user: _user,
    );
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toString(),
      text: message.text,
    );
    setState(() => _messages.insert(0, textMessage));
  }
}
