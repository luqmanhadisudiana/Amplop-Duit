import 'package:amplop_duit/component/table/data/default_row_data.dart';
import 'package:amplop_duit/component/table/table_header.dart';
import 'package:amplop_duit/component/table/table_row.dart';
import 'package:amplop_duit/models/history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryStatusTestSection extends StatelessWidget {
  const HistoryStatusTestSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Consumer<HistoryList>(builder: (context, data, child) {
      List<double> customWidth = List.generate(6, (index) => 1 / 6);
      EdgeInsets customPadding = const EdgeInsets.all(5);
      return Column(
        children: [
          const Text("Data Provider List History"),
          Text(
            "Success Rate : ${data.getSuccesRate().toString()}%",
            style: const TextStyle(
                color: Color(0xFF8AC58A),
                fontFamily: "Poppins",
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          TableHeader(
            headerData: const [
              'idCourse',
              'status',
              'attempt',
              'title',
              'question',
              'jawaban',
            ],
            customWidth: customWidth,
          ),
          data.listHistory.isEmpty
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  height: 100,
                  width: double.maxFinite,
                  color: const Color(0xFFEDEDED),
                  child: const Center(
                    child: Text(
                      "Kosong",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFD1D1D1)),
                    ),
                  ),
                )
              : const SizedBox(),
          for (var i = 0; i < data.listHistory.length; i++)
            TableRowData(
              childList: [
                DefaultRowData(
                    padding: customPadding,
                    text: data.listHistory[i].idCourse.toString()),
                DefaultRowData(
                    padding: customPadding,
                    text: data.listHistory[i].status.toString()),
                DefaultRowData(
                    padding: customPadding,
                    text: data.listHistory[i].attempt.toString()),
                DefaultRowData(
                    padding: customPadding,
                    text: data.listHistory[i].title.toString()),
                DefaultRowData(
                    padding: customPadding,
                    text: data.listHistory[i].question.toString()),
                DefaultRowData(
                    padding: customPadding,
                    text: data.listHistory[i].jawaban.toString()),
              ],
              customWidth: customWidth,
            ),
        ],
      );
    }));
  }
}
