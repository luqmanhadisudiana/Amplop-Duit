import 'package:flutter/material.dart';

class TableRowData extends StatelessWidget {
  final List<Widget> childList;
  final List<double> customWidth;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double spaceHeight;
  final bool useDivider;
  const TableRowData(
      {super.key,
      required this.childList,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.spaceHeight = 8.0,
      this.useDivider = false,
      this.customWidth = const [0.20, 0.4, 0.4]});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double containerWidth = constraints.maxWidth;

      return Container(
        color: const Color(0xFFEDEDED),
        child: Column(
          children: [
            SizedBox(
              height: spaceHeight,
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                for (var i = 0; i < childList.length; i++)
                  SizedBox(
                    width: containerWidth * customWidth[i],
                    child: childList[i],
                  ),
              ],
            ),
            SizedBox(
              height: spaceHeight,
            ),
            useDivider
                ? Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: const Divider(
                      height: 1,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Color(0xFFE0E0E0),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      );
    });
  }
}
