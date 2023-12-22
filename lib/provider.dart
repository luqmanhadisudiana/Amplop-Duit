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

  void setIsDone(int indexCourse, int indexQuestion) {
    listCourse[indexCourse].listQuestionAnswer[indexQuestion].isDone = true;
    notifyListeners();
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

  bool getIsDone(int indexCourse, int indexQuiz) {
    return listCourse[indexCourse].listQuestionAnswer[indexQuiz].isDone;
  }
}

//
// class CoursePointerProvider with ChangeNotifier, DiagnosticableTreeMixin {
//   int selectedCourse = 0;
//   int selectedQuiz = -1;

//   int get getSelectedCourse => selectedCourse;
//   int get getselectedQuiz => selectedQuiz;

//   void setNewValue(int courseIndex, int quizIndex) {
//     selectedCourse = courseIndex;
//     selectedQuiz = quizIndex;
//     notifyListeners();
//   }

//   void updateSelectedCourseByID(int id) {
//     selectedCourse = id;
//     notifyListeners();
//   }

//   void updateselectedCourseByIndex(int index) {
//     selectedCourse = index;
//     notifyListeners();
//   }

//   void nextCourse() {
//     selectedCourse = selectedCourse + 1;
//     //reset quiz index
//     selectedQuiz = -1;
//     notifyListeners();
//   }

//   void nextQuiz() {
//     selectedQuiz = selectedQuiz + 1;
//     notifyListeners();
//   }
// }
