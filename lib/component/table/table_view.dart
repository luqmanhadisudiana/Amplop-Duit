import 'package:amplop_duit/component/table/table_header.dart';
import 'package:amplop_duit/component/table/table_row.dart';
import 'package:amplop_duit/models/finance.dart';
import 'package:flutter/material.dart';

class MyTableView extends StatelessWidget {
  final List<String> headerData;
  final List<FinanceRowHelper> listOfRowData;
  const MyTableView({
    super.key,
    required this.headerData,
    required this.listOfRowData,
  });

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
          listOfRowData.isEmpty
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  height: 400,
                  width: double.maxFinite,
                  color: const Color(0xFFEDEDED),
                  child: const Center(
                    child: Text(
                      "Kamu belum menghitung uangmu",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFD1D1D1)),
                    ),
                  ),
                )
              : Column(
                  children: [
                    for (var i = 0; i < listOfRowData.length; i++)
                      TableRowData(
                        childList: listOfRowData[i].widgets,
                        useDivider: listOfRowData[i].status,
                      ),
                  ],
                )
        ],
      ),
    );
  }
}
