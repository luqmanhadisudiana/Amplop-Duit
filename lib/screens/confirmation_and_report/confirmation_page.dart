import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/models/my_course_status.dart';
import 'package:amplop_duit/provider.dart';
import 'package:amplop_duit/screens/confirmation_and_report/report.dart';
import 'package:amplop_duit/screens/course/my_course.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Kamu sudah melakukan pembelajaran hari ini, apakah kamu ingin lanjut belajar?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
            Center(
              child: Image.network(
                "https://raw.githubusercontent.com/luqmanhadisudiana/Amplop-Duit/main/assets/img/Bubu-depan-rumah.png",
                height: 250,
                width: 295,
              ),
            ),
            Column(
              children: [
                MainButton(
                  buttonText: "Lanjut Belajar",
                  width: 250,
                  action: () {
                    debugPrint("Lanjut");
                    var courseProvider =
                        Provider.of<CourseProvider>(context, listen: false);
                    var myCourseStatusProvider =
                        Provider.of<MyCourseStatus>(context, listen: false);
                    int currentCourseIndex =
                        myCourseStatusProvider.getSelectedCourse;
                    int courseListLength =
                        courseProvider.getCourseList.length - 1;

                    if (currentCourseIndex == courseListLength) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EndCourseStatusPage()));
                    } else {
                      myCourseStatusProvider.nextCourse();
                      myCourseStatusProvider.saveSharedPreferences();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const MyCoursePage()),
                          (Route<dynamic> route) => route.isFirst);
                    }
                  },
                ),
                const SizedBox(
                  height: 17,
                ),
                MainButton(
                  buttonText: "Istirahat Dulu",
                  width: 250,
                  bgColor: Colors.white,
                  borderColor: const Color(0xFF5338BC),
                  textColor: const Color(0xFF5338BC),
                  action: () {
                    debugPrint("Lanjut");
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}

class EndCourseStatusPage extends StatelessWidget {
  const EndCourseStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Tugasmu minggu ini sudah selesai. Siapkan dirimu untuk materi minggu selanjutnya",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Image.network(
                "https://raw.githubusercontent.com/luqmanhadisudiana/Amplop-Duit/main/assets/img/Character-Santai.png",
                width: 330,
              ),
            ),
            MainButton(
              buttonText: "Lihat Hasil",
              width: 250,
              action: () {
                debugPrint("Lanjut");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReportPage()));
              },
            ),
          ],
        )),
      ),
    );
  }
}
