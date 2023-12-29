import 'package:amplop_duit/models/my_course_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CourseAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  // final int heartCount, diamondCount;
  final BuildContext parentContext;
  final Function? action;

  const CourseAppbar(
      {super.key,
      required this.title,
      // required this.heartCount,
      // required this.diamondCount,
      required this.parentContext,
      this.action});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    var localCourseStatus = context.watch<MyCourseStatus>();
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (action != null) {
                action!();
              } else {
                Navigator.pop(parentContext);
              }
            },
          ),
          Text(
            title,
            style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          // next add heart and diamond
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icon/Heart.svg",
                    // width: 14,
                    height: 14,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    localCourseStatus.heart.toString(),
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 8,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 7.0,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icon/Diamond.svg",
                    // width: 14,
                    height: 14,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    localCourseStatus.diamond.toString(),
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 8,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
