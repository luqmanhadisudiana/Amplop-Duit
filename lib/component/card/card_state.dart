import 'package:flutter/material.dart';

class CardState extends StatelessWidget {
  final String title;
  final String value;
  final String imageUrl;
  final double? height;
  // final double? width;

  const CardState({
    super.key,
    required this.title,
    required this.value,
    required this.imageUrl,
    this.height = 85,
    // this.width = double,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: height,
        // width: width,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          color: Colors.amber,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left),
                  Text(
                    title.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}