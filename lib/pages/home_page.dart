import 'package:blueberry_chat/components/text_format.dart';
import 'package:blueberry_chat/pages/chat_page.dart';
import 'package:blueberry_chat/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: PoppinsText(
          text: "BlueBerry Chat",
          fontS: 25,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Color(0xFF4E5283),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("ERROR");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading..");
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 25,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Color(0xFFE3EBFF),
                padding: EdgeInsets.all(
                  25,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          receiverUserEmail: data['email'],
                          receiverUserID: data['uid'],
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      PoppinsText(
                        text: "User Email:",
                        fontS: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      PoppinsText(
                        text: data['email'],
                        fontS: 16,
                        color: Color(0xFF485696),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
