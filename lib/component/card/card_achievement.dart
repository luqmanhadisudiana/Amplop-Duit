import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardAchievement extends StatelessWidget {
  final String title, desc, imageUrl;
  final int currentValue, maxValue;

  const CardAchievement({
    super.key,
    required this.title,
    required this.desc,
    required this.imageUrl,
    required this.currentValue,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(children: [
        SvgPicture.asset(
          imageUrl,
          width: 100,
          height: 112,
          fit: BoxFit.contain,
        ),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              desc,
              style: const TextStyle(fontSize: 10),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: currentValue / maxValue,
                    backgroundColor: const Color(0xFFE9E9E9),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFF43AA8B)),
                    minHeight: 15, // Set the height of the progress bar
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Row(
                  children: [Text('$currentValue /'), Text(' $maxValue')],
                ),
              ],
            )
          ]),
        )),
      ]),
    );
  }
}
