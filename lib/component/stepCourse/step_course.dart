import 'package:flutter/material.dart';

class StepCourse extends StatelessWidget {
  final double width;
  final double height;
  final String text;

  const StepCourse(
      {super.key, this.width = 150, this.height = 150, required this.text});

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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                ),
              ),
            ),
            Center(
              child: Container(
                height: height / 2,
                width: width / 2,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                clipBehavior: Clip.antiAlias,
                child: Transform.translate(
                  offset: const Offset(0, 50),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),

            Center(
              child: Text(text),
            )
          ],
        ),
      ),
    );
  }
}
