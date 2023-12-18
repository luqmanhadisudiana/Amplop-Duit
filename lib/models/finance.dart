import 'package:flutter/material.dart';

class DailyFinance {
  final String deskripsi, status;
  final int nominal;
  final DateTime datetime;

  const DailyFinance({
    this.status = "Uang Keluar",
    required this.deskripsi,
    required this.datetime,
    required this.nominal,
  });
}

class FinanceRowHelper {
  List<Widget> widgets;
  bool status;

  FinanceRowHelper({required this.status, required this.widgets});
}

// class MonthlyFinance {
//   final int nominal;
//   final DateTime datetime;

//   const MonthlyFinance({
//     required this.datetime,
//     required this.nominal,
//   });
// }

// List<Finance> listFinance = [];
List<DailyFinance> listFinance = [
  DailyFinance(deskripsi: "test 1", datetime: DateTime.now(), nominal: 3000),
  DailyFinance(
      deskripsi: "test 4",
      datetime: DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day),
      nominal: 3000),
  DailyFinance(
      deskripsi: "test 6",
      datetime: DateTime(DateTime.now().year, DateTime.now().month - 3,
          DateTime.now().day - 4),
      nominal: 3000),
  DailyFinance(
      deskripsi: "test 5",
      datetime: DateTime(DateTime.now().year, DateTime.now().month - 1,
          DateTime.now().day - 3),
      nominal: 3000),
  DailyFinance(
      deskripsi: "test 2",
      datetime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 2),
      nominal: 3000),
  DailyFinance(
      deskripsi: "test 3",
      datetime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 7),
      nominal: 3000),
];