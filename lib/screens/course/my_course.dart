import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/card/card_thumbnail.dart';
import 'package:amplop_duit/component/informationLevel/information_level.dart';
import 'package:amplop_duit/component/stepCourse/step_course.dart';
import 'package:amplop_duit/models/course.dart';
import 'package:amplop_duit/provider.dart';
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
                    for (var i = 1; i <= 5; i++)
                      GestureDetector(
                        onTap: i <= selectedQuiz
                            ? () {
                                debugPrint("bisa ditap");
                                coursePointerProvider.updateQuiz();
                                debugPrint(coursePointerProvider.getselectedQuiz
                                    .toString());
                              }
                            : null,
                        child: StepCourse(
                          text: i.toString(),
                          isDone: i <= selectedQuiz,
                        ),
                      ),
                    Center(
                      child: MainButton(
                          width: 280,
                          buttonText: "Level Selanjutnya",
                          action: () {
                            debugPrint("Level Selanjutnya");
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
