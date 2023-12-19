import 'package:amplop_duit/component/button/main_button.dart';
import 'package:flutter/material.dart';

class SwitchSection extends StatelessWidget {
  final bool selected;
  final Function? action;
  final String leftLabel, rightLabel;
  final double width, spacerWidth;

  const SwitchSection(
      {super.key,
      required this.selected,
      this.action,
      required this.leftLabel,
      required this.rightLabel,
      this.width = 120,
      this.spacerWidth = 80});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          child: MainButton(
            buttonText: leftLabel,
            bgColor: selected ? const Color(0xFF725CC8) : Colors.white,
            textColor: selected ? Colors.white : Colors.black,
            boxShadow: selected ? MainButton.defaultBoxShadow : [],
            fontSize: 12,
            height: 28,
            width: width,
            fontWeight: FontWeight.w400,
            borderRadius: 6,
            action: () {
              if (action != null && selected == false) {
                action!();
              }
            },
          ),
        ),
        SizedBox(
          width: spacerWidth,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          child: MainButton(
            buttonText: rightLabel,
            bgColor: selected ? Colors.white : const Color(0xFF725CC8),
            textColor: selected ? Colors.black : Colors.white,
            boxShadow: selected ? [] : MainButton.defaultBoxShadow,
            fontSize: 12,
            height: 28,
            width: width,
            fontWeight: FontWeight.w400,
            borderRadius: 6,
            action: () {
              if (action != null) {
                action!();
              }
            },
          ),
        ),
      ],
    );
  }
}
