import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/input/input_text.dart';
import 'package:amplop_duit/component/table/table_header.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';

class SmartFinancePage extends StatefulWidget {
  const SmartFinancePage({super.key});

  @override
  State<SmartFinancePage> createState() => _SmartFinancePageState();
}

class _SmartFinancePageState extends State<SmartFinancePage> {
  String displayText = "Bulanan";
  List<String> headTable = ["Bulan", 'Pendapatan', 'Pengeluaran'];

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
                child: Container(child: Text("Smart Finance")),
              ),
              Row(
                children: [
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    child: MainButton(buttonText: "Bulanan"),
                  ),
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    child: MainButton(buttonText: "Harian"),
                  ),
                ],
              ),
              Container(
                child: Column(
                  children: [
                    const Text("Pemasukan uang bulanan"),
                    Row(
                      children: [
                        Expanded(child: MyTextField(hintText: "")),
                        MainButton(buttonText: "Hitung")
                      ],
                    )
                  ],
                ),
              ),
              Text("Hasil $displayText Kamu"),
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
                    for (var i = 0; i < 10; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var i = 0; i < 3; i++)
                            Expanded(child: Text(headTable[i]))
                        ],
                      )
                  ],
                ),
              )
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
