import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BulanDataContainer extends StatelessWidget {
  final DateTime date;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets padding;
  final EdgeInsets margin;
  const BulanDataContainer({
    super.key,
    required this.date,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    String abbreviationMonth = DateFormat.MMM('id_ID').format(date);
    String formattedMonth = DateFormat.M('id_ID').format(date);

    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    String formattedFirstDay = DateFormat.d().format(firstDayOfMonth);

    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    String formattedLastDay = DateFormat.d().format(lastDayOfMonth);
    String formattedRangeDay =
        '$formattedMonth.$formattedFirstDay - $formattedMonth.$formattedLastDay';

    return Container(
        margin: margin,
        padding: padding,
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Text(
              abbreviationMonth,
              style: const TextStyle(
                color: Color(0xFF545454),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              formattedRangeDay,
              style: const TextStyle(
                color: Color(0xFF545454),
                fontSize: 8,
              ),
            )
          ],
        ));
  }
}
