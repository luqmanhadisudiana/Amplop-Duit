import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static const String _key = 'myCourseStatus';

  static Future<void> saveMyObject(Map<String, dynamic> myObjectMap) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String myObjectString = json.encode(myObjectMap);
    await prefs.setString(_key, myObjectString);
  }

  static Future<Map<String, dynamic>?> loadMyObject() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? myObjectString = prefs.getString(_key);

    if (myObjectString != null) {
      return json.decode(myObjectString);
    }

    return null;
  }

  Future<void> resetMyObject() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('myObject');
  }
}
