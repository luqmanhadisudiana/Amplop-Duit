import 'package:amplop_duit/component/card/card_finance_input.dart';
import 'package:amplop_duit/component/card/card_finance_method.dart';
import 'package:amplop_duit/component/card/card_finance_result.dart';
import 'package:amplop_duit/component/switchSection/switch_section.dart';
import 'package:amplop_duit/component/table/data/bulan_row_data.dart';
import 'package:amplop_duit/component/table/data/default_row_data.dart';
import 'package:amplop_duit/component/table/data/tanggal_row_data.dart';
import 'package:amplop_duit/component/table/data/column_row_data.dart';
import 'package:amplop_duit/component/table/table_view.dart';
import 'package:amplop_duit/models/finance.dart';
import 'package:amplop_duit/screens/smart%20finance/pendapatan.dart';
import 'package:amplop_duit/theme.dart';
import 'package:amplop_duit/util/formated_text.dart';
import 'package:flutter/material.dart';

class SmartFinancePage extends StatefulWidget {
  const SmartFinancePage({super.key});

  @override
  State<SmartFinancePage> createState() => _SmartFinancePageState();
}

class _SmartFinancePageState extends State<SmartFinancePage> {
  String displayText = "";
  List<String> headTable = ["Bulan", 'Pendapatan', 'Pengeluaran'];
  List<String> headTable2 = ["Tanggal", 'Deskripsi', 'Nominal'];
  static const customPadding = EdgeInsets.only(left: 16, top: 8);
  List<Widget> childList = [
    // BulanDataContainer(
    //   date: DateTime.now(),
    //   padding: customPadding,
    // ),
    // RowDataContainer(
    //   text: formatToMoneyText(1200000),
    //   padding: customPadding,
    // ),
    // WithColumnContainer(
    //   topText: formatToMoneyText(1200000),
    //   bottomText: 'total : ${formatToMoneyText(1200000)}',
    //   padding: const EdgeInsets.only(right: 16, top: 8),
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.end,
    // )
  ];
  List<List<Widget>> listOfChild = [];
  late List<List<Widget>> listOfChild2;

  // List<List<Widget>> listOfChild2 = [
  //   for (var i = 0; i < listFinance.length; i++)
  //     [
  //       TanggalDataContainer(
  //         date: listFinance[i].datetime,
  //         padding: customPadding,
  //       ),
  //       RowDataContainer(
  //         text: listFinance[i].deskripsi,
  //         fontSize: 10,
  //         padding: const EdgeInsets.only(left: 16, top: 8),
  //       ),
  //       RowDataContainer(
  //         text: formatToMoneyText(listFinance[i].nominal.toDouble()),
  //         fontSize: 10,
  //         alignment: Alignment.center,
  //         padding: customPadding,
  //       ),
  //     ],
  // ];

  TextEditingController tempController = TextEditingController();
  int tempNumber = 0;
  void changeTempNumber(int number) {
    setState(() {
      tempNumber = number;
    });
  }

  bool selectedTable = true;
  void changeSelectedTable() {
    setState(() {
      selectedTable = !selectedTable;
    });
  }

  @override
  Widget build(BuildContext context) {
    displayText = selectedTable ? "Bulanan" : "Harian";
    debugPrint(listFinance.length.toString());
    if (listFinance.isNotEmpty) {
      listOfChild2 = [
        for (var i = 0; i < listFinance.length; i++)
          [
            TanggalRowData(
              date: listFinance[i].datetime,
              padding: customPadding,
            ),
            ColumnRowData(
              topText: listFinance[i].deskripsi,
              bottomText: "",
              version2: true,
              status: listFinance[i].status,
              padding: const EdgeInsets.only(left: 16, top: 8),
            ),
            DefaultRowData(
              text: formatToMoneyText(listFinance[i].nominal.toDouble()),
              fontSize: 10,
              alignment: Alignment.center,
              padding: customPadding,
            ),
          ],
      ];
    } else {
      // Jika listFinance kosong, inisialisasikan listOfChild2 sebagai list kosong
      listOfChild2 = [];
    }

    return MaterialApp(
      title: "Smart Finace",
      theme: MyAppTheme.buildTheme(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Center(
                child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    child: const Text(
                      "Smart Finance",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins"),
                    )),
              ),
              SwitchSection(
                  leftLabel: "Bulanan",
                  rightLabel: "Harian",
                  selected: selectedTable,
                  action: () {
                    changeSelectedTable();
                  }),
              CardFinanceInput(
                controller: tempController,
                action: () {
                  changeTempNumber(int.tryParse(tempController.text) ?? 0);
                },
              ),
              CardFinanceResult(
                number: tempNumber.toDouble(),
                action: () {
                  changeTempNumber(0);
                  tempController.text = '';
                },
              ),
              CardFinanceMethodResult(
                number: tempNumber.toDouble(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Hasil $displayText Kamu",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins")),
              ),
              selectedTable // Table
                  ? MyTableView(
                      headerData: headTable, listOfRowData: listOfChild)
                  : MyTableView(
                      headerData: headTable2, listOfRowData: listOfChild2)
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint("Smart Finace");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PendapatanPage()),
            );
          },
          tooltip: 'Test',
          child: const Icon(Icons.add),
        ), // Th
      ),
    );
  }
}
