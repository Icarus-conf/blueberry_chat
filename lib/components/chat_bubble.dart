import 'package:blueberry_chat/components/text_format.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final Color color;
  const ChatBubble({super.key, required this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: PoppinsText(
        text: message,
        fontS: 16,
        color: Colors.white,
      ),
    );
  }
}
