import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardQuizResult extends StatelessWidget {
  final double width, height;
  final bool status;
  final String title, description, answer;
  const CardQuizResult({
    super.key,
    this.width = double.maxFinite,
    this.height = 200,
    required this.status,
    this.title = "Level 1, Bagian 1",
    this.description =
        "Dari video sebelumnya, berikut apa aspek yang harus diperhatikan dalam mencatat keuangan?",
    this.answer = "Uang, Keluar, dan Masuk",
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double expandedWidth = constraints.maxWidth;
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
        child: Stack(children: [
          Positioned(
            bottom: -30,
            right: expandedWidth * 0.05,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15.0,
                    spreadRadius: 0.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SvgPicture.asset(
                status
                    ? "assets/icon/CheckCircle.svg"
                    : "assets/icon/XCircle.svg",
                width: 92,
                height: 92,
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Jawabanmu",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: expandedWidth * 0.7,
                    child: Text(
                      answer,
                      style: const TextStyle(
                          color: Color(0xFF5338BC),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins"),
                    ),
                  )
                ],
              ))
        ]),
      );
    });
  }
}
