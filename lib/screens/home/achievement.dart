import 'package:amplop_duit/component/card/card_achievement.dart';
import 'package:flutter/material.dart';
import 'package:amplop_duit/theme.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: MyAppTheme.buildTheme(),
      home: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                "Pencapaian",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // Customize other properties of AppBar as needed
          ),
          body: ListView(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 14.0),
                  margin: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 25.0,
                        offset: const Offset(0, 0),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < 6; i++)
                          CardAchievement(
                            title: "test",
                            desc: "test",
                            imageUrl: 'assets/img/pencapaian/Group 515.svg',
                            currentValue: 4,
                            maxValue: 5,
                            bottomBorder: i == 6 - 1 ? false : true,
                          ),
                      ]),
                ),
              ),
            ],
          )),
    );
  }
}