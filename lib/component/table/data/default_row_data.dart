import 'package:flutter/material.dart';

class DefaultRowData extends StatelessWidget {
  final String text;
  final double fontSize;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Alignment? alignment;
  const DefaultRowData({
    super.key,
    required this.text,
    this.fontSize = 12,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      alignment: alignment,
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 12, fontFamily: "Poppins", color: Color(0xFF252525)),
      ),
    );
  }
}
