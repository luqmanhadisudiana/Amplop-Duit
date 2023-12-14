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
  late int currentIndex;
  // late bool isButtonDisable;
  late String buttonText;

  @override
  void initState() {
    super.initState();
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

    currentIndex =
        courseProvider.getSelectedAnswer(widget.courseIndex, widget.quizIndex);

    if (currentIndex != -1) {
      selectedIndex = currentIndex;
    }

    // isButtonDisable =
    //     courseProvider.getQuestionStatus(widget.courseIndex, widget.quizIndex);
  }

  void modalAction(i) {
    setState(() {
      selectedIndex = i;
    });
    showCustomBottomSheet(context, widget.listAnswer[i].status, buttonText, () {
      debugPrint(courseProvider
          .getQuestionStatus(widget.courseIndex, widget.quizIndex)
          .toString());
      if (courseProvider.getQuestionStatus(
              widget.courseIndex, widget.quizIndex) ==
          false) {
        debugPrint("Valid");
        if (widget.quizIndex != 0) {
          if (courseProvider.getSelectedAnswer(
                  widget.courseIndex, widget.quizIndex - 1) !=
              -1) {
            debugPrint("nextQuiz");
            coursePointerProvider.nextQuiz();
          }
        } else {
          debugPrint("nextQuiz");
          coursePointerProvider.nextQuiz();
        }

        debugPrint(
            '87, Course Index : ${widget.courseIndex}, Quiz Index : ${widget.quizIndex}, Selected Index : $selectedIndex, Status : ${widget.listAnswer[i].status}');

        if (widget.listAnswer[i].status) {
          debugPrint("updateQuestionStatus");
          courseProvider.updateQuestionStatus(
              widget.courseIndex, widget.quizIndex, true);
          debugPrint("updateSelectedAnswer");
          courseProvider.updateSelectedAnswer(
              widget.courseIndex, widget.quizIndex, selectedIndex);
        } else {
          debugPrint("Not Valid");
        }
      }

      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // selectedIndex =
    // courseProvider.getSelectedAnswer(widget.courseIndex, widget.quizIndex);
    // debugPrint(selectedIndex.toString());

    // isButtonDisable =
    //     courseProvider.getQuestionStatus(widget.courseIndex, widget.quizIndex);
    // debugPrint(isButtonDisable.toString());
    debugPrint(
        'Question Status: ${courseProvider.getQuestionStatus(widget.courseIndex, widget.quizIndex)}, Course Index : ${widget.courseIndex}, Quiz Index : ${widget.quizIndex}, Saved Value : ${courseProvider.getSelectedAnswer(widget.courseIndex, widget.quizIndex)}');
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
                      child: Image.network(
                        widget.thumbnailUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          // Menampilkan widget pengganti ketika terjadi kesalahan
                          return Container(
                            alignment: Alignment.center,
                            width: 50.0,
                            height: 50.0,
                            color: Colors.red,
                            child: const Icon(Icons.error, color: Colors.white),
                          );
                        },
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
                      action:
                          // isButtonDisable
                          //     ? null
                          //     :
                          () {
                        modalAction(i);
                      },
                    )
                ],
              ),
            ),
          ]),
        ));
  }
}
