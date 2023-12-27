import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinanceRowHelper {
  List<Widget> widgets;
  bool status;

  FinanceRowHelper({required this.status, required this.widgets});
}

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

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'deskripsi': deskripsi,
      'nominal': nominal,
      'datetime': datetime,
    };
  }

  factory DailyFinance.fromJson(Map<String, dynamic> json) {
    return DailyFinance(
      status: json['status'],
      deskripsi: json['deskripsi'],
      nominal: json['nominal'] as int? ?? 0,
      datetime: DateTime.fromMillisecondsSinceEpoch(json['datetime']),
    );
  }
}

class MonthlyFinance {
  int nominal;
  final DateTime datetime;

  MonthlyFinance({
    required this.nominal,
    required this.datetime,
  });

  Map<String, dynamic> toJson() {
    return {
      'nominal': nominal,
      'datetime': datetime,
    };
  }

  factory MonthlyFinance.fromJson(Map<String, dynamic> json) {
    return MonthlyFinance(
      nominal: json['nominal'] as int? ?? 0,
      datetime: DateTime.fromMillisecondsSinceEpoch(json['datetime']),
    );
  }
}

class ListDailyFinance extends ChangeNotifier {
  List<DailyFinance> listDailyFinance;

  ListDailyFinance({
    List<DailyFinance>? initialList,
  }) : listDailyFinance = initialList ?? [];

  void add(DailyFinance dailyFinance) {
    listDailyFinance.add(dailyFinance);
    notifyListeners();
  }

  void addBatch(List<DailyFinance> batchFinance) {
    listDailyFinance.addAll(batchFinance);
    notifyListeners();
  }

  Future<void> saveToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = listDailyFinance.map((daily) {
      final int dateTimeInMilliseconds = daily.datetime.millisecondsSinceEpoch;
      return jsonEncode({
        'status': daily.status,
        'deskripsi': daily.deskripsi,
        'nominal': daily.nominal,
        'datetime': dateTimeInMilliseconds,
      });
    }).toList();
    await prefs.setStringList('dailyList', jsonList);
    debugPrint("Done");
  }

  Future<void> loadFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList('dailyList');
    debugPrint("get dailyList");
    if (jsonList != null) {
      listDailyFinance = jsonList
          .map<DailyFinance>((json) =>
              DailyFinance.fromJson(jsonDecode(json) as Map<String, dynamic>))
          .toList();
      notifyListeners();
      debugPrint("done...");
    }
  }

  Future<void> resetMyObject() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("dailyList");
    listDailyFinance = [];
    await loadFromSharedPreferences();

    notifyListeners();
  }
}

class ListMonthlyFinance extends ChangeNotifier {
  List<MonthlyFinance> listMonthlyFinance;

  ListMonthlyFinance({
    List<MonthlyFinance>? initialList,
  }) : listMonthlyFinance = initialList ?? [];

  void add(MonthlyFinance monthlyFinance) {
    listMonthlyFinance.add(monthlyFinance);
    notifyListeners();
  }

  void addBatch(List<MonthlyFinance> batchFinance) {
    listMonthlyFinance.addAll(batchFinance);
    notifyListeners();
  }

  int getCurrentIncome() {
    for (var i = 0; i < listMonthlyFinance.length; i++) {
      if (DateTime.now().month == listMonthlyFinance[i].datetime.month) {
        return listMonthlyFinance[i].nominal;
      }
    }

    return 0;
  }

  void updateLatestMonthValue(int newValue) {
    int index = -1;
    for (var i = 0; i < listMonthlyFinance.length; i++) {
      if (DateTime(DateTime.now().year, DateTime.now().month) ==
          listMonthlyFinance[i].datetime) {
        index = i;
      }
    }
    if (index != -1) {
      listMonthlyFinance[index].nominal = newValue;
    } else {
      listMonthlyFinance.add(MonthlyFinance(
          nominal: newValue,
          datetime: DateTime(DateTime.now().year, DateTime.now().month)));
    }
    notifyListeners();
  }

  Future<void> saveToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = listMonthlyFinance.map((monthly) {
      final int dateTimeInMilliseconds =
          monthly.datetime.millisecondsSinceEpoch;
      return jsonEncode({
        'nominal': monthly.nominal,
        'datetime': dateTimeInMilliseconds,
      });
    }).toList();
    await prefs.setStringList('monthlyList', jsonList);
    debugPrint("Done");
  }

  Future<void> loadFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList('monthlyList');

    debugPrint("get monthlyList");
    if (jsonList != null) {
      listMonthlyFinance = jsonList
          .map<MonthlyFinance>((json) =>
              MonthlyFinance.fromJson(jsonDecode(json) as Map<String, dynamic>))
          .toList();
      notifyListeners();
      debugPrint("done...");
    }
  }

  Future<void> resetMyObject() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("monthlyList");
    listMonthlyFinance = [];
    await loadFromSharedPreferences();
    notifyListeners();
  }
}

// List<MonthlyFinance> listMonthlyFinance = [
//   MonthlyFinance(
//       datetime: DateTime(DateTime.now().year, DateTime.now().month - 1),
//       nominal: 9000000),
// ];

// List<DailyFinance> listFinance = [
//   DailyFinance(deskripsi: "test 1", datetime: DateTime.now(), nominal: 3000),
//   DailyFinance(
//       deskripsi: "test 4",
//       datetime: DateTime(
//           DateTime.now().year, DateTime.now().month - 1, DateTime.now().day),
//       nominal: 3000),
//   DailyFinance(
//       deskripsi: "test 5",
//       datetime: DateTime(DateTime.now().year, DateTime.now().month - 1,
//           DateTime.now().day - 3),
//       nominal: 3000),
//   DailyFinance(
//       deskripsi: "test 2",
//       datetime: DateTime(
//           DateTime.now().year, DateTime.now().month, DateTime.now().day - 2),
//       nominal: 3000),
//   DailyFinance(
//       deskripsi: "test 3",
//       datetime: DateTime(
//           DateTime.now().year, DateTime.now().month, DateTime.now().day - 7),
//       nominal: 3000),
// ];

class ListFinanceHelper {
  List<MonthlyFinance> listMonthlyFinance;
  List<DailyFinance> listFinance;

  ListFinanceHelper(
      {required this.listFinance, required this.listMonthlyFinance});
}

List<String> items = [
  "Piring Keramik",
  "Lampu Meja",
  "Topi Denim",
  "Sandal Jepit",
  "Gelas Plastik",
  "Buku Catatan Spiral",
  "Sapu Serat",
  "Sepatu Sneakers",
  "Tas Selempang",
  "Senter LED",
  "Payung Lipat",
  "Jam Dinding",
  "Sendok Stainless Steel",
  "Kursi Lipat",
  "Gantungan Kunci Akrilik",
  "Mangkok Melamin",
  "Kipas Angin Meja",
  "Kaos Cotton",
  "Sendal Rumah",
  "Mug Keramik",
  "Pulpen Gel",
  "Sikat Toilet Plastik",
  "Dompet Kulit",
  "Kamera Disposable",
  "Tempat Tidur Lipat"
];

ListFinanceHelper generateList(int N) {
  Random random = Random();
  ListFinanceHelper result =
      ListFinanceHelper(listFinance: [], listMonthlyFinance: []);

  for (var i = 0; i < N; i++) {
    DateTime randomDate =
        DateTime.now().subtract(Duration(days: random.nextInt(300)));
    result.listMonthlyFinance.add(MonthlyFinance(
      nominal: random.nextInt(100) * 100000,
      datetime: DateTime(randomDate.year, randomDate.month, 1, 0, 0, 0, 0),
    ));
    for (var j = 0; j < 3; j++) {
      var randomBinary = random.nextDouble();
      String text = (randomBinary < 0.5) ? 'Jual' : 'Beli';
      String status = (randomBinary < 0.5) ? 'Uang Keluar' : 'Uang Masuk';
      int randomIndex = Random().nextInt(items.length);
      result.listFinance.add(DailyFinance(
          deskripsi: '$text ${items[randomIndex]}',
          status: status,
          datetime: DateTime(
              randomDate.year,
              randomDate.month,
              DateTime.now().subtract(Duration(days: random.nextInt(30))).day,
              0,
              0,
              0,
              0),
          nominal: random.nextInt(100) * 1000));
    }
  }

  return result;
}
