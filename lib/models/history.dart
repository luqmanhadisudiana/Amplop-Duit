import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History {
  final int idCourse, attempt;
  final String title, question, jawaban;
  final bool status;

  const History(
      {required this.idCourse,
      required this.status,
      required this.attempt,
      required this.title,
      required this.question,
      required this.jawaban});

  Map<String, dynamic> toJson() {
    return {
      'idCourse': idCourse,
      'status': status,
      'attempt': attempt,
      'title': title,
      'question': question,
      'jawaban': jawaban,
    };
  }

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
        idCourse: json['idCourse'],
        status: json['status'],
        attempt: json['attempt'],
        title: json['title'],
        question: json['question'],
        jawaban: json['jawaban']);
  }
}

class HistoryList extends ChangeNotifier {
  List<History> listHistory;

  HistoryList({
    List<History>? initialList,
  }) : listHistory = initialList ?? [];

  void addHistory(History history) {
    listHistory.add(history);
    notifyListeners();
  }

  bool isDuplicate(int attempt, String title) {
    for (var data in listHistory) {
      if (data.attempt == attempt && data.title == title) {
        return true;
      }
    }

    return false;
  }

  double getSuccesRate() {
    debugPrint("${listHistory.length}");
    if (listHistory.isEmpty) {
      return 0;
    }

    int totalTrueCount = listHistory.where((history) => history.status).length;
    int totalAttempts = listHistory.length;

    double percentage = (totalTrueCount / totalAttempts) * 100;
    return percentage;
  }

  Future<void> saveToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> jsonList =
        listHistory.map((history) => jsonEncode(history.toJson())).toList();
    await prefs.setStringList('historyList', jsonList);
  }

  Future<void> loadFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList('historyList');
    debugPrint("get historyList");
    if (jsonList != null) {
      listHistory = jsonList
          .map<History>((json) =>
              History.fromJson(jsonDecode(json) as Map<String, dynamic>))
          .toList();
      notifyListeners();
      debugPrint("done... ${listHistory.length}");
    } else {
      // Jika jsonList kosong, inisialisasi listHistory dengan list kosong
      listHistory = [];
      notifyListeners();
    }
  }

  Future<void> resetMyObject() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("historyList");

    // Set listSavedAnswer to an empty list
    listHistory = [];

    // Load from SharedPreferences to refresh the list
    await loadFromSharedPreferences();

    notifyListeners();
  }
}
