import 'package:amplop_duit/component/section/statistic_section.dart';
import 'package:amplop_duit/component/table/table_view.dart';
import 'package:amplop_duit/models/finance.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> monthlyHeaderTable = ["Bulan", 'Pendapatan', 'Pengeluaran'];
  List<FinanceRowHelper> dailyFinancesRow = [];

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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://raw.githubusercontent.com/luqmanhadisudiana/Amplop-Duit/main/assets/img/profile/hadi.png'),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Icon(Icons.arrow_back), Icon(Icons.settings)]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [const Text("test"), const Text("test")],
                    ),
                    SvgPicture.asset("assets/icon/Liga-1.svg", height: 50),
                  ],
                ),
                const StatisticSection(),
                MyTableView(
                    headerData: monthlyHeaderTable,
                    listOfRowData: dailyFinancesRow)
              ],
            ),
          ),
        ));
  }
}
