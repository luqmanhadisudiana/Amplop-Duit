import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amplop_duit/screens/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Homepage",
            ),
          ],
        ),
      ),
    );
  }
}
