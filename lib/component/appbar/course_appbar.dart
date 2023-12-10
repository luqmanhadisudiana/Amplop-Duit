import 'package:flutter/material.dart';

class CourseAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int heartCount, diamondCount;
  final BuildContext parentContext;

  const CourseAppbar({
    super.key,
    required this.title,
    required this.heartCount,
    required this.diamondCount,
    required this.parentContext,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(parentContext);
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
                  const Icon(
                    Icons.favorite,
                    size: 14,
                    color: Colors.pink,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    heartCount.toString(),
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
                  const Icon(
                    Icons.diamond,
                    size: 14,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    heartCount.toString(),
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
