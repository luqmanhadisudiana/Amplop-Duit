import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardHistory extends StatelessWidget {
  final double width, height;
  final String title, description;
  const CardHistory(
      {super.key,
      this.width = double.maxFinite,
      this.height = 160,
      this.title = "Pendalaman Materi",
      this.description = "Pelajari kesalahanmu lalu perbaiki kesalahanmu"});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: const Offset(0, 2),
            ),
          ]),
      child: Stack(
        children: [
          SvgPicture.asset(
              "assets/img/background/History-Pendalaman Materi.svg",
              fit: BoxFit.cover,
              width: width),
          Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
