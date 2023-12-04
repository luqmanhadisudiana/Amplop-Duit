import 'package:amplop_duit/main.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainLoading extends StatefulWidget {
  const MainLoading({Key? key}) : super(key: key);

  @override
  State<MainLoading> createState() => _MainLoadingState();
}

class _MainLoadingState extends State<MainLoading> {
  double progressValue = 0.1;
  bool isLoading = false;
  int duration = 3; // duration loading

  @override
  void initState() {
    super.initState();
    // Memeriksa nilai isLogin saat aplikasi dimulai
    _startLoading();
  }

  void _startLoading() {
    setState(() {
      isLoading = true;
      progressValue = 0.1;
    });

    // Simulasi loading selama "duration"
    Future.delayed(Duration(seconds: duration), () {
      setState(() {
        progressValue = 0.3; // Set nilai progress sebelum mencapai penuh
      });

      // Increment progress secara bertahap untuk mencapai penuh
      int totalSteps = 30; // Ubah totalSteps sesuai kebutuhan
      double increment = (1.0 - progressValue) / totalSteps;

      for (int step = 0; step < totalSteps; step++) {
        Future.delayed(
          Duration(milliseconds: ((1000 * duration) ~/ totalSteps)),
          () {
            setState(() {
              progressValue += increment;
            });
          },
        );
      }

      // Hilangkan loading setelah durasi loading selesai
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          isLoading = false;
          progressValue = 0.0; // Reset nilai progress setelah loading selesai
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Loading",
      theme: MyAppTheme.buildTheme(),
      home: Scaffold(
        body: Center(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 47),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hore, Selamat Datang \nAyo Belajar',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w700, height: 1.2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40.0),
              // Image.asset("assets/img/avatar.png"),
              SvgPicture.asset("assets/img/avatar-hand-up.svg"),
              const SizedBox(height: 20.0),
              if (isLoading)
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        LinearProgressIndicator(
                          value: progressValue,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF5338BC)),
                          minHeight: 15, // Atur tinggi progress bar
                          borderRadius: BorderRadius.circular(10),
                        ),
                        const SizedBox(height: 16.0),
                        const Center(
                          child: Text("Loading"),
                        )
                      ],
                    )),
            ],
          ),
        )),
      ),
    );
  }
}
