import 'package:amplop_duit/screens/history/history.dart';
import 'package:amplop_duit/screens/home/home.dart';
import 'package:amplop_duit/screens/leaderboard/leaderboard.dart';
import 'package:amplop_duit/screens/profile/profile.dart';
import 'package:amplop_duit/screens/smart%20finance/smart_finance.dart';
import 'package:amplop_duit/screens/testpage/testpage.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amplop_duit/screens/auth/login.dart';

class NavigationWrapper extends StatefulWidget {
  final int selectedIndex;
  const NavigationWrapper({super.key, this.selectedIndex = 0});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  late int _selectedIndex;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // Memeriksa nilai isLogin saat aplikasi dimulai
    setState(() {
      _selectedIndex = widget.selectedIndex;
    });
    loginStatus();
  }

  void loginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    debugPrint(isLogin.toString());

    // Jika isLogin bernilai true, pindah ke halaman utama
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
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
        body: _pages[_selectedIndex],
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
                child: const Icon(Icons.refresh),
              ), // Th,
      ),
    );
  }
}
