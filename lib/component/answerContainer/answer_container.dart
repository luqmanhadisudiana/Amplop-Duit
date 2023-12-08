import 'package:flutter/material.dart';

class AnswerContainer extends StatelessWidget {
  final String text;
  final int index;
  final Function? action;
  final Color? bgColor;

  const AnswerContainer(
      {super.key,
      required this.text,
      required this.index,
      this.action,
      this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (action != null) {
              action!();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(15.0),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF725CC8)),
                borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                color: bgColor),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${String.fromCharCode('A'.codeUnitAt(0) + index)}.',
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ]),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
