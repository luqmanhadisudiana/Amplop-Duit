import 'package:flutter/material.dart';

class MyAppTheme {
  static ThemeData buildTheme() {
    return ThemeData(
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontFamily: 'Poppins',
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Poppins',
        ),
        bodySmall: TextStyle(
          fontFamily: 'Poppins'
        )
      ),
    );
  }
}
