import 'package:amplop_duit/models/course.dart';
import 'package:flutter/material.dart';

class CourseProvider with ChangeNotifier {
  List<Course> listCourse = courseList;

  List<Course> get getCourseList => listCourse;

  void updateQuestionStatus(
      int indexCourse, int indexQuestion, bool newStatus) {
    listCourse[indexCourse].listQuestionAnswer[indexQuestion].isDone =
        newStatus;
    notifyListeners(); // memberi tahu pendengar tentang perubahan
  }
}

class CoursePointerProvider with ChangeNotifier {
  int selectedCourse = courseList[0].id;
  int selectedQuiz = 0;

  int get getSelectedCourse => selectedCourse;
  int get getselectedQuiz => selectedQuiz;

  void updateSelectedCourse(int id) {
    selectedCourse = id;
    notifyListeners();
  }

  void updateselectedCourse(int index) {
    selectedCourse = index;
    notifyListeners();
  }
}
