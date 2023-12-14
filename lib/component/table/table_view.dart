import 'package:amplop_duit/component/table/table_header.dart';
import 'package:amplop_duit/component/table/table_row.dart';
import 'package:flutter/material.dart';

class MyTableView extends StatelessWidget {
  final List<String> headerData;
  final List<Widget> childList;
  const MyTableView(
      {super.key, required this.headerData, required this.childList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          TableHeader(headerData: headerData),
          for (var i = 0; i < 3; i++) // will change to childList.length
            TableRowData(
              childList: childList,
              useDivider: true,
            ),
        ],
      ),
    );
  }
}
