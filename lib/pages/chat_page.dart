import 'package:blueberry_chat/components/chat_bubble.dart';
import 'package:blueberry_chat/components/text_field.dart';
import 'package:blueberry_chat/components/text_format.dart';
import 'package:blueberry_chat/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: PoppinsText(
          text: widget.receiverUserEmail,
          fontS: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF4E5283),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUserID, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("ERROR${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }

          return ListView(
            reverse: true,
            children: snapshot.data!.docs.reversed
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            PoppinsText(
              text: data['senderEmail'],
              fontS: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            //Color(0xFF54577C)
            ChatBubble(
              message: data['message'],
              color: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? const Color(0xFF457b9d)
                  : const Color(0xFF5e548e),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: MyTextField(
              color3: Colors.grey.shade400,
              color2: Colors.black,
              color: Colors.white,
              controller: _messageController,
              hintText: "Enter a message",
              obscureText: false,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: sendMessage,
            child: CircleAvatar(
              backgroundColor: const Color(0xFFAFCBFF),
              radius: 25,
              child: Image.asset(
                "assets/send.png",
                width: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
