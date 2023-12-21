import 'package:amplop_duit/component/card/card_finance_input.dart';
import 'package:amplop_duit/component/card/card_finance_method.dart';
import 'package:amplop_duit/component/card/card_finance_result.dart';
import 'package:amplop_duit/component/switchSection/switch_section.dart';
import 'package:amplop_duit/component/table/table_view.dart';
import 'package:amplop_duit/models/finance.dart';
import 'package:amplop_duit/screens/smart%20finance/pendapatan.dart';
import 'package:amplop_duit/screens/smart%20finance/service.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SmartFinancePage extends StatefulWidget {
  final bool isDisplayBulanan;
  const SmartFinancePage({super.key, this.isDisplayBulanan = true});

  @override
  State<SmartFinancePage> createState() => _SmartFinancePageState();
}

class _SmartFinancePageState extends State<SmartFinancePage> {
  String displayText = "";
  List<String> monthlyHeaderTable = ["Bulan", 'Pendapatan', 'Pengeluaran'];
  List<String> dailyHeaderTable = ["Tanggal", 'Deskripsi', 'Nominal'];
  late List<FinanceRowHelper> monthlyFinanceRow;
  late List<FinanceRowHelper> dailyFinancesRow;

  TextEditingController tempController = TextEditingController();
  // late bool isMonthlyIncomeAvailable;
  late int income;
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

    income = getCurrentIncome();
    selectedTable = widget.isDisplayBulanan;
  }

  late bool selectedTable;
  void changeSelectedTable() {
    setState(() {
      selectedTable = !selectedTable;
    });
  }

  bool dividerRenderConditio() {
    return false;
  }

  void setValueMonthly(int newNominal) {
    int index = -1;
    for (var i = 0; i < listMonthlyFinance.length; i++) {
      if (DateTime(DateTime.now().year, DateTime.now().month) ==
          listMonthlyFinance[i].datetime) {
        index = i;
      }
    }
    if (index != -1) {
      listMonthlyFinance[index].nominal = newNominal;
    } else {
      listMonthlyFinance.add(MonthlyFinance(
          nominal: newNominal,
          datetime: DateTime(DateTime.now().year, DateTime.now().month)));
    }
  }

  @override
  Widget build(BuildContext context) {
    displayText = selectedTable ? "Bulanan" : "Harian";
    // isMonthlyIncomeAvailable = income == 0 ? true : false;
    monthlyFinanceRow = getListMonthlyFinance();
    dailyFinancesRow = getListDailyFinance();
    debugPrint("getter ${listMonthlyFinance.length}");
    // debugPrint("status $isMonthlyIncomeAvailable");

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
                  width: 100,
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
                        int newNominal = int.tryParse(tempController.text) ?? 0;
                        changeIncome(newNominal);
                        setValueMonthly(newNominal);
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
