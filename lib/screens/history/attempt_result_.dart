import 'package:amplop_duit/component/appbar/default_appbar.dart';
import 'package:amplop_duit/component/card/card_quiz_result.dart';
import 'package:amplop_duit/models/history.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttemptResultPage extends StatelessWidget {
  final int attemptIndex;
  const AttemptResultPage({super.key, required this.attemptIndex});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Percobaan",
        theme: MyAppTheme.buildTheme(),
        home: Scaffold(
          appBar: DefaultAppbar(title: "Percobaan", parentContext: context),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: const Text("Historymu",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins")),
                  ),
                  Consumer<HistoryList>(
                    builder: (context, historyList, child) {
                      List<History> newListHistory = historyList.listHistory
                          .where((value) => value.attempt == attemptIndex)
                          .toList();
                      return Column(
                        children: [
                          newListHistory.isEmpty
                              ? const Center(
                                  child: Text(
                                    "Kamu belum mengerjakan Quiz",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFD1D1D1)),
                                  ),
                                )
                              : const SizedBox(),
                          for (var i = 0; i < newListHistory.length; i++)
                            Container(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: CardQuizResult(
                                title: newListHistory[i].title,
                                question: newListHistory[i].question,
                                answer: newListHistory[i].jawaban,
                                status: newListHistory[i].status,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
