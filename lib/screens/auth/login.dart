import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/input/input_text.dart';
import 'package:amplop_duit/models/my_course_status.dart';
import 'package:amplop_duit/screens/auth/forgot_password.dart';
import 'package:amplop_duit/screens/auth/register.dart';
import 'package:amplop_duit/screens/loading/main_loading.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: MyAppTheme.buildTheme(),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: const Text(
                'Selamat Datang, Apakah Kamu Sudah Siap Belajar?',
                style: TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold, height: 1.7),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 500,
              child: SvgPicture.asset(
                'assets/img/avatar.svg',
                fit: BoxFit.cover,
              ),
            ),
            MainButton(
                buttonText: "Mulai",
                action: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                })
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

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> saveDataWithExpiration(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Set tanggal kedaluwarsa ke awal hari berikutnya
    DateTime expirationDate = DateTime.now().add(const Duration(days: 1));
    expirationDate = DateTime(expirationDate.year, expirationDate.month,
        expirationDate.day, 0, 0, 0, 0);

    await prefs.setString(key, expirationDate.toIso8601String());
  }

  Future<void> setLoginStatus() async {
    // Simpan nilai isLogin ke SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
    prefs.getInt('currentLiga') ?? prefs.setInt('currentLiga', 1);
    debugPrint("Set Expired");
    await saveDataWithExpiration('Expired');

    //Check Object
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MyCourseStatus localmyCourseStatus =
          Provider.of<MyCourseStatus>(context, listen: false);
      localmyCourseStatus.setNewValue(5, 5, 0, -1);
      localmyCourseStatus.saveSharedPreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                height: 200.0,
                child: Lottie.asset(
                  'assets/gif/Animation-Bubu.json',
                  fit: BoxFit.contain,
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration * 1.5
                      ..value = 0.0
                      ..forward();
                  },
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: () {
                            // Tambahkan logika ketika "belum memiliki akun"
                            debugPrint('Belum memiliki akun');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                            );
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const MyTextField(
                    hintText: "Username",
                    isPassword: false,
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
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            // Tambahkan logika ketika "lupa password"
                            debugPrint('lupa password');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordPage()),
                            );
                          },
                          child: const Text(
                            'Lupa Password?',
                            style:
                                TextStyle(color: Colors.black, fontSize: 8.0),
                          ),
                        ),
                      )
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
              child: InkWell(
                onTap: () async {
                  debugPrint('Google Login');
                  setLoginStatus();
                  // Navigasi ke halaman HomePage
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainLoading()),
                    );
                  });
                },
                child: Container(
                  width: 150.0,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Login dengan akun',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                        ),
                      ),
                      Image.asset(
                        'assets/img/google.png',
                        width: 21.0,
                        height: 21.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            MainButton(
                buttonText: "Masuk",
                width: 170.0,
                action: () async {
                  debugPrint('Button Login');
                  setLoginStatus();
                  // Navigasi ke halaman HomePage
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainLoading()),
                    );
                  });
                }),
          ],
        ),
      ),
    );
  }
}
