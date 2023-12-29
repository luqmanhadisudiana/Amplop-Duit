import 'package:amplop_duit/models/course.dart';
import 'package:flutter/foundation.dart';

class CourseProvider with ChangeNotifier {
  List<Course> listCourse = courseList;

  void reset() {
    listCourse = courseList;
  }

  List<Course> get getCourseList => listCourse;

  Course getCourseByIndex(int index) {
    return listCourse[index];
  }

  int getCourseFeedback(int index) {
    return listCourse[index].feedback;
  }

  void updateFeedbackCourse(int indexCourse, int newFeedback) {
    listCourse[indexCourse].feedback = newFeedback;
    notifyListeners();
  }

  void updateSavedAnswer(int indexCourse, int indexQuiz, int indexOfAnswer) {
    listCourse[indexCourse].listQuestionAnswer[indexQuiz].savedAnswer =
        indexOfAnswer;
    notifyListeners();
  }

  int getSavedAnswer(int indexCourse, int indexQuiz) {
    return listCourse[indexCourse].listQuestionAnswer[indexQuiz].savedAnswer;
  }
}
