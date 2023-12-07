import 'package:flutter/material.dart';

class StepCourse extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final bool? isDone;

  const StepCourse(
      {super.key,
      this.width = 150,
      this.height = 150,
      required this.text,
      this.isDone = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      // color: Colors.black,
      child: Center(
        child: Stack(
          children: [
            // circle 1, background shape
            Positioned(
              top: (height - height / 2) / 2 + 5,
              left: (width - width / 2) / 2,
              child: Container(
                height: height / 2,
                width: width / 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone == true
                      ? const Color(0xFFD1D1D1)
                      : const Color(0xFFD1D1D1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 25.0,
                      offset: const Offset(0, 0),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                height: height / 2,
                width: width / 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone == true
                      ? const Color(0xFF696969)
                      : const Color(0xFF696969),
                ),
                clipBehavior: Clip.antiAlias,
                child: Transform.translate(
                  offset: const Offset(0, 35),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDone ?? true
                          ? const Color(0xFFD9D9D9).withOpacity(0.27)
                          : const Color(0xFFD9D9D9).withOpacity(0.27),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),

            Center(
              child: Text(
                text,
                style: const TextStyle(
                    // backgroundColor: Colors.black12,
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
