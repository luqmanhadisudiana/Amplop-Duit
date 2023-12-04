import 'package:amplop_duit/screens/home/home.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amplop_duit/screens/auth/login.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // Memeriksa nilai isLogin saat aplikasi dimulai
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

  static const List<BottomNavigationBarItem> _bottomNavBarItems =
      <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_outlined),
      label: 'Leaderboard',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_outlined),
      label: 'Smart Finance',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_outlined),
      label: 'History',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_outlined),
      label: 'Profile',
    ),
  ];

  void reset(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    debugPrint("reset");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: MyAppTheme.buildTheme(),
      home: Scaffold(
        body: const MyHomePage(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: _bottomNavBarItems,
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF5338BC),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontSize: 10),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          onTap: _onItemTapped,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            reset(context);
          },
          tooltip: 'Reset',
          child: const Icon(Icons.refresh),
        ), // Th,
      ),
    );
  }
}
