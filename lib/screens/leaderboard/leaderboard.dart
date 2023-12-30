import 'package:amplop_duit/component/leaderboard/leaderboard_item.dart';
import 'package:amplop_duit/models/learderboard.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  int liga = 0;
  List<String> listLiga = ["", "Perunggu", "Perak", "Emas", "Berlian", "Rubi"];
  List<Leaderboard>? listLeaderboard;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    _getCurrentLiga();
    _getUserLeaderboard();
  }

  void _getCurrentLiga() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentLiga = prefs.getInt('currentLiga') ?? 0;

    setState(() {
      liga = currentLiga;
    });
  }

  void _getUserLeaderboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentTP = prefs.getInt('totalPoint') ?? 0;

    Leaderboard userLeaderboard = Leaderboard(
      imageUser:
          "https://raw.githubusercontent.com/luqmanhadisudiana/Amplop-Duit/main/assets/img/profile/hadi.png",
      nameUser: "Luqman Hadi",
      point: currentTP,
    );

    List<Leaderboard> newList = dummyLeaderboard;
    newList.add(userLeaderboard);
    newList = sortLeaderboards(newList, descending: true);
    debugPrint("${newList.length}");
    setState(() {
      listLeaderboard = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    int hariBerlalu = today.weekday;
    int hariTersisa = 7 - hariBerlalu;

    String sHariTersisa = '$hariTersisa hari';
    return MaterialApp(
      title: 'Leaderboard',
      theme: MyAppTheme.buildTheme(),
      home: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 14.0, right: 14.0, bottom: 14.0, top: 14 + 30),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i = 0; i < 5; i++)
                          i < liga
                              ? SvgPicture.asset(
                                  "assets/icon/Liga-${i + 1}.svg",
                                  height: 50)
                              : SvgPicture.asset(
                                  "assets/icon/Liga-Inactive.svg",
                                  height: 50)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Liga ${listLiga[liga]}",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: const Text(
                      "Peringkat berdasarkan daerah tinggalmu, \n3 teratas akan maju ke liga berikutnya",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Color(0xFFE9E9E9),
                                width: 1.0,
                              ),
                              top: BorderSide(
                                color: Color(0xFFE9E9E9),
                                width: 1.0,
                              ),
                              bottom: BorderSide(
                                color: Color(0xFFE9E9E9),
                                width: 1.0,
                              ),
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                              topLeft: Radius.circular(15.0),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Hari Ini",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins"),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icon/Polygon.svg",
                                    width: 18,
                                    height: 18,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text(
                                    "3 Posisi",
                                    style: TextStyle(
                                        color: Color(0xFF54AA54),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins"),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE9E9E9)),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Sisa Waktu",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins"),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icon/Clock.svg",
                                    width: 18,
                                    height: 18,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    sHariTersisa,
                                    style: const TextStyle(
                                        color: Color(0xFF5338BC),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins"),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xFFE9E9E9)))),
                child: listLeaderboard == null
                    ? const Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 75, // Sesuaikan dengan tinggi yang diinginkan
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ListView.builder(
                        itemCount: listLeaderboard!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: LeaderboardItem(
                              index: index,
                              name: listLeaderboard![index].nameUser,
                              imageUrl: listLeaderboard![index].imageUser,
                              point: listLeaderboard![index].point,
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
