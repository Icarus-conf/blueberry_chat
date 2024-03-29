import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Color color;
  final Color color2;
  final Color color3;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.color,
    required this.color2,
    required this.color3,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: color2,
      ),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF4A306D),
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF4A306D),
            width: 2.0,
          ),
        ),
        fillColor: color,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: color3,
        ),
      ),
    );
  }
}
