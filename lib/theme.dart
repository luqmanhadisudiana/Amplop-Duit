import 'package:flutter/material.dart';

class MyAppTheme {
  static ThemeData buildTheme() {
    return ThemeData(
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.0,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.0,
        ),
      ),
    );
  }
}
