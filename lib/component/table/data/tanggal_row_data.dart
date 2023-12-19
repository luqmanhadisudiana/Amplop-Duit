import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TanggalRowData extends StatelessWidget {
  final DateTime date;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const TanggalRowData({
    super.key,
    required this.date,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    String stringNumberData = date.day.toString();
    String formatedDay = DateFormat.E('id_ID').format(date);
    String monthYear = DateFormat('MM.yyyy').format(date);

    return Container(
      margin: margin,
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              stringNumberData,
              style: const TextStyle(
                color: Color(0xFF545454),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 4.0),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
              decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              child: Text(
                formatedDay,
                style: const TextStyle(
                  color: Color(0xFF545454),
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ]),
          const SizedBox(
            height: 5,
          ),
          Text(
            monthYear,
            style: const TextStyle(
              color: Color(0xFF545454),
              fontSize: 8,
            ),
          )
        ],
      ),
    );
  }
}
