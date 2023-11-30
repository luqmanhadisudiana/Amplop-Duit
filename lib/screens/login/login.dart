import 'package:amplop_duit/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
