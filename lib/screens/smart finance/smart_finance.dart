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
import 'package:amplop_duit/util/sort_datetime.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SmartFinancePage extends StatefulWidget {
  const SmartFinancePage({super.key});

  @override
  State<SmartFinancePage> createState() => _SmartFinancePageState();
}

class _SmartFinancePageState extends State<SmartFinancePage> {
  String displayText = "";
  List<String> monthlyHeaderTable = ["Bulan", 'Pendapatan', 'Pengeluaran'];
  List<String> dailyHeaderTable = ["Tanggal", 'Deskripsi', 'Nominal'];
  static const customPadding = EdgeInsets.only(left: 16, top: 8);
  late List<FinanceRowHelper> monthlyFinanceRow;
  late List<FinanceRowHelper> dailyFinancesRow;

  TextEditingController tempController = TextEditingController();
  int income = 0;
  void changeIncome(int number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('income', number);
    setState(() {
      income = number;
    });
  }

  @override
  void initState() {
    super.initState();

    _getCurrentIncome();
  }

  void _getCurrentIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? storedIncome = prefs.getInt('income');

    if (storedIncome != null) {
      setState(() {
        income = storedIncome;
      });
    } else {
      setState(() {
        income = 0;
      });
    }
  }

  bool selectedTable = true;
  void changeSelectedTable() {
    setState(() {
      selectedTable = !selectedTable;
    });
  }

  bool dividerRenderConditio() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    displayText = selectedTable ? "Bulanan" : "Harian";
    debugPrint('panjanga list finance : ${listFinance.length.toString()}');
    List<DailyFinance> dailyFinances =
        sortByKey(listFinance, (finance) => finance.datetime, descending: true);

    Map<String, List<DailyFinance>> sortedMonth =
        groupByMonth(listFinance, (finance) {
      String month = "${finance.datetime.month}".padLeft(2, '0');
      String year = "${finance.datetime.year}";
      return "$year-$month";
    }, ascending: false);

    if (sortedMonth.isEmpty) {
      monthlyFinanceRow = [];
    } else {
      debugPrint('Map sortedMonth tidak kosong, ${sortedMonth.length}');
      monthlyFinanceRow = [];
      sortedMonth.forEach((month, finance) {
        int countTemp = 0;
        for (var data in finance) {
          if (data.status == "Uang Keluar") {
            countTemp -= data.nominal;
          } else {
            countTemp += data.nominal;
          }
        }

        // debugPrint('$month: ${countTemp.toString()}');
        // debugPrint('$income $countTemp ${(income - (-countTemp))}');

        monthlyFinanceRow.add(FinanceRowHelper(status: true, widgets: [
          BulanRowData(
            date: parseYearMonth(month),
            padding: customPadding,
          ),
          DefaultRowData(
            text: formatToMoneyText(income.toDouble()),
            padding: customPadding,
          ),
          ColumnRowData(
            topText: formatToMoneyText(countTemp.abs().toDouble()),
            bottomText:
                'total : ${formatToMoneyText((income - (-countTemp)).toDouble())}',
            padding: const EdgeInsets.only(right: 16, top: 8),
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
        ]));
      });
    }

    if (dailyFinances.isNotEmpty) {
      dailyFinancesRow = [
        for (var i = 0; i < dailyFinances.length; i++)
          FinanceRowHelper(
              status: i != dailyFinances.length - 1
                  ? dailyFinances[i].datetime.month !=
                          dailyFinances[i + 1].datetime.month
                      ? true
                      : false
                  : false,
              widgets: [
                TanggalRowData(
                  date: dailyFinances[i].datetime,
                  padding: customPadding,
                ),
                ColumnRowData(
                  topText: dailyFinances[i].deskripsi,
                  bottomText: "",
                  version2: true,
                  status: dailyFinances[i].status,
                  padding: const EdgeInsets.only(left: 16, top: 8),
                ),
                DefaultRowData(
                  text: formatToMoneyText(dailyFinances[i].nominal.toDouble()),
                  fontSize: 10,
                  alignment: Alignment.center,
                  padding: customPadding,
                ),
              ])
      ];
    } else {
      dailyFinancesRow = [];
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
              const SizedBox(
                height: 24,
              ),
              income == 0
                  ? CardFinanceInput(
                      controller: tempController,
                      action: () {
                        changeIncome(int.tryParse(tempController.text) ?? 0);
                      },
                    )
                  : Column(
                      children: [
                        CardFinanceResult(
                          number: income.toDouble(),
                          action: () {
                            changeIncome(0);
                            tempController.text = '';
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CardFinanceMethodResult(
                          number: income.toDouble(),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Hasil $displayText Kamu",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins")),
              ),
              const SizedBox(
                height: 16,
              ),
              selectedTable // Table
                  ? MyTableView(
                      headerData: monthlyHeaderTable,
                      listOfRowData: monthlyFinanceRow)
                  : MyTableView(
                      headerData: dailyHeaderTable,
                      listOfRowData: dailyFinancesRow,
                    )
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
