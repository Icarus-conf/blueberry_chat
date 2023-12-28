import 'dart:ui';

import 'package:blueberry_chat/components/button.dart';
import 'package:blueberry_chat/components/text_field.dart';
import 'package:blueberry_chat/components/text_format.dart';
import 'package:blueberry_chat/services/auth/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordContoller = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    if (passwordContoller.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Passwords don't match"),
        ),
      );
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailAndPassword(
          emailController.text, passwordContoller.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg_2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.2),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/blueberry.png",
                          width: 100,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        PoppinsText(
                          text: "Let\s create an account for you.",
                          fontS: 16,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        MyTextField(
                          color2: Colors.white,
                          color: Color(0xFF4E5283),
                          controller: emailController,
                          hintText: "Email",
                          obscureText: false,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          color2: Colors.white,
                          color: Color(0xFF4E5283),
                          controller: passwordContoller,
                          hintText: "Password",
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          color2: Colors.white,
                          color: Color(0xFF4E5283),
                          controller: confirmPasswordController,
                          hintText: "Confirm Password",
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        MyButton(
                          onTap: signUp,
                          text: "Sign Up",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PoppinsText(
                              text: "Already a member?",
                              fontS: 16,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: PoppinsText(
                                text: "Login now",
                                fontS: 16,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}