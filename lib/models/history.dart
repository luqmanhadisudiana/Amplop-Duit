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

  Future<void> saveToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> jsonList =
        listHistory.map((history) => jsonEncode(history.toJson())).toList();
    await prefs.setStringList('historyList', jsonList);
  }

  Future<void> loadFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList('historyList');

    if (jsonList != null) {
      listHistory = jsonList
          .map<History>((json) =>
              History.fromJson(jsonDecode(json) as Map<String, dynamic>))
          .toList();
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
