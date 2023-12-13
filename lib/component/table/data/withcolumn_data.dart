import 'package:flutter/material.dart';

class WithColumnContainer extends StatelessWidget {
  final String topText, bottomText;
  final double topFontsize, bottomFontsize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const WithColumnContainer({
    super.key,
    required this.topText,
    required this.bottomText,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.bottomFontsize = 8,
    this.topFontsize = 12,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            topText,
            style: TextStyle(
                fontSize: topFontsize,
                fontFamily: "Poppins",
                color: const Color(0xFF252525)),
          ),
          Text(
            bottomText,
            style: TextStyle(
                fontSize: bottomFontsize,
                fontFamily: "Poppins",
                color: const Color(0xFF696969)),
          ),
        ],
      ),
    );
  }
}
