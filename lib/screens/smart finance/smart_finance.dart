import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/input/input_text.dart';
import 'package:amplop_duit/component/table/data/bulan_data.dart';
import 'package:amplop_duit/component/table/data/row_data.dart';
import 'package:amplop_duit/component/table/data/tanggal_data.dart';
import 'package:amplop_duit/component/table/data/withcolumn_data.dart';
import 'package:amplop_duit/component/table/table_header.dart';
import 'package:amplop_duit/component/table/table_row.dart';
import 'package:amplop_duit/theme.dart';
import 'package:amplop_duit/util/formated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SmartFinancePage extends StatefulWidget {
  const SmartFinancePage({super.key});

  @override
  State<SmartFinancePage> createState() => _SmartFinancePageState();
}

class _SmartFinancePageState extends State<SmartFinancePage> {
  String displayText = "Bulanan";
  List<String> headTable = ["Bulan", 'Pendapatan', 'Pengeluaran'];
  List<String> headTable2 = ["Tanggal", 'Deskripsi', 'Nominal'];
  static const customPadding = EdgeInsets.only(left: 16, top: 8);
  List<Widget> childList = [
    BulanDataContainer(
      date: DateTime.now(),
      padding: customPadding,
    ),
    RowDataContainer(
      text: formatToMoneyText(1200000),
      padding: customPadding,
    ),
    WithColumnContainer(
      topText: formatToMoneyText(1200000),
      bottomText: 'total : ${formatToMoneyText(1200000)}',
      padding: const EdgeInsets.only(right: 16, top: 8),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
    )
  ];
  List<Widget> childList2 = [
    TanggalDataContainer(
      date: DateTime.now(),
      padding: customPadding,
    ),
    const RowDataContainer(
      text: "Beli Makan",
      fontSize: 10,
      padding: EdgeInsets.only(left: 16, top: 8),
    ),
    RowDataContainer(
      text: formatToMoneyText(1200000),
      fontSize: 10,
      alignment: Alignment.center,
      padding: customPadding,
    ),
  ];

  bool selectedTable = true;

  void changeSelectedTable() {
    setState(() {
      selectedTable = !selectedTable;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    child: MainButton(
                      buttonText: "Bulanan",
                      bgColor: selectedTable
                          ? const Color(0xFF725CC8)
                          : Colors.white,
                      textColor: selectedTable ? Colors.white : Colors.black,
                      boxShadow:
                          selectedTable ? MainButton.defaultBoxShadow : [],
                      fontSize: 12,
                      height: 28,
                      width: 85,
                      fontWeight: FontWeight.w400,
                      borderRadius: 6,
                      action: () {
                        changeSelectedTable();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    child: MainButton(
                      buttonText: "Harian",
                      bgColor: selectedTable
                          ? Colors.white
                          : const Color(0xFF725CC8),
                      textColor: selectedTable ? Colors.black : Colors.white,
                      boxShadow:
                          selectedTable ? [] : MainButton.defaultBoxShadow,
                      fontSize: 12,
                      height: 28,
                      width: 85,
                      fontWeight: FontWeight.w400,
                      borderRadius: 6,
                      action: () {
                        changeSelectedTable();
                      },
                    ),
                  ),
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 105,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/img/background/Smart Finance - Pemasukan Uang Bulanan 1.svg",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pemasukan uang bulanan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins")),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: MyTextField(
                                  hintText: "",
                                  height: 32,
                                  borderRadius: 6,
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400),
                                )),
                                SizedBox(
                                  width: 16,
                                ),
                                MainButton(
                                  buttonText: "Hitung",
                                  bgColor: Color(0xFFFF6E30),
                                  height: 32,
                                  fontSize: 12,
                                  borderRadius: 6,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Hasil $displayText Kamu",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins")),
              ),
              Container(
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
                    TableHeader(headerData: headTable),
                    TableRowData(
                      childList: childList,
                    ),
                  ],
                ),
              ),
              Container(
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
                    TableHeader(headerData: headTable2),
                    TableRowData(
                      childList: childList2,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint("Smart Finace");
          },
          tooltip: 'Test',
          child: const Icon(Icons.add),
        ), // Th
      ),
    );
  }
}
