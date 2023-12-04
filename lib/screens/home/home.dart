import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: <Widget>[
            const Text("Homepage"),
            for (var i = 0; i < 10; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: const Text("1"),
              ),
          ],
        ),
      ],
    );
  }
}
