import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';

class MainLoading extends StatefulWidget {
  const MainLoading({Key? key}) : super(key: key);

  @override
  State<MainLoading> createState() => _MainLoadingState();
}

class _MainLoadingState extends State<MainLoading> {
  double progressValue = 0.0;
  bool isLoading = false;
  int duration = 3; // duration loading

  void _startLoading() {
    setState(() {
      isLoading = true;
      progressValue = 0.0;
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Loading",
      theme: MyAppTheme.buildTheme(),
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text(
        //     'Loading Bar Example',
        //     style: TextStyle(fontFamily: 'Poppins'),
        //   ),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Hore, Selamat Datang Ayo Belajar"),
              Image.asset("assets/img/avatar.png"),
              ElevatedButton(
                onPressed: _startLoading,
                child: const Text('Mulai Loading'),
              ),
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
                          minHeight: 10, // Atur tinggi progress bar
                          borderRadius: BorderRadius.circular(10),
                        ),
                        const Center(
                          child: Text("Loading"),
                        )
                      ],
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
