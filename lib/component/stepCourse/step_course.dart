import 'package:flutter/material.dart';

class StepCourse extends StatelessWidget {
  final double width;
  final double height;
  final double offisdeY;
  final String text;
  final bool? isDone;

  const StepCourse(
      {super.key,
      this.width = 105,
      this.height = 105,
      this.offisdeY = 50,
      required this.text,
      this.isDone = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width + 10,
      height: height + 10,
      // color: Colors.black,
      child: Center(
        child: Stack(
          children: [
            // circle 1, background shape
            Positioned(
              top: (height - height + 10) / 2 + 5,
              left: (width - width + 10) / 2,
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone == true
                      ? const Color(0xFFB0D8B0)
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
                height: height,
                width: width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone == true
                      ? const Color(0xFF339933)
                      : const Color(0xFF696969),
                ),
                clipBehavior: Clip.antiAlias,
                child: Transform.translate(
                  offset: Offset(0, offisdeY),
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
