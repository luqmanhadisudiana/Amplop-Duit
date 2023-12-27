import 'package:amplop_duit/component/table/data/default_row_data.dart';
import 'package:amplop_duit/component/table/table_header.dart';
import 'package:amplop_duit/component/table/table_row.dart';
import 'package:amplop_duit/models/my_course_status.dart';
import 'package:flutter/material.dart';

class SavedAnswerTestSection extends StatelessWidget {
  final Function getListFunction;
  final bool isShowlist;
  final ListSavedAnswer? mySavedAnswer;
  const SavedAnswerTestSection(
      {super.key,
      required this.getListFunction,
      required this.isShowlist,
      this.mySavedAnswer});

  @override
  Widget build(BuildContext context) {
    EdgeInsets customPadding = const EdgeInsets.all(5);
    return Container(
      padding: customPadding,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              debugPrint("starting");
              getListFunction();
            },
            child: const Text('Get Saved Answer'),
          ),
          isShowlist && mySavedAnswer != null
              ? Column(
                  children: [
                    const TableHeader(headerData: [
                      "Course Index",
                      "Quiz Index",
                      "IndexSavedAnswer"
                    ]),
                    mySavedAnswer!.listSavedAnswer.isEmpty
                        ? Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
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
                    for (var i = 0;
                        i < mySavedAnswer!.listSavedAnswer.length;
                        i++)
                      TableRowData(childList: [
                        DefaultRowData(
                            padding: customPadding,
                            text: mySavedAnswer!.listSavedAnswer[i].courseIndex
                                .toString()),
                        DefaultRowData(
                            padding: customPadding,
                            text: mySavedAnswer!.listSavedAnswer[i].quizIndex
                                .toString()),
                        DefaultRowData(
                            padding: customPadding,
                            text: mySavedAnswer!
                                .listSavedAnswer[i].indexSavedAnswer
                                .toString()),
                      ], useDivider: true)
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
