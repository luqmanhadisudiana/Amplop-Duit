import 'package:amplop_duit/component/answerContainer/answer_container.dart';
import 'package:amplop_duit/component/appbar/course_appbar.dart';
import 'package:amplop_duit/component/customBottomModal/custom_bottom_modal.dart';
import 'package:amplop_duit/models/course.dart';
import 'package:amplop_duit/models/history.dart';
import 'package:amplop_duit/models/my_course_status.dart';
import 'package:amplop_duit/provider.dart';
import 'package:amplop_duit/screens/confirmation_and_report/confirmation_page.dart';
import 'package:amplop_duit/screens/course/my_course.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class CourseQuiz extends StatefulWidget {
  final String question, thumbnailUrl;
  final int quizIndex, courseIndex;
  final List<Answer> listAnswer;
  final bool finalQuiz;

  const CourseQuiz(
      {super.key,
      required this.question,
      required this.thumbnailUrl,
      required this.listAnswer,
      required this.courseIndex,
      required this.quizIndex,
      this.finalQuiz = false});

  @override
  State<CourseQuiz> createState() => _CourseQuizState();
}

class _CourseQuizState extends State<CourseQuiz> {
  late CourseProvider courseProvider;
  late MyCourseStatus myCourseStatusProvider;
  late ListSavedAnswer listSavedAnswer;
  late HistoryList listHistory;

  int selectedIndex = -1;
  late int currentIndex;
  late bool isButtonDisable;
  late String buttonText;

  @override
  void initState() {
    super.initState();
    debugPrint("======================================================");
    // provider
    courseProvider = Provider.of<CourseProvider>(context, listen: false);
    myCourseStatusProvider =
        Provider.of<MyCourseStatus>(context, listen: false);
    listSavedAnswer = Provider.of<ListSavedAnswer>(context, listen: false);
    int courseIdx = widget.courseIndex;
    int quizIdx = widget.quizIndex;
    bool quizStatus = courseProvider.getIsDone(courseIdx, quizIdx);
    int savedAnswer = listSavedAnswer.getSavedAnswer(courseIdx, quizIdx);

    debugPrint(quizStatus.toString());
    debugPrint(
      'course : $courseIdx, quiz : $quizIdx, savedAnswer : $savedAnswer, quizStatus : $quizStatus',
    );

    isButtonDisable = quizStatus == true && savedAnswer != -1 ? true : false;
    // buttonText = quizStatus ? "Kembali" : "Berikutnya";
    currentIndex = savedAnswer;

    if (quizStatus == true && savedAnswer == -1) {
      debugPrint("Kembali");
      buttonText = "Kembali";
    } else {
      debugPrint("Berikutnya");
      buttonText = "Berikutnya";
    }

    if (currentIndex != -1) {
      selectedIndex = currentIndex;
    }
  }

  void modalAction(i) async {
    listSavedAnswer = Provider.of<ListSavedAnswer>(context, listen: false);
    listHistory = Provider.of<HistoryList>(context, listen: false);
    courseProvider = Provider.of<CourseProvider>(context, listen: false);
    myCourseStatusProvider =
        Provider.of<MyCourseStatus>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool answerStatus = widget.listAnswer[i].status;
    int courseIdx = widget.courseIndex;
    int quizIdx = widget.quizIndex;
    bool quizStatus = courseProvider.getIsDone(courseIdx, quizIdx);
    int savedAnswer = courseProvider.getSavedAnswer(courseIdx, quizIdx);
    int currentQuizPointer = myCourseStatusProvider.selectedQuiz;
    int indexAnswer = i;
    debugPrint(
        "indexAnswer $indexAnswer,\nCourse Index : $courseIdx,\nQuiz Index : $quizIdx,\nPointerQuiz : $currentQuizPointer,\nSelected Index : $selectedIndex,\nQuestion Status: : $answerStatus,\nquizStatus : $quizStatus,\nSaved Value : $savedAnswer\n\n");

    setState(() {
      selectedIndex = indexAnswer;
    });

    debugPrint("check apakah jawaban benar ${answerStatus == true}");
    if (answerStatus == true) {
      courseProvider.updateSavedAnswer(courseIdx, quizIdx, indexAnswer);
      listSavedAnswer.addSavedAnswer(MySavedAnswer(
        courseIndex: courseIdx,
        quizIndex: quizIdx,
        indexSavedAnswer: indexAnswer,
      ));
      listSavedAnswer.saveToSharedPreferences();
    } else {
      setState(() {
        myCourseStatusProvider.decreaseHeart();
      });
    }

    debugPrint("check next quiz ${currentQuizPointer == quizIdx}");
    if (currentQuizPointer == quizIdx) {
      myCourseStatusProvider.nextQuiz();
    }

    if (!quizStatus) {
      myCourseStatusProvider.start();
      listHistory.addHistory(History(
          idCourse: courseIdx,
          status: answerStatus,
          attempt: myCourseStatusProvider.attempt,
          title: "Level ${courseIdx + 1}, Bagian ${quizIdx + 1}",
          question: widget.question,
          jawaban: widget.listAnswer[indexAnswer].text));
      listHistory.saveToSharedPreferences();
    }

    if (!quizStatus && answerStatus == true) {
      int currentTP = prefs.getInt("totalPoint") ?? 0;
      await prefs.setInt('totalPoint', currentTP + 3);
    }

    debugPrint("setIsDone, ${courseProvider.getIsDone(courseIdx, quizIdx)}");
    courseProvider.setIsDone(courseIdx, quizIdx);

    debugPrint('${myCourseStatusProvider.attempt}');
    myCourseStatusProvider.saveSharedPreferences();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCustomBottomSheet(context, answerStatus, buttonText, () {
        debugPrint("Modal Clicked");
        if (widget.finalQuiz) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ConfirmationPage()));
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const MyCoursePage()),
              (Route<dynamic> route) => route.isFirst);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Quiz',
        theme: MyAppTheme.buildTheme(),
        home: Scaffold(
          appBar: CourseAppbar(
            title: "My Course",
            parentContext: context,
          ),
          body: ListView(children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: double.maxFinite,
                                height: 150.0,
                                color: Colors.white,
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
                            "Level ${widget.courseIndex + 1}, Bagian ${widget.quizIndex + 1}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.question,
                            style: const TextStyle(
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
