import 'package:amplop_duit/models/course.dart';
import 'package:flutter/foundation.dart';

class CourseProvider with ChangeNotifier {
  List<Course> listCourse = courseList;

  List<Course> get getCourseList => listCourse;

  Course getCourseByIndex(int index) {
    return listCourse[index];
  }

  int getCourseFeedback(int index) {
    return listCourse[index].feedback;
  }

  void updateQuestionStatus(
      int indexCourse, int indexQuestion, bool newStatus) {
    listCourse[indexCourse].listQuestionAnswer[indexQuestion].isDone =
        newStatus;
    notifyListeners();
  }

  void updateFeedbackCourse(int indexCourse, int newFeedback) {
    listCourse[indexCourse].feedback = newFeedback;
    notifyListeners();
  }
}

class CoursePointerProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int selectedCourse = 0;
  int selectedQuiz = 0;

  int get getSelectedCourse => selectedCourse;
  int get getselectedQuiz => selectedQuiz;

  void updateSelectedCourseByID(int id) {
    selectedCourse = id;
    notifyListeners();
  }

  void updateselectedCourseByIndex(int index) {
    selectedCourse = index;
    notifyListeners();
  }

  void updateCourse() {
    selectedCourse = selectedCourse + 1;
    selectedQuiz = 0;
    notifyListeners();
  }

  void updateQuiz() {
    selectedQuiz = selectedQuiz + 1;
    notifyListeners();
  }
}
