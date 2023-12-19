import 'package:amplop_duit/component/section/statistic_section.dart';
import 'package:amplop_duit/component/table/table_view.dart';
import 'package:amplop_duit/models/finance.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> monthlyHeaderTable = ["Bulan", 'Pendapatan', 'Pengeluaran'];
  List<FinanceRowHelper> dailyFinancesRow = [];
  bool isLoading = true;
  final String imagePath =
      "https://raw.githubusercontent.com/luqmanhadisudiana/Amplop-Duit/main/assets/img/profile/hadi.png";

  @override
  Widget build(BuildContext context) {
    // TODO: implement profile page
    return MaterialApp(
        title: "Smart Finace",
        theme: MyAppTheme.buildTheme(),
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: 200,
                    width: double.maxFinite,
                    child: Stack(
                      children: [
                        // Image BG
                        Container(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            child: Image.network(
                              imagePath,
                              fit: BoxFit.cover,
                              height: double.maxFinite,
                              width: double.maxFinite,
                              alignment: Alignment.topCenter,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                // Menampilkan widget pengganti ketika terjadi kesalahan
                                return Container(
                                  alignment: Alignment.center,
                                  width: 50.0,
                                  height: 50.0,
                                  color: Colors.red,
                                  child: const Icon(Icons.error,
                                      color: Colors.white),
                                );
                              },
                            )),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: const Icon(Icons.arrow_back),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: const Icon(Icons.settings),
                              )
                            ]),
                      ],
                    )),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Luqman Hadi",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Bandung, Jawa Barat",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 25.0,
                            spreadRadius: 2.0,
                            offset: const Offset(0, 4),
                          ),
                        ]),
                        child: SvgPicture.asset("assets/icon/Liga-1.svg",
                            height: 50),
                      )
                    ],
                  ),
                ),
                const StatisticSection(),
                Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Hasil Bulanan Kamu",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins")),
                        const SizedBox(
                          height: 16,
                        ),
                        MyTableView(
                            headerData: monthlyHeaderTable,
                            listOfRowData: dailyFinancesRow),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
