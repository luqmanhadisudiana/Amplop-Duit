import 'package:amplop_duit/component/answerContainer/answer_container.dart';
import 'package:amplop_duit/component/appbar/course_appbar.dart';
import 'package:amplop_duit/component/customBottomModal/custom_bottom_modal.dart';
import 'package:amplop_duit/models/course.dart';
import 'package:amplop_duit/provider.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseQuiz extends StatefulWidget {
  final String question, thumbnailUrl;
  final int quizIndex, courseIndex;
  final List<Answer> listAnswer;

  const CourseQuiz(
      {super.key,
      required this.question,
      required this.thumbnailUrl,
      required this.listAnswer,
      required this.courseIndex,
      required this.quizIndex});

  @override
  State<CourseQuiz> createState() => _CourseQuizState();
}

class _CourseQuizState extends State<CourseQuiz> {
  late CourseProvider courseProvider;
  late CoursePointerProvider coursePointerProvider;
  int selectedIndex = -1;
  bool isButtonDisable = false;
  late String buttonText;

  @override
  Widget build(BuildContext context) {
    // provider
    courseProvider = Provider.of<CourseProvider>(context, listen: false);
    coursePointerProvider =
        Provider.of<CoursePointerProvider>(context, listen: false);
    debugPrint(courseProvider
        .getQuestionStatus(widget.courseIndex, widget.quizIndex)
        .toString());
    debugPrint('course : ${widget.courseIndex}, quiz : ${widget.quizIndex}');
    buttonText =
        courseProvider.getQuestionStatus(widget.courseIndex, widget.quizIndex)
            ? "Kembali"
            : "Berikutnya";

    return MaterialApp(
        title: 'Quiz',
        theme: MyAppTheme.buildTheme(),
        home: Scaffold(
          appBar: CourseAppbar(
              title: "My Course",
              heartCount: 5,
              diamondCount: 5,
              parentContext: context),
          body: ListView(children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      child: Image.asset(
                        widget.thumbnailUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 24, top: 16),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Level ${widget.courseIndex + 1}, Bagian ${widget.quizIndex}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Dari video sebelumnya, berikut apa aspek yang harus diperhatikan dalam mencatat keuangan?",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ]),
                  ),
                  for (int i = 0; i < widget.listAnswer.length; i++)
                    AnswerContainer(
                      text: widget.listAnswer[i].text,
                      index: i,
                      bgColor: i == selectedIndex
                          ? (widget.listAnswer[i].status
                              ? Colors.blue
                              : Colors.red)
                          : Colors.white,
                      action: isButtonDisable
                          ? null
                          : () {
                              // debugPrint(
                              //     widget.listAnswer[i].status.toString());
                              setState(() {
                                selectedIndex = i;
                                isButtonDisable = true;
                              });
                              showCustomBottomSheet(context,
                                  widget.listAnswer[i].status, buttonText, () {
                                if (courseProvider.getQuestionStatus(
                                        widget.courseIndex, widget.quizIndex) ==
                                    false) {
                                  coursePointerProvider.nextQuiz();
                                  courseProvider.updateQuestionStatus(
                                      widget.courseIndex,
                                      widget.quizIndex,
                                      true);
                                }

                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            },
                    )
                ],
              ),
            ),
          ]),
        ));
  }
}
