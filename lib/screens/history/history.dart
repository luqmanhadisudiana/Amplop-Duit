import 'package:amplop_duit/component/button/main_button.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Build History Page
    // return const Text("History Page");
    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: const MainButton(
          buttonText: "Percobaan",
          width: double.maxFinite,
          height: 64,
          bgColor: Colors.green,
          textColor: Colors.black,
          borderColor: Color(0xFF9382D5),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          boxShadow: [],
        ),
      ),
    );
  }
}
