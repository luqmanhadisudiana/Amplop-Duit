import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/input/input_text.dart';
import 'package:amplop_duit/screens/auth/login.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Nama Depan',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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
                child: GestureDetector(
                  onTap: () {
                    // Tambahkan logika yang ingin dilakukan saat div/button diklik
                    debugPrint('Google Login');
                    LoginPage.doLogin(context);
                  },
                  child: SizedBox(
                    width: 150.0,
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
    );
  }
}
