import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RowLabelInput extends StatelessWidget {
  final Function? action;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final InputDecoration? inputDecoration;
  final bool readOnly; // Date must true
  final String label;
  final double rasioWidthLabel;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  const RowLabelInput(
      {super.key,
      this.action,
      this.onChanged,
      this.controller,
      this.inputDecoration,
      this.readOnly = false,
      this.rasioWidthLabel = 0.2,
      required this.label,
      this.textInputType,
      this.inputFormatters,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double containerWidth = constraints.maxWidth;

      return Row(
        children: [
          SizedBox(
            width: containerWidth * rasioWidthLabel,
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins"),
            ),
          ),
          Expanded(
            child: TextField(
                focusNode: focusNode,
                keyboardType: textInputType,
                inputFormatters: inputFormatters,
                controller: controller,
                decoration: inputDecoration,
                readOnly: readOnly,
                onChanged: onChanged,
                onTap: () {
                  if (action != null) {
                    action!();
                  }
                }),
          )
        ],
      );
    });
  }
}
