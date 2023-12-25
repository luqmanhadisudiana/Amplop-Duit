import 'package:amplop_duit/component/appbar/default_appbar.dart';
import 'package:amplop_duit/component/card/card_mistake_status.dart';
import 'package:amplop_duit/component/customInkwell/custom_inkwell.dart';
import 'package:amplop_duit/models/my_course_status.dart';
import 'package:amplop_duit/screens/history/attempt_result_.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourMistakePage extends StatelessWidget {
  const YourMistakePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kesalahan",
      theme: MyAppTheme.buildTheme(),
      home: Scaffold(
          appBar: DefaultAppbar(title: "Kesalahan", parentContext: context),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 9, bottom: 24),
                    child: const CardMistakeStatus(),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: const Text("Historymu",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins")),
                  ),
                  Consumer<MyCourseStatus>(
                      builder: (context, myCourseStatus, child) {
                    return Column(
                      children: [
                        myCourseStatus.attempt == 0
                            ? Container(
                                padding: const EdgeInsets.all(10),
                                child: const Center(
                                  child: Text(
                                    "Belum Ada History",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFD1D1D1)),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        for (var i = 0; i < myCourseStatus.attempt; i++)
                          CustomInkwell(
                            text: "Percobaan ${i + 1}",
                            margin: const EdgeInsets.only(bottom: 12),
                            action: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AttemptResultPage(
                                            attemptIndex: i + 1,
                                          )));
                            },
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          )),
    );
  }
}
