import 'package:flutter/foundation.dart';

class MyCourseStatus extends ChangeNotifier {
  int heart;
  int diamond;
  int selectedCourse;
  int selectedQuiz;

  MyCourseStatus({
    this.heart = 5,
    this.diamond = 5,
    this.selectedCourse = 0,
    this.selectedQuiz = -1,
  });

  Map<String, dynamic> toMap() {
    return {
      'heart': heart,
      'diamond': diamond,
      'selectedCourse': selectedCourse,
      'selectedQuiz': selectedQuiz,
    };
  }

  factory MyCourseStatus.fromMap(Map<String, dynamic> map) {
    return MyCourseStatus(
      heart: map['heart'],
      diamond: map['diamond'],
      selectedCourse: map['selectedCourse'] ?? 0,
      selectedQuiz: map['selectedQuiz'] ?? -1,
    );
  }

  void reset() {
    heart = 5;
    diamond = 5;
    selectedCourse = 0;
    selectedQuiz = -1;
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
    //reset quiz index
    selectedQuiz = -1;
    notifyListeners();
  }

  void nextQuiz() {
    selectedQuiz = selectedQuiz + 1;
    notifyListeners();
  }
}
