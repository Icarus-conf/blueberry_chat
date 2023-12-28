import 'dart:ui';

import 'package:blueberry_chat/components/button.dart';
import 'package:blueberry_chat/components/colors.dart';
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
        const SnackBar(
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
              color: Colors.black.withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PoppinsText(
                              text: "Register",
                              fontS: 40,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            PoppinsText(
                              text: "Now",
                              fontS: 40,
                              color: Color(0xFF4A306D),
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const PoppinsText(
                          text: "Lets create an account for you.",
                          fontS: 16,
                          color: Color(0xFF4A306D),
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        MyTextField(
                          color3: loginRegisterTextFieldHintColor,
                          color2: loginRegisterTextFieldTextColor,
                          color: loginRegisterTextFieldColor,
                          controller: emailController,
                          hintText: "Email",
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          color3: loginRegisterTextFieldHintColor,
                          color2: loginRegisterTextFieldTextColor,
                          color: loginRegisterTextFieldColor,
                          controller: passwordContoller,
                          hintText: "Password",
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          color3: loginRegisterTextFieldHintColor,
                          color2: loginRegisterTextFieldTextColor,
                          color: loginRegisterTextFieldColor,
                          controller: confirmPasswordController,
                          hintText: "Confirm Password",
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        MyButton(
                          onTap: signUp,
                          text: "Sign Up",
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const PoppinsText(
                              text: "Already a member?",
                              fontS: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const PoppinsText(
                                text: "Login now",
                                fontS: 16,
                                color: Color(0xFFade8f4),
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
