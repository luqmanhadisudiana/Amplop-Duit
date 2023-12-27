import 'package:amplop_duit/component/table/setting.dart';
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
      this.useDivider = true,
      this.customWidth = defaultWidth});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double containerWidth = constraints.maxWidth;

      return Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        decoration: const BoxDecoration(
          color: Color(0xFFEDEDED),
        ),
        child: Column(
          children: [
            Container(
              height: spaceHeight,
              color: const Color(0xFFEDEDED),
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
            Container(
              height: spaceHeight,
              color: const Color(0xFFEDEDED),
            ),
            useDivider
                ? Container(
                    padding: const EdgeInsets.only(top: 8),
                    color: const Color(0xFFEDEDED),
                    child: const Divider(
                      height: 1,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Color(0xFFE0E0E0),
                    ),
                  )
                : Container(
                    color: const Color(0xFFEDEDED),
                  )
          ],
        ),
      );
    });
  }
}
