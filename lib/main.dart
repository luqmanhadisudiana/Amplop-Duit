import 'package:amplop_duit/layout/navigation_wrapper.dart';
import 'package:amplop_duit/provider.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('id_ID');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CoursePointerProvider()),
      ChangeNotifierProvider(create: (context) => CourseProvider()),
      // Tambahkan provider lain sesuai kebutuhan
    ],
    child: MaterialApp(
      title: 'Amplop Duit',
      theme: MyAppTheme.buildTheme(),
      home: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const NavigationWrapper();
  }
}
