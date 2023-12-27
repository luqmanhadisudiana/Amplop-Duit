import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  static const Color defaultBoxShadowColor = Color(0xFF000000);
  final String buttonText;
  final Color bgColor, textColor, disabledColor, disabledTextColor, borderColor;
  final Function? action;
  final double width, height, fontSize, borderRadius;
  final bool isDisabled;
  final FontWeight fontWeight;
  final List<BoxShadow>? boxShadow;
  final EdgeInsets? padding, margin;
  final Alignment alignment;

  static List<BoxShadow> defaultBoxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 5.0,
      spreadRadius: 2.0,
      offset: const Offset(0, 2),
    ),
  ];

  const MainButton(
      {super.key,
      required this.buttonText,
      this.action,
      this.bgColor = const Color(0xFF5338BC),
      this.textColor = Colors.white,
      this.disabledColor = const Color(0xFFCCCCCC),
      this.disabledTextColor = const Color(0xFF888888),
      this.width = 150.0,
      this.height = 50.0,
      this.fontSize = 16.0,
      this.isDisabled = false,
      this.fontWeight = FontWeight.w600,
      this.borderRadius = 15,
      this.boxShadow,
      this.margin,
      this.padding,
      this.borderColor = Colors.transparent,
      this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: isDisabled ? disabledColor : bgColor,
        boxShadow: boxShadow ?? defaultBoxShadow,
        border: Border.all(
          color: borderColor,
          width: 1.0,
        ),
      ),
      child: TextButton(
        onPressed: isDisabled
            ? null
            : () {
                if (action != null && !isDisabled) {
                  action!();
                }
              },
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.black, // Warna shadow
          elevation: 3, // Tinggi shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          backgroundColor: bgColor,
          foregroundColor: bgColor,
          padding: padding,
        ),
        child: Align(
          alignment: alignment,
          child: Text(
            buttonText,
            style: TextStyle(
              fontFamily: "Poppins",
              color: isDisabled ? disabledTextColor : textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
