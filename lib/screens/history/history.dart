import 'package:amplop_duit/component/card/card_history.dart';
import 'package:amplop_duit/component/card/card_mistake_status.dart';
import 'package:amplop_duit/component/card/card_quiz_result.dart';
import 'package:amplop_duit/component/customInkwell/custom_inkwell.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Build History Page
    // return const Text("History Page");
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const CardQuizResult(
              status: true,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const CardQuizResult(
              status: false,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Column(
              children: [
                CustomInkwell(
                  text: "test",
                  margin: EdgeInsets.only(bottom: 12),
                ),
                CustomInkwell(
                  text: "test 2",
                  margin: EdgeInsets.only(bottom: 12),
                ),
                CustomInkwell(
                  text: "Kesalahanmu",
                  textColor: Colors.white,
                  margin: EdgeInsets.only(bottom: 12),
                  bgImageUrl: "assets/img/background/History-Kesalahan.png",
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const CardMistakeStatus(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const CardHistory(),
          )
        ],
      ),
    );
  }
}
