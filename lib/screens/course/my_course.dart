import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/card/card_thumbnail.dart';
import 'package:amplop_duit/component/customAlertDialog/custom_alert_dialog.dart';
import 'package:amplop_duit/component/informationLevel/information_level.dart';
import 'package:amplop_duit/component/stepCourse/step_course.dart';
import 'package:amplop_duit/models/course.dart';
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
  late CoursePointerProvider coursePointerProvider;
  late CourseProvider courseProvider;
  late int selectedQuiz, selectedCourse;
  late Course course;
  late String headlineTitle, headlineDesc, thumbailUrl;

  @override
  void initState() {
    super.initState();
  }

  void navigateToQuiz(index) {
    debugPrint("Quiz");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CourseQuiz(
              question: course.listQuestionAnswer[index].question,
              thumbnailUrl: course.videoThumbail,
              listAnswer: course.listQuestionAnswer[index].answerList,
              courseIndex: coursePointerProvider.getSelectedCourse,
              quizIndex: coursePointerProvider.getselectedQuiz)),
    );
  }

  @override
  Widget build(BuildContext context) {
    courseProvider = Provider.of<CourseProvider>(context);
    coursePointerProvider = Provider.of<CoursePointerProvider>(context);
    selectedQuiz = coursePointerProvider.getselectedQuiz;
    selectedCourse = coursePointerProvider.getSelectedCourse;

    course = courseProvider.getCourseByIndex(selectedCourse);
    debugPrint('index quiz : ${selectedQuiz.toString()}');

    headlineTitle = course.headline.title;
    headlineDesc = course.headline.desc;
    thumbailUrl = course.videoThumbail;

    return MaterialApp(
      title: 'Course',
      theme: MyAppTheme.buildTheme(),
      home: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  "My Course",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const Icon(Icons.add),
              ],
            ),
          ),
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
                      child: CardThumbnail(imageUrl: thumbailUrl),
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
                                  index: (coursePointerProvider
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
                                  onTap: i < selectedQuiz
                                      ? () {
                                          navigateToQuiz(i);
                                        }
                                      : null,
                                  child: StepCourse(
                                    text: (i + 1).toString(),
                                    isDone: i < selectedQuiz,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: i < selectedQuiz
                                      ? () {
                                          navigateToQuiz(i);
                                        }
                                      : null,
                                  child: StepCourse(
                                    text: (i + 1).toString(),
                                    isDone: i < selectedQuiz,
                                  ),
                                ),
                              ],
                            ),
                    Center(
                      child: MainButton(
                          isDisabled: coursePointerProvider.getselectedQuiz <
                              course.listQuestionAnswer.length,
                          width: 280,
                          buttonText: "Level Selanjutnya",
                          action: () {
                            debugPrint(
                                "Level Selanjutnya ${coursePointerProvider.getSelectedCourse + 1}");

                            if (coursePointerProvider.getSelectedCourse ==
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
                              coursePointerProvider.nextCourse();
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
