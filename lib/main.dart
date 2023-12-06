import 'package:amplop_duit/layout/navigation_wrapper.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Amplop Duit',
      theme: MyAppTheme.buildTheme(),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const NavigationWrapper();
  }
}
