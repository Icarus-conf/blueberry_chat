import 'package:blueberry_chat/components/text_format.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFF54577C),
      ),
      child: PoppinsText(
        text: message,
        fontS: 16,
        color: Colors.white,
      ),
    );
  }
}
