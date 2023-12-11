import 'package:amplop_duit/component/appbar/default_appbar.dart';
import 'package:amplop_duit/component/card/card_achievement.dart';
import 'package:amplop_duit/models/achievement.dart';
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
          appBar: DefaultAppbar(title: "Pencapaian", parentContext: context),
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
                        for (var i = 0; i < achievementData.length; i++)
                          CardAchievement(
                            title: achievementData[i].title,
                            desc: achievementData[i].desc,
                            imageUrl: achievementData[i].imageUrl,
                            currentValue: achievementData[i].currentValue,
                            maxValue: achievementData[i].maxValue,
                            bottomBorder:
                                i == achievementData.length - 1 ? false : true,
                          ),
                      ]),
                ),
              ),
            ],
          )),
    );
  }
}
