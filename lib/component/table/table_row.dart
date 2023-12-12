import 'package:flutter/material.dart';

class TableRow extends StatelessWidget {
  const TableRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Date Value"),
        Text(
          "Nomimal Value",
          style: TextStyle(
              fontSize: 12, fontFamily: "Poppins", color: Color(0xFF252525)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Pengeluaran Value",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Poppins",
                  color: Color(0xFF252525)),
            ),
            Text(
              "Total Value",
              style: TextStyle(
                  fontSize: 8, fontFamily: "Poppins", color: Color(0xFF696969)),
            ),
          ],
        )
      ],
    );
  }
}
