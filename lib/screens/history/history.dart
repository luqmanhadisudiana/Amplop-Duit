import 'package:amplop_duit/component/appbar/default_appbar.dart';
import 'package:amplop_duit/component/card/card_history.dart';
import 'package:amplop_duit/component/card/card_quiz_result.dart';
import 'package:amplop_duit/component/customInkwell/custom_inkwell.dart';
import 'package:amplop_duit/screens/history/your_mistake.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Build History Page
    // return const Text("History Page");
    return MaterialApp(
      title: "History",
      theme: MyAppTheme.buildTheme(),
      home: Scaffold(
        appBar: DefaultAppbar(
          title: "History",
          parentContext: context,
          action: () {
            debugPrint("Ini History");
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
                for (var i = 0; i < 5; i++)
                  Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CardQuizResult(
                      status: i % 2 == 0,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
