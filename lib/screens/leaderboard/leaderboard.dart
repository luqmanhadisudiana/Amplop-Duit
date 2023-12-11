import 'package:amplop_duit/component/leaderboard/leaderboard_item.dart';
import 'package:amplop_duit/models/learderboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 0; i < 5; i++)
                        i < 1
                            ? SvgPicture.asset("assets/icon/Liga-Active.svg",
                                height: 50)
                            : SvgPicture.asset("assets/icon/Liga-Inactive.svg",
                                height: 50)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Liga Perunggu",
                  style: TextStyle(
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
                              width: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/icon/Polygon.svg"),
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
                              width: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/icon/clock.svg"),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "5 Hari",
                                  style: TextStyle(
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
              child: ListView.builder(
                itemCount: dummyLeaderboard.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: LeaderboardItem(
                          index: index,
                          name: dummyLeaderboard[index].nameUser,
                          imageUrl: dummyLeaderboard[index].imageUser,
                          point: dummyLeaderboard[index].point));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
