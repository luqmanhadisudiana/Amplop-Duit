import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement profile page
    return MaterialApp(
        title: "Smart Finace",
        theme: MyAppTheme.buildTheme(),
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [const Text("image")],
            ),
          ),
        ));
  }
}
