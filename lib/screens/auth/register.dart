import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/input/input_text.dart';
import 'package:amplop_duit/models/my_course_status.dart';
import 'package:amplop_duit/screens/auth/login.dart';
import 'package:amplop_duit/screens/loading/main_loading.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    return MaterialApp(
        title: 'Register',
        theme: MyAppTheme.buildTheme(),
        home: Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Nama Depan',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      const MyTextField(
                        hintText: "Bubu",
                        isPassword: false,
                      ),
                      const SizedBox(height: 10.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Nama Belakang',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      const MyTextField(
                        hintText: "Amdul",
                        isPassword: false,
                      ),
                      const SizedBox(height: 10.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Email/no.Hp',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      const MyTextField(
                        hintText: "Email/No.Hp",
                        isPassword: false,
                      ),
                      const SizedBox(height: 10.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      const MyTextField(
                        hintText: "************",
                        isPassword: true,
                      ),
                      const SizedBox(height: 10.0),
                      Center(
                        child: InkWell(
                          onTap: () {
                            // Tambahkan logika yang ingin dilakukan saat div/button diklik
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
                            padding: const EdgeInsets.all(10.0),
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
                          buttonText: "Buat Akun",
                          width: 170.0,
                          action: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          }),
                    ]),
              ),
            ],
          )),
        ));
  }
}
