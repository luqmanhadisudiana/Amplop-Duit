import 'package:amplop_duit/component/answerContainer/answer_container.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';

class CourseQuiz extends StatefulWidget {
  const CourseQuiz({super.key});

  @override
  State<CourseQuiz> createState() => _CourseQuizState();
}

class AnswerList {
  final String text;
  final bool status;

  AnswerList({
    required this.text,
    required this.status,
  });
}

class _CourseQuizState extends State<CourseQuiz> {
  final List<AnswerList> itemList = [
    AnswerList(text: 'Item A', status: true),
    AnswerList(text: 'Item B', status: false),
    AnswerList(text: 'Item C', status: false),
    AnswerList(text: 'Item D', status: false),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Quiz',
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
                  "Quiz",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const Icon(Icons.add),
              ],
            ),
          ),
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
                        "assets/img/thumbnail/Thumbnail Amplop Duit Ep 1.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 24, top: 16),
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Level 1, Bagian 1",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Dari video sebelumnya, berikut apa aspek yang harus diperhatikan dalam mencatat keuangan?",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ]),
                  ),
                  for (int i = 0; i < 4; i++)
                    AnswerContainer(
                      text: itemList[i].text,
                      index: i,
                      action: () {
                        debugPrint(itemList[i].status.toString());
                      },
                    )
                ],
              ),
            ),
          ]),
        ));
  }
}
