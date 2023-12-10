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
      child: LayoutBuilder(builder: (context, constraints) {
        double expandedWidth = constraints.maxWidth;
        return Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: expandedWidth * 0.5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(value,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                          ),
                          textAlign: TextAlign.left),
                      Text(
                        title.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8.0,
                          fontFamily: "Poppins",
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
