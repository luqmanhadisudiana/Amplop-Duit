import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/card/card_thumbnail.dart';
import 'package:amplop_duit/component/informationLevel/information_level.dart';
import 'package:amplop_duit/component/stepCourse/step_course.dart';
import 'package:amplop_duit/provider.dart';
import 'package:amplop_duit/screens/course/course_video.dart';
import 'package:flutter/material.dart';
import 'package:amplop_duit/theme.dart';

class MyCoursePage extends StatefulWidget {
  const MyCoursePage({super.key});

  @override
  State<MyCoursePage> createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage> {
  late CoursePointerProvider coursePointerProvider;
  late int selectedQuiz;

  @override
  void initState() {
    super.initState();
    coursePointerProvider = CoursePointerProvider();
    selectedQuiz = coursePointerProvider.getselectedQuiz;
    debugPrint(selectedQuiz.toString());
  }

  @override
  Widget build(BuildContext context) {
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
              const InformationLevel(
                  title: "Level 1 , Bagian 1",
                  desc: "Memahami Fundamental Pengelolaan Keuangan Pribadi"),
              // Main List
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      child: const CardThumbnail(
                          imageUrl:
                              "assets/img/thumbnail/Thumbnail Amplop Duit Ep 1.png"),
                      onTap: () {
                        debugPrint("Course Video");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CourseVideo()),
                        );
                      },
                    ),
                    for (var i = 1; i <= 5; i++)
                      StepCourse(
                        text: i.toString(),
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
