import 'package:amplop_duit/component/appbar/default_appbar.dart';
import 'package:amplop_duit/component/card/card_history.dart';
import 'package:amplop_duit/component/card/card_quiz_result.dart';
import 'package:amplop_duit/component/customInkwell/custom_inkwell.dart';
import 'package:amplop_duit/layout/navigation_wrapper.dart';
import 'package:amplop_duit/models/history.dart';
import 'package:amplop_duit/screens/history/your_mistake.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "History",
      theme: MyAppTheme.buildTheme(),
      home: Scaffold(
        appBar: DefaultAppbar(
          title: "History",
          parentContext: context,
          action: () {
            debugPrint("Ini History");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const NavigationWrapper(
                        selectedIndex: 0,
                      )),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 9, bottom: 24),
                  child: const CardHistory(),
                ),
                const Text("Koleksimu",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins")),
                Container(
                  padding: const EdgeInsets.only(top: 16, bottom: 24),
                  child: CustomInkwell(
                    text: "Kesalahanmu",
                    textColor: Colors.white,
                    margin: const EdgeInsets.only(bottom: 12),
                    bgImageUrl: "assets/img/background/History-Kesalahan.png",
                    action: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const YourMistakePage()));
                    },
                  ),
                ),
                const Text("Hasil Quiz Hari ini",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins")),
                const SizedBox(
                  height: 16,
                ),
                Consumer<HistoryList>(
                  builder: (context, historyList, child) {
                    return Column(
                      children: [
                        historyList.listHistory.isEmpty
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
                        for (var i = 0; i < historyList.listHistory.length; i++)
                          Container(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CardQuizResult(
                              title: historyList.listHistory[i].title,
                              question: historyList.listHistory[i].question,
                              answer: historyList.listHistory[i].jawaban,
                              status: historyList.listHistory[i].status,
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
      ),
    );
  }
}
