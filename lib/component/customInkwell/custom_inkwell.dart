import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInkwell extends StatelessWidget {
  final String text;
  final String bgImageUrl;
  final Function? action;
  final Color bgColor, borderColor, textColor;
  final double borderRadius, width, height;
  final Alignment alignment;
  final EdgeInsets? padding, margin;

  const CustomInkwell(
      {super.key,
      required this.text,
      this.action,
      this.borderRadius = 6.0,
      this.width = double.maxFinite,
      this.height = 64,
      this.bgColor = Colors.white,
      this.borderColor = const Color(0xFF725CC8),
      this.textColor = Colors.black,
      this.alignment = Alignment.centerLeft,
      this.margin,
      this.bgImageUrl = '',
      this.padding = const EdgeInsets.symmetric(vertical: 20, horizontal: 24)});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double expandedWidth = constraints.maxWidth;
      return Container(
          margin: margin,
          width: width,
          height: height,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              border: Border.all(
                  color: bgImageUrl != "" ? Colors.transparent : borderColor),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              color: bgImageUrl != "" ? Colors.transparent : bgColor),
          child: Stack(
            children: [
              bgImageUrl != ''
                  ? bgImageUrl.toLowerCase().endsWith('.svg')
                      ? SvgPicture.asset(
                          bgImageUrl,
                          fit: BoxFit.cover,
                          width: expandedWidth,
                        )
                      : Image.asset(
                          bgImageUrl,
                          width: expandedWidth,
                          fit: BoxFit.cover,
                        )
                  : const SizedBox(),
              InkWell(
                onTap: () {
                  debugPrint("Inkwell Tapped");
                  if (action != null) {
                    action!();
                  }
                },
                child: Container(
                    padding: padding,
                    child: Align(
                      alignment: alignment,
                      child: Text(
                        text,
                        style: TextStyle(
                            color: textColor,
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
              ),
            ],
          ));
    });
  }
}
