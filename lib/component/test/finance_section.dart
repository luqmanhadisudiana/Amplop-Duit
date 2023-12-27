import 'package:amplop_duit/component/input/row_label_input.dart';
import 'package:amplop_duit/component/table/data/default_row_data.dart';
import 'package:amplop_duit/component/table/table_header.dart';
import 'package:amplop_duit/component/table/table_row.dart';
import 'package:amplop_duit/models/finance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FinanceTestSection extends StatelessWidget {
  final TextEditingController? itemsController;
  final List<MonthlyFinance> listMonthlyFinance;
  final List<DailyFinance> listFinance;
  final Function generateFunction, setAndSaved;
  const FinanceTestSection(
      {super.key,
      this.itemsController,
      required this.listFinance,
      required this.listMonthlyFinance,
      required this.generateFunction,
      required this.setAndSaved});

  @override
  Widget build(BuildContext context) {
    EdgeInsets customPadding = const EdgeInsets.all(5);
    return SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: RowLabelInput(
                    controller: itemsController,
                    label: "N Items (Max 5)",
                    textInputType: TextInputType.number,
                    inputDecoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      debugPrint("test");
                      generateFunction();
                    },
                    child: const Text("Generate"))
              ],
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint("Set Provider Finance to Dummy Data");
                setAndSaved();
              },
              child: const Text('Set Provider to Dummy Data'),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Data Monthly Finance"),
                const SizedBox(
                  height: 10,
                ),
                const Text("Data Dummy"),
                Column(
                  children: [
                    const TableHeader(
                      headerData: [
                        "Date",
                        "Nominal",
                      ],
                      customWidth: [0.5, 0.5],
                    ),
                    listMonthlyFinance.isEmpty
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
                    for (var i = 0; i < listMonthlyFinance.length; i++)
                      TableRowData(childList: [
                        DefaultRowData(
                            padding: customPadding,
                            text: DateFormat()
                                .format(listMonthlyFinance[i].datetime)),
                        DefaultRowData(
                            padding: customPadding,
                            text: listMonthlyFinance[i].nominal.toString()),
                      ], customWidth: const [
                        0.5,
                        0.5
                      ]),
                  ],
                ),
                const Text("Data Provider"),
                Consumer<ListMonthlyFinance>(builder: (context, data, child) {
                  return Column(
                    children: [
                      const TableHeader(
                        headerData: [
                          "Date",
                          "Nominal",
                        ],
                        customWidth: [0.5, 0.5],
                      ),
                      data.listMonthlyFinance.isEmpty
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
                      for (var i = 0; i < data.listMonthlyFinance.length; i++)
                        TableRowData(childList: [
                          DefaultRowData(
                              padding: customPadding,
                              text: DateFormat('MM.yyyy')
                                  .format(data.listMonthlyFinance[i].datetime)),
                          DefaultRowData(
                              padding: customPadding,
                              text: data.listMonthlyFinance[i].nominal
                                  .toString()),
                        ], customWidth: const [
                          0.5,
                          0.5
                        ]),
                    ],
                  );
                })
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Data Dummy Daily Finance"),
                Column(
                  children: [
                    const TableHeader(
                      headerData: [
                        "Date",
                        "Nominal",
                        "Date",
                        "Nominal",
                      ],
                      customWidth: [0.25, 0.25, 0.25, 0.25],
                    ),
                    listMonthlyFinance.isEmpty
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
                    for (var i = 0; i < listFinance.length; i++)
                      TableRowData(childList: [
                        DefaultRowData(
                            padding: customPadding,
                            text: DateFormat('dd.MM.yyyy')
                                .format(listFinance[i].datetime)),
                        DefaultRowData(
                            padding: customPadding,
                            text: listFinance[i].nominal.toString()),
                        DefaultRowData(
                            padding: customPadding,
                            text: listFinance[i].deskripsi.toString()),
                        DefaultRowData(text: listFinance[i].status.toString()),
                      ], customWidth: const [
                        0.25,
                        0.25,
                        0.25,
                        0.25
                      ]),
                  ],
                ),
                const Text("Data Provider"),
                Consumer<ListDailyFinance>(builder: (context, data, child) {
                  return Column(
                    children: [
                      const TableHeader(
                        headerData: [
                          "Date",
                          "Nominal",
                          "Date",
                          "Nominal",
                        ],
                        customWidth: [0.25, 0.25, 0.25, 0.25],
                      ),
                      data.listDailyFinance.isEmpty
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
                      for (var i = 0; i < data.listDailyFinance.length; i++)
                        TableRowData(childList: [
                          DefaultRowData(
                              padding: customPadding,
                              text: DateFormat('dd.MM.yyyy')
                                  .format(data.listDailyFinance[i].datetime)),
                          DefaultRowData(
                              padding: customPadding,
                              text:
                                  data.listDailyFinance[i].nominal.toString()),
                          DefaultRowData(
                              padding: customPadding,
                              text: data.listDailyFinance[i].deskripsi
                                  .toString()),
                          DefaultRowData(
                              padding: customPadding,
                              text: data.listDailyFinance[i].status.toString()),
                        ], customWidth: const [
                          0.25,
                          0.25,
                          0.25,
                          0.25
                        ]),
                    ],
                  );
                })
              ],
            ),
          ],
        ));
  }
}
