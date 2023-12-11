import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaderboardItem extends StatelessWidget {
  final int index, point;
  final String imageUrl, name;

  const LeaderboardItem(
      {super.key,
      required this.index,
      required this.name,
      required this.imageUrl,
      required this.point});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: Center(
                  child: index < 3
                      ? SvgPicture.asset(
                          "assets/icon/Position ${index + 1}.svg")
                      : Text(
                          (index + 1).toString(),
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
                        ),
                ),
              ),
              const SizedBox(
                width: 18,
              ),
              Container(
                width: 47.0,
                height: 47.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: ClipOval(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 32,
          ),
          Expanded(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            '${point.toString()} XP',
            style: const TextStyle(fontFamily: "Poppins", fontSize: 12),
          ),
        ]);
  }
}
