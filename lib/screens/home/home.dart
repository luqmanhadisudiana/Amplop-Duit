import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/card/card_achievement.dart';
import 'package:amplop_duit/component/section/statistic_section.dart';
import 'package:amplop_duit/models/achievement.dart';
import 'package:amplop_duit/models/my_course_status.dart';
import 'package:amplop_duit/screens/home/achievement.dart';
import 'package:amplop_duit/screens/course/my_course.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String totalPoint = "0";
  @override
  void initState() {
    super.initState();
    _getTotalPoint();
  }

  void _getTotalPoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentTotalPoint = prefs.getInt('totalPoint') ?? 0;

    setState(() {
      totalPoint = currentTotalPoint.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return MaterialApp(
        title: "Home",
        theme: MyAppTheme.buildTheme(),
        home: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: statusBarHeight + 15,
                    bottom: 25.0,
                    left: 15.0,
                    right: 15.0),
                margin: const EdgeInsets.all(0.0),
                decoration: const BoxDecoration(color: Color(0xFF725CC8)),
                child: Column(children: [
                  // Bagian Atas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: <Widget>[
                          // profile photos
                          Container(
                            height: 42.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFFFFFF),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/img/Bubu.png', // dummy photo
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bubu Amdul",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Newbie",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icon/Point.svg",
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            totalPoint,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                  //Bagian Bawah
                  Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icon/Heart.svg",
                                  // width: 60,
                                  height: 60,
                                ),
                                const SizedBox(width: 21.0),
                                Consumer<MyCourseStatus>(
                                  builder: (context, myCourseStatus, child) {
                                    return Text(
                                      myCourseStatus.heart.toString(),
                                      style: const TextStyle(
                                          color: Color(0xFF3F3F3F),
                                          fontSize: 32,
                                          fontWeight: FontWeight.w600),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icon/Diamond.svg",
                                  // width: 60,
                                  height: 60,
                                ),
                                const SizedBox(width: 21.0),
                                Consumer<MyCourseStatus>(
                                  builder: (context, myCourseStatus, child) {
                                    return Text(
                                      myCourseStatus.diamond.toString(),
                                      style: const TextStyle(
                                          color: Color(0xFF3F3F3F),
                                          fontSize: 32,
                                          fontWeight: FontWeight.w600),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ]),
                  )
                ]),
              ),
              // section 2
              Container(
                padding:
                    const EdgeInsets.only(top: 25.0, right: 15.0, left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          debugPrint("My Course");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyCoursePage()),
                          ).then((value) => {
                                if (value != null && value == true)
                                  {_getTotalPoint()}
                              });
                        },
                        child: Container(
                          height: 130,
                          // width: double.infinity,
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 25.0,
                                offset: const Offset(0, 0),
                                spreadRadius: 0,
                              ),
                            ],
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/img/home/Home-MyCourse.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: const Text(
                            'Course\nSaya',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Container(
                      height: 130,
                      width: 150,
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 25.0, top: 15.0, bottom: 8.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 25.0,
                            offset: const Offset(0, 0),
                            spreadRadius: 0,
                          ),
                        ],
                        image: const DecorationImage(
                          image:
                              AssetImage('assets/img/home/Home-Level Kamu.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Level\nKamu',
                                  style: TextStyle(
                                      // backgroundColor: Colors.black12,
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Consumer<MyCourseStatus>(
                                builder: (context, myCourseStatus, child) {
                                  return Text(
                                    (myCourseStatus.getSelectedCourse + 1)
                                        .toString(),
                                    style: const TextStyle(
                                        // backgroundColor: Colors.black12,
                                        color: Colors.white,
                                        fontSize: 42.0,
                                        fontWeight: FontWeight.w600),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // section 3
              StatisticSection(
                totalPoint: totalPoint,
              ),
              Container(
                padding:
                    const EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0),
                child: const Text(
                  'Pencapaian',
                  style: TextStyle(
                      // backgroundColor: Colors.black12,
                      // color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
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
                      for (var i = 0; i < 3; i++)
                        CardAchievement(
                          title: achievementData[i].title,
                          desc: achievementData[i].desc,
                          imageUrl: achievementData[i].imageUrl,
                          currentValue: achievementData[i].currentValue,
                          maxValue: achievementData[i].maxValue,
                          bottomBorder: i == 3 - 1 ? false : true,
                        ),
                    ]),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 25.0),
                child: Center(
                  child: MainButton(
                      width: 250,
                      buttonText: "Lihat Lainnya",
                      action: () {
                        debugPrint("Achievement");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AchievementPage()),
                        );
                      }),
                ),
              ),
            ],
          ),
        )));
  }
}
