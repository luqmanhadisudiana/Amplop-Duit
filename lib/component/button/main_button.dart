import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String buttonText;
  final Function action;
  final double width, height;

  const MainButton({
    super.key,
    required this.buttonText,
    required this.action,
    this.width = 150.0,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: const Color(0xFF5338BC)),
      child: ElevatedButton(
          onPressed: () {
            action();
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const LoginPage()),
            // );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          )),
    );
  }
}
