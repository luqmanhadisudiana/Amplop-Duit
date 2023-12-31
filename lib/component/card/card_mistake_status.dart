import 'package:amplop_duit/models/my_course_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CardMistakeStatus extends StatelessWidget {
  final double width, height;
  // final String currentStatus;
  // final int trials;
  const CardMistakeStatus({
    super.key,
    this.width = double.maxFinite,
    this.height = 105,
    // this.currentStatus = "Level 1\nBagian 1",
    // this.trials = 5
  });

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
          SvgPicture.asset("assets/img/background/History-Informasi Level.svg",
              fit: BoxFit.cover, width: width),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<MyCourseStatus>(
                          builder: (context, myCourseStatus, child) {
                        return Text(
                          myCourseStatus.getselectedQuiz < 0 ||
                                  myCourseStatus.getselectedQuiz > 5
                              ? "Level ${myCourseStatus.getSelectedCourse + 1}"
                              : "Level ${myCourseStatus.getSelectedCourse + 1}\nBagian ${myCourseStatus.getselectedQuiz + 1}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Banyaknya Percobaan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Consumer<MyCourseStatus>(
                        builder: (context, myCourseStatus, child) {
                      return Text(
                        myCourseStatus.attempt == 0
                            ? "Belum Ada"
                            : "${myCourseStatus.attempt} Kali",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }),
                  ],
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
