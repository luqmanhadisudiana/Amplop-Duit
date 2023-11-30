import 'package:amplop_duit/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _LoginScreen(),
    );
  }
}

class _LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Selamat Datang, Apakah Kamu Sudah Siap Belajar?',
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text("Mulai"))
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void doLogin(BuildContext context) async {
    // Simpan nilai isLogin ke SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);

    // Navigasi ke halaman HomePage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ini Halaman Login',
            ),
            TextFormField(
              controller: username,
              decoration: InputDecoration(
                fillColor: Colors.grey,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                fillColor: Colors.grey,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  doLogin(context);
                },
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
