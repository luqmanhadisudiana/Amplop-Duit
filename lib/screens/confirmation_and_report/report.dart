import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/layout/navigation_wrapper.dart';
import 'package:amplop_duit/models/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    super.initState();
    HistoryList localHistoryList =
        Provider.of<HistoryList>(context, listen: false);
    localHistoryList.loadFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.width;

    double horizontalPadding = maxWidth * 0.15;

    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/img/Bubu-Belajar.svg",
              height: 285,
            ),
            SizedBox(
              height: maxHeight * 0.085,
            ),
            const Column(
              children: [
                Text(
                  "MASTER FINANCE",
                  style: TextStyle(
                      color: Color(0xFF5338BC),
                      fontFamily: "Poppins",
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Kamu hebat dalam satu minggu ini",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
              height: maxHeight * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 83,
                  padding: const EdgeInsets.only(
                      bottom: 2, right: 2, left: 2, top: 20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      color: Color(0xFF5338BC)),
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          color: Colors.white),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "+15",
                            style: TextStyle(
                                color: Color(0xFF5338BC),
                                fontFamily: "Poppins",
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Point",
                            style: TextStyle(
                                color: Color(0xFF5338BC),
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                ),
                Container(
                  width: 83,
                  padding: const EdgeInsets.only(
                      bottom: 2, right: 2, left: 2, top: 20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      color: Color(0xFFFF4D6D)),
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          color: Colors.white),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "1",
                                style: TextStyle(
                                    color: Color(0xFFFF4D6D),
                                    fontFamily: "Poppins",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600),
                              ),
                              Icon(
                                Icons.favorite,
                                weight: 20,
                                color: Color(0xFFFF4D6D),
                              )
                            ],
                          ),
                          Text(
                            "Point",
                            style: TextStyle(
                                color: Color(0xFFFF4D6D),
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                ),
                Container(
                  width: 83,
                  padding: const EdgeInsets.only(
                      bottom: 2, right: 2, left: 2, top: 20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      color: Color(0xFF8AC58A)),
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Consumer<HistoryList>(
                              builder: (context, data, child) {
                            return Text(
                              "${data.getSuccesRate().toString()}%",
                              style: const TextStyle(
                                  color: Color(0xFF8AC58A),
                                  fontFamily: "Poppins",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            );
                          }),
                          const Text(
                            "Success",
                            style: TextStyle(
                                color: Color(0xFF8AC58A),
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                )
              ],
            ),
            SizedBox(
              height: maxHeight * 0.06,
            ),
            MainButton(
              buttonText: "Level Selanjutnya",
              width: double.maxFinite,
              action: () {
                debugPrint("Lanjut");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NavigationWrapper(
                              selectedIndex: 0,
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
