import 'package:flutter/material.dart';

class ColumnRowData extends StatelessWidget {
  final String topText, bottomText, status;
  final double topFontsize, bottomFontsize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool version2;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const ColumnRowData({
    super.key,
    required this.topText,
    this.bottomText = "",
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.bottomFontsize = 8,
    this.topFontsize = 12,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.version2 = false,
    this.status = "Uang Masuk",
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
          version2
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      color: status == "Uang Masuk"
                          ? const Color(0xFF54AA54)
                          : const Color(0xFFFF4D6D)),
                  child: Text(
                    status,
                    style: TextStyle(
                        fontSize: bottomFontsize,
                        fontFamily: "Poppins",
                        color: Colors.white),
                  ),
                )
              : Text(
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
