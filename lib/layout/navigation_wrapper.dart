import 'package:amplop_duit/models/finance.dart';
import 'package:amplop_duit/models/history.dart';
import 'package:amplop_duit/models/my_course_status.dart';
import 'package:amplop_duit/screens/history/history.dart';
import 'package:amplop_duit/screens/home/home.dart';
import 'package:amplop_duit/screens/leaderboard/leaderboard.dart';
import 'package:amplop_duit/screens/profile/profile.dart';
import 'package:amplop_duit/screens/smart%20finance/smart_finance.dart';
import 'package:amplop_duit/screens/testpage/testpage.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amplop_duit/screens/auth/login.dart';

class NavigationWrapper extends StatefulWidget {
  final int selectedIndex;
  final Widget? customRedirect;
  const NavigationWrapper(
      {super.key, this.selectedIndex = 0, this.customRedirect});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  late int _selectedIndex;
  late Widget? _customBody;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _customBody = null;
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    // Memeriksa nilai isLogin saat aplikasi dimulai
    setState(() {
      _selectedIndex = widget.selectedIndex;
      _customBody = widget.customRedirect;
    });

    await loginStatus(context);
  }

  Future<void> loginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    debugPrint('is logged in : ${isLogin.toString()}');

    if (isLogin) {
      // Mengecek dan menghapus data yang sudah kadaluwarsa
      await checkAndRemoveExpiredData('Expired');

      WidgetsBinding.instance.addPostFrameCallback((_) {
        MyCourseStatus localmyCourseStatus =
            Provider.of<MyCourseStatus>(context, listen: false);
        localmyCourseStatus.loadFromSharedPreferences();
        ListSavedAnswer localMySavedAnswer =
            Provider.of<ListSavedAnswer>(context, listen: false);
        localMySavedAnswer.loadFromSharedPreferences();
        HistoryList localHistoryList =
            Provider.of<HistoryList>(context, listen: false);
        localHistoryList.loadFromSharedPreferences();
        ListMonthlyFinance localListMonthly =
            Provider.of<ListMonthlyFinance>(context, listen: false);
        localListMonthly.loadFromSharedPreferences();
        ListDailyFinance localListDaily =
            Provider.of<ListDailyFinance>(context, listen: false);
        localListDaily.loadFromSharedPreferences();
      });
    }

    // Jika isLogin bernilai true, pindah ke halaman utama
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!isLogin) {
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  Future<void> checkAndRemoveExpiredData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? expirationDateString = prefs.getString(key);
    debugPrint("Get Data");
    if (expirationDateString != null) {
      debugPrint("tidak null");

      // Pengecekan apakah data sudah kadaluwarsa
      DateTime expirationDate = DateTime.parse(expirationDateString);
      if (DateTime.now().isAfter(expirationDate)) {
        // Data sudah kadaluwarsa, hapus key
        debugPrint("clear bang");
        List<String> keysToRemove = [
          'historyList',
          'myCourseStatus',
          'savedAnswers'
        ];
        for (String key in keysToRemove) {
          await prefs.remove(key);
        }
      }
    }
  }

  final List<List<String>> _icons = [
    ['Home Active.svg', 'Home.svg'],
    ['Leaderboard Active.svg', 'Leaderboard.svg'],
    ['Smart Finance Active.svg', 'Smart Finance.svg'],
    ['History Active.svg', 'History.svg'],
    ['Profile Active.svg', 'Profile.svg'],
  ];

  final List<Widget> _pages = [
    const MyHomePage(),
    const LeaderboardPage(),
    const SmartFinancePage(),
    const HistoryPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: MyAppTheme.buildTheme(),
      home: Scaffold(
        body: _customBody ?? _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: List.generate(
            _icons.length,
            (index) => BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icon/${_selectedIndex == index ? _icons[index][0] : _icons[index][1]}',
                height: 20,
                width: 20,
              ),
              label: _icons[index][0].replaceAll(' Active.svg', ''),
            ),
          ),
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF5338BC),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontSize: 10),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          onTap: _onItemTapped,
        ),
        floatingActionButton: _selectedIndex == 2
            ? null
            : FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TestPage(
                                currentIndex: _selectedIndex,
                              )));
                },
                tooltip: 'Test Page',
                heroTag: null,
                child: const Icon(Icons.refresh),
              ), // Th,
      ),
    );
  }
}
