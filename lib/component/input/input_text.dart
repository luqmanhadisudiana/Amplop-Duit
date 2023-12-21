import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final Color borderColor;
  final double height, width, borderRadius;
  final TextStyle textStyle;
  final TextInputType? textInputType;
  final List<TextInputFormatter> inputFormatters;

  const MyTextField(
      {super.key,
      required this.hintText,
      this.isPassword = false,
      this.controller,
      this.borderColor = const Color(0xFF696969),
      this.height = 48,
      this.width = double.maxFinite,
      this.borderRadius = 15,
      this.textInputType,
      this.inputFormatters = const [],
      this.textStyle = const TextStyle(
          fontSize: 16, fontFamily: "Poppins", fontWeight: FontWeight.w400)});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelStyle: textStyle,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: 0.5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(color: borderColor, width: 0.5),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
