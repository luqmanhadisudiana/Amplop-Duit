import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCourseStatus extends ChangeNotifier {
  int heart;
  int diamond;
  int selectedCourse;
  int selectedQuiz;
  int attempt;

  MyCourseStatus({
    this.heart = 5,
    this.diamond = 5,
    this.selectedCourse = 0,
    this.selectedQuiz = -1,
    this.attempt = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'heart': heart,
      'diamond': diamond,
      'selectedCourse': selectedCourse,
      'selectedQuiz': selectedQuiz,
      'attempt': attempt,
    };
  }

  factory MyCourseStatus.fromMap(Map<String, dynamic> map) {
    return MyCourseStatus(
        heart: map['heart'],
        diamond: map['diamond'],
        selectedCourse: map['selectedCourse'] ?? 0,
        selectedQuiz: map['selectedQuiz'] ?? -1,
        attempt: map['attempt']);
  }

  void start() {
    if (attempt == 0) {
      attempt += 1;
    }
    notifyListeners();
  }

  void reset() {
    heart = 5;
    diamond = 5;
    selectedCourse = 0;
    selectedQuiz = -1;
    attempt = 0;
    notifyListeners();
  }

  void setHeart(int newValue) {
    heart = newValue;
    notifyListeners();
  }

  void setDiamond(int newValue) {
    diamond = newValue;
    notifyListeners();
  }

  void decreaseHeart() {
    heart = heart - 1;
    notifyListeners();
  }

  void decreaseDiamond() {
    diamond = diamond - 1;
    heart = 5;
    attempt = attempt + 1;

    notifyListeners();
  }

  int get getSelectedCourse => selectedCourse;
  int get getselectedQuiz => selectedQuiz;

  void setNewValue(
      int newHeart, int newDiamond, int courseIndex, int quizIndex) {
    selectedCourse = courseIndex;
    selectedQuiz = quizIndex;
    heart = newHeart;
    diamond = newDiamond;
    notifyListeners();
  }

  void updateSelectedCourseByID(int id) {
    selectedCourse = id;
    notifyListeners();
  }

  void updateSelectedCourseByIndex(int index) {
    selectedCourse = index;
    notifyListeners();
  }

  void nextCourse() {
    selectedCourse = selectedCourse + 1;
    selectedQuiz = -1;
    notifyListeners();
  }

  void nextQuiz() {
    selectedQuiz = selectedQuiz + 1;
    notifyListeners();
  }

  Future<void> saveSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String myObjectString = json.encode(toMap());
    await prefs.setString('myCourseStatus', myObjectString);
  }

  Future<void> loadFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? myObjectString = prefs.getString('myCourseStatus');

    if (myObjectString != null) {
      final Map<String, dynamic> myObjectMap = json.decode(myObjectString);
      MyCourseStatus savedStatus = MyCourseStatus.fromMap(myObjectMap);

      // Assign saved values to the current instance
      heart = savedStatus.heart;
      diamond = savedStatus.diamond;
      selectedCourse = savedStatus.selectedCourse;
      selectedQuiz = savedStatus.selectedQuiz;
      attempt = savedStatus.attempt;

      notifyListeners();
    }
  }

  Future<void> resetMyObject() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("myCourseStatus");
    heart = 5;
    diamond = 5;
    selectedCourse = 0;
    selectedQuiz = -1;
    attempt = 0;
    notifyListeners();
  }
}

class MySavedAnswer {
  final int quizIndex, courseIndex, indexSavedAnswer;

  MySavedAnswer(
      {required this.quizIndex,
      required this.courseIndex,
      required this.indexSavedAnswer});

  Map<String, dynamic> toJson() {
    return {
      'quizIndex': quizIndex,
      'courseIndex': courseIndex,
      'indexSavedAnswer': indexSavedAnswer
    };
  }

  factory MySavedAnswer.fromJson(Map<String, dynamic> json) {
    return MySavedAnswer(
        quizIndex: json['quizIndex'],
        courseIndex: json['courseIndex'],
        indexSavedAnswer: json['indexSavedAnswer']);
  }
}

class ListSavedAnswer extends ChangeNotifier {
  List<MySavedAnswer> listSavedAnswer;

  ListSavedAnswer({
    List<MySavedAnswer>? initialList,
  }) : listSavedAnswer = initialList ?? [];

  void addSavedAnswer(MySavedAnswer savedAnswer) {
    listSavedAnswer.add(savedAnswer);
    notifyListeners();
  }

  void removeSavedAnswer(int index) {
    listSavedAnswer.removeAt(index);
    notifyListeners();
  }

  int getSavedAnswer(int courseIndex, int quizIndex) {
    int tempSavedAnswer = -1;
    for (var i = 0; i < listSavedAnswer.length; i++) {
      if (listSavedAnswer[i].courseIndex == courseIndex) {
        if (listSavedAnswer[i].quizIndex == quizIndex) {
          tempSavedAnswer = listSavedAnswer[i].indexSavedAnswer;
        }
      }
    }
    return tempSavedAnswer;
  }

  Future<void> saveToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> jsonList =
        listSavedAnswer.map((answer) => jsonEncode(answer.toJson())).toList();
    await prefs.setStringList('savedAnswers', jsonList);
  }

  Future<void> loadFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList('savedAnswers');
    debugPrint("get savedAnswers");
    if (jsonList != null) {
      listSavedAnswer = jsonList
          .map<MySavedAnswer>((json) =>
              MySavedAnswer.fromJson(jsonDecode(json) as Map<String, dynamic>))
          .toList();
      debugPrint("done...");
    } else {
      listSavedAnswer = [];
    }

    notifyListeners();
  }

  Future<void> resetMyObject() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("savedAnswers");

    // Set listSavedAnswer to an empty list
    listSavedAnswer = [];

    // Load from SharedPreferences to refresh the list
    await loadFromSharedPreferences();

    notifyListeners();
  }
}
