import 'package:amplop_duit/component/input/input_text.dart';
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
            const SizedBox(height: 100.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Label dan Input Text untuk Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Username',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Tambahkan logika ketika "belum memiliki akun"
                          debugPrint('Belum memiliki akun');
                        },
                        child: const Text(
                          'Belum memiliki akun',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 8.0,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const MyTextField(
                    hintText: "Username",
                    isPassword: true,
                  ),
                  const SizedBox(height: 24.0),
                  // Label dan Input Text untuk Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Tambahkan logika ketika "lupa password"
                          debugPrint('lupa password');
                        },
                        child: const Text(
                          'Lupa Password?',
                          style: TextStyle(color: Colors.black, fontSize: 8.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const MyTextField(
                    hintText: "Password",
                    isPassword: true,
                  )
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: GestureDetector(
                onTap: () {
                  // Tambahkan logika yang ingin dilakukan saat div/button diklik
                  debugPrint('Google Login');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Login dengan akun',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.0,
                            ),
                          ),
                          const SizedBox(width: 35.0),
                          Image.asset(
                            'assets/img/google.png',
                            width: 21.0,
                            height: 21.0,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
                onPressed: () {
                  doLogin(context);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200.0, 50.0),
                  backgroundColor: const Color(0xFF5338BC),
                ),
                child: const Text(
                  "Masuk",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
