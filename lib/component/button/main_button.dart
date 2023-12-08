import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String buttonText;
  final Color bgColor, textColor, disabledColor, disabledTextColor;
  final Function? action;
  final double width, height, fontSize;
  final bool isDisabled;

  const MainButton({
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        color: isDisabled ? disabledColor : bgColor,
      ),
      child: TextButton(
        onPressed: isDisabled
            ? null
            : () {
                if (action != null && !isDisabled) {
                  action!();
                }
              },
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontFamily: "Poppins",
            color: isDisabled ? disabledTextColor : textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
