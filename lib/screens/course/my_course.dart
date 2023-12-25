import 'package:amplop_duit/component/appbar/course_appbar.dart';
import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/card/card_thumbnail.dart';
import 'package:amplop_duit/component/customAlertDialog/custom_alert_dialog.dart';
import 'package:amplop_duit/component/informationLevel/information_level.dart';
import 'package:amplop_duit/component/stepCourse/step_course.dart';
import 'package:amplop_duit/layout/navigation_wrapper.dart';
import 'package:amplop_duit/models/course.dart';
import 'package:amplop_duit/models/my_course_status.dart';
import 'package:amplop_duit/provider.dart';
import 'package:amplop_duit/screens/course/course_quiz.dart';
import 'package:amplop_duit/screens/course/course_video.dart';
import 'package:flutter/material.dart';
import 'package:amplop_duit/theme.dart';
import 'package:provider/provider.dart';

class MyCoursePage extends StatefulWidget {
  const MyCoursePage({super.key});

  @override
  State<MyCoursePage> createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage> {
  late CourseProvider courseProvider;
  late int selectedQuiz, selectedCourse;
  late Course course;
  late String headlineTitle, headlineDesc, thumbailUrl;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAlertDialog();
    });
  }

  void showAlertDialog() {
    var myCourseStatusProvider =
        Provider.of<MyCourseStatus>(context, listen: false);

    if (myCourseStatusProvider.diamond == 0) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => CustomAlertDialog(
          title: "Diamond Anda Telah Habis",
          desc: "Silahkan melanjutkan pada besok hari",
          action: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const NavigationWrapper()),
            );
          },
        ),
      );
    }

    if (myCourseStatusProvider.heart == 0 &&
        myCourseStatusProvider.diamond != 0) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => CustomAlertDialog(
          title: "Nyawa Anda Telah Habis",
          desc: "Untuk Melanjutkan tukarkan Diamond dengan 5 Nyawa",
          actions: [
            ActionItem(
              text: "Tidak",
              color: const Color(0xFFCC3E57),
              onPressed: () {
                debugPrint("Cancel button clicked!");
                Navigator.pop(context);
              },
            ),
            ActionItem(
              text: "Ya",
              color: const Color(0xFF339933),
              onPressed: () {
                debugPrint("Ya button clicked!");
                Navigator.pop(context);
                myCourseStatusProvider.decreaseDiamond();
                myCourseStatusProvider.saveSharedPreferences();
              },
            ),
          ],
        ),
      );
    }
  }

  void navigateToQuiz(
      question, thumbnailUrl, listAnswer, courseIndex, quizIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CourseQuiz(
              question: question,
              thumbnailUrl: thumbnailUrl,
              listAnswer: listAnswer,
              courseIndex: courseIndex,
              quizIndex: quizIndex)),
    ).then((value) => {
          if (value != null && value == true) {initState()}
        });
  }

  @override
  Widget build(BuildContext context) {
    courseProvider = Provider.of<CourseProvider>(context);
    var myCourseStatusProvider = context.watch<MyCourseStatus>();
    selectedQuiz = myCourseStatusProvider.getselectedQuiz;
    selectedCourse = myCourseStatusProvider.getSelectedCourse;
    course = courseProvider.getCourseByIndex(selectedCourse);
    debugPrint('index quiz : ${selectedQuiz.toString()}');

    headlineTitle = course.headline.title;
    headlineDesc = course.headline.desc;
    thumbailUrl = course.videoThumbail;

    return MaterialApp(
      title: 'Course',
      theme: MyAppTheme.buildTheme(),
      home: Scaffold(
          appBar: CourseAppbar(
              title: "My Course",
              // heartCount: myCourseStatusProvider.heart,
              // diamondCount: myCourseStatusProvider.diamond,
              parentContext: context),
          body: ListView(
            children: [
              InformationLevel(title: headlineTitle, desc: headlineDesc),
              // Main List
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      child: CardThumbnail(
                        imageUrl: thumbailUrl,
                        isNetwork: true,
                      ),
                      onTap: () {
                        debugPrint("Course Video");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CourseVideo(
                                  title: course.title,
                                  description: course.description,
                                  ytVideoID: course.ytVideoID,
                                  currentFeedback: course.feedback,
                                  index: (myCourseStatusProvider
                                      .getSelectedCourse))),
                        );
                      },
                    ),
                    for (var i = 0; i < 5; i++)
                      i % 2 == 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: i <= selectedQuiz
                                      ? () {
                                          if (myCourseStatusProvider.heart ==
                                              0) {
                                            showAlertDialog();
                                          } else {
                                            navigateToQuiz(
                                                course.listQuestionAnswer[i]
                                                    .question,
                                                thumbailUrl,
                                                course.listQuestionAnswer[i]
                                                    .answerList,
                                                selectedCourse,
                                                i);
                                          }
                                        }
                                      : null,
                                  child: StepCourse(
                                    text: (i + 1).toString(),
                                    available: i <= selectedQuiz,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: i <= selectedQuiz
                                      ? () {
                                          if (myCourseStatusProvider.heart ==
                                              0) {
                                            showAlertDialog();
                                          } else {
                                            navigateToQuiz(
                                                course.listQuestionAnswer[i]
                                                    .question,
                                                thumbailUrl,
                                                course.listQuestionAnswer[i]
                                                    .answerList,
                                                selectedCourse,
                                                i);
                                          }
                                        }
                                      : null,
                                  child: StepCourse(
                                    text: (i + 1).toString(),
                                    available: i <= selectedQuiz,
                                  ),
                                ),
                              ],
                            ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: MainButton(
                          isDisabled: myCourseStatusProvider.getselectedQuiz <
                              course.listQuestionAnswer.length,
                          width: 280,
                          buttonText: "Level Selanjutnya",
                          action: () {
                            debugPrint(
                                "Level Selanjutnya ${myCourseStatusProvider.getSelectedCourse + 1}");

                            if (myCourseStatusProvider.getSelectedCourse ==
                                courseProvider.getCourseList.length - 1) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    const CustomAlertDialog(
                                  title: "Course Telah Selasai",
                                  desc: "",
                                ),
                              );
                            } else {
                              myCourseStatusProvider.nextCourse();
                              myCourseStatusProvider.saveSharedPreferences();
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
