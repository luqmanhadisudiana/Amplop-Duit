import 'package:amplop_duit/component/appbar/default_appbar.dart';
import 'package:amplop_duit/component/card/card_quiz_result.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';

class TestStatusPage extends StatelessWidget {
  const TestStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Page untuk melihat hasil percobaan
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
        ));
  }
}
