import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/input/input_text.dart';
import 'package:amplop_duit/component/switchSection/switch_section.dart';
import 'package:amplop_duit/component/table/data/bulan_data.dart';
import 'package:amplop_duit/component/table/data/row_data.dart';
import 'package:amplop_duit/component/table/data/tanggal_data.dart';
import 'package:amplop_duit/component/table/data/withcolumn_data.dart';
import 'package:amplop_duit/component/table/table_view.dart';
import 'package:amplop_duit/screens/smart%20finance/pendapatan.dart';
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
  String displayText = "";
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
  @override
  Widget build(BuildContext context) {
    displayText = selectedTable ? "Bulanan" : "Harian";
    debugPrint(tempNumber.toString());
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Pemasukan uang bulanan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins")),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: MyTextField(
                                  controller: tempController,
                                  textInputType: TextInputType.number,
                                  hintText: "",
                                  height: 32,
                                  borderRadius: 6,
                                  textStyle: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400),
                                )),
                                const SizedBox(
                                  width: 16,
                                ),
                                MainButton(
                                  buttonText: "Hitung",
                                  bgColor: const Color(0xFFFF6E30),
                                  height: 32,
                                  fontSize: 12,
                                  borderRadius: 6,
                                  action: () {
                                    debugPrint("Change number");
                                    changeTempNumber(
                                        int.tryParse(tempController.text) ?? 0);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
              // Container Hasil
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 94,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/img/background/Smart Finance - Pemasukan Uang Bulanan Output.svg",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 16, bottom: 16, right: 16, top: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Pemasukan Bulanan",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins")),
                                InkWell(
                                  onTap: () {
                                    debugPrint("Ubah Pemasukan");
                                    changeTempNumber(0);
                                    tempController.text = '';
                                  },
                                  child: const Text("Ubah pemasukan",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins")),
                                )
                              ],
                            ),
                            Text(formatToMoneyText(tempNumber.toDouble()),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins")),
                          ],
                        ),
                      ),
                    ],
                  )),
              // Hasil Hitung Metode
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 208,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/img/background/Smart Finance - Pemasukan Uang Bulanan 2.svg",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Hasil Hitung Dengan Metode",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins")),
                                const Text("50/30/20",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins")),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Kebutuhan pokok (50%)",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins")),
                                    Text(formatToMoneyText(tempNumber * 0.5),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins")),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Keinginan (30%)",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins")),
                                    Text(formatToMoneyText(tempNumber * 0.3),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins")),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Yang harus ditabung (20%)",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins")),
                                Text(formatToMoneyText(tempNumber * 0.2),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins")),
                              ],
                            ),
                          ],
                        ),
                      ),
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
              selectedTable // Table
                  ? MyTableView(headerData: headTable, childList: childList)
                  : MyTableView(headerData: headTable2, childList: childList2)
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
