import 'package:amplop_duit/models/my_course_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveDataWithExpiration(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Set tanggal kedaluwarsa ke awal hari berikutnya
  DateTime expirationDate = DateTime.now().add(const Duration(days: 1));
  expirationDate = DateTime(expirationDate.year, expirationDate.month,
      expirationDate.day, 0, 0, 0, 0);

  await prefs.setString(key, expirationDate.toIso8601String());
}

Future<void> saveDataWithExpirationWeekly(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  DateTime today = DateTime.now();
  int difference = (DateTime.monday - today.weekday + 7) % 7;

  // Menghitung tanggal kedaluwarsa pada setiap Senin pukul 00:00
  DateTime expirationDate = today.add(Duration(days: difference));
  expirationDate = DateTime(
    expirationDate.year,
    expirationDate.month,
    expirationDate.day,
    0,
    0,
    0,
    0,
  );

  await prefs.setString(key, expirationDate.toIso8601String());
}

Future<void> checkAndRemoveExpiredData(String key, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? expirationDateString = prefs.getString(key);
  debugPrint("Get Data");
  if (expirationDateString != null) {
    debugPrint("tidak null");

    // Pengecekan apakah data sudah kadaluwarsa
    DateTime expirationDate = DateTime.parse(expirationDateString);
    if (DateTime.now().isAfter(expirationDate)) {
      // Data sudah kadaluwarsa, hapus key

      if (key == "ExpiredDaily") {
        debugPrint("change value heart and diamond");
        await saveDataWithExpiration('ExpiredDaily');

        WidgetsBinding.instance.addPostFrameCallback((_) {
          MyCourseStatus localmyCourseStatus =
              Provider.of<MyCourseStatus>(context, listen: false);
          localmyCourseStatus.setNewValue(
              5,
              5,
              localmyCourseStatus.getSelectedCourse,
              localmyCourseStatus.getselectedQuiz);
          localmyCourseStatus.saveSharedPreferences();
        });
      } else {
        await saveDataWithExpirationWeekly('ExpiredWeekly');
        debugPrint("clear...");
        List<String> keysToRemove;
        keysToRemove = ['historyList', 'myCourseStatus', 'savedAnswers'];
        for (String key in keysToRemove) {
          await prefs.remove(key);
        }
      }
    }
  }
}
