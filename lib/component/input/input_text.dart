import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;

  const MyTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF696969), // Warna border
            width: 1.0, // Lebar border
          ),
          borderRadius: BorderRadius.circular(15.0), // Radius border
        ),
        hintText: hintText,
      ),
    );
  }
}
