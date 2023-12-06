import 'package:amplop_duit/component/card/card_thumbnail.dart';
import 'package:amplop_duit/component/informationLevel/information_level.dart';
import 'package:amplop_duit/component/stepCourse/step_course.dart';
import 'package:flutter/material.dart';
import 'package:amplop_duit/theme.dart';

class MyCoursePage extends StatelessWidget {
  const MyCoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
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
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardThumbnail(
                        imageUrl:
                            "assets/img/thumbnail/Thumbnail Amplop Duit Ep 1.png"),
                    StepCourse(
                      text: '1',
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
