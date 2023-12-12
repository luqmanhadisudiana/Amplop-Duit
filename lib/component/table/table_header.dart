import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  final List<String> headerData;
  const TableHeader({super.key, required this.headerData});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = 0; i < headerData.length; i++)
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: i < 1
                    ? null
                    : const Border(
                        left: BorderSide(color: Color(0xFFE9E9E9), width: 1.0)),
              ),
              child: Center(
                  child: Text(
                headerData[i],
              )),
            ),
          )
      ],
    );
  }
}
