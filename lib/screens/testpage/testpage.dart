import 'package:amplop_duit/component/appbar/default_appbar.dart';
import 'package:amplop_duit/component/customAlertDialog/custom_alert_dialog.dart';
import 'package:amplop_duit/provider.dart';
import 'package:amplop_duit/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late CoursePointerProvider coursePointerProvider;
  TextEditingController courseIndexController = TextEditingController();
  TextEditingController quizIndexController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Set initial values from the provider
    coursePointerProvider =
        Provider.of<CoursePointerProvider>(context, listen: false);

    courseIndexController.text =
        coursePointerProvider.getSelectedCourse.toString();
    quizIndexController.text = coursePointerProvider.getselectedQuiz.toString();

    courseIndexController.addListener(onValueChanged);
    quizIndexController.addListener(onValueChanged);
  }

  void onValueChanged() {
    CoursePointerProvider coursePointerProvider =
        Provider.of<CoursePointerProvider>(context, listen: false);
    CourseProvider courseProvider =
        Provider.of<CourseProvider>(context, listen: false);

    if ((int.tryParse(courseIndexController.text) ?? 0) <
        courseProvider.getCourseList.length) {
      coursePointerProvider.setNewValue(
          int.tryParse(courseIndexController.text) ?? 0,
          int.tryParse(quizIndexController.text) ?? -1);
    } else {
      warning("Index Out Bound");
    }

    if ((int.tryParse(quizIndexController.text) ?? 0) <
        courseProvider
            .getCourseList[int.tryParse(quizIndexController.text) ?? 0]
            .listQuestionAnswer
            .length) {
      coursePointerProvider.setNewValue(
          int.tryParse(courseIndexController.text) ?? 0,
          int.tryParse(quizIndexController.text) ?? -1);
    } else {
      warning("Index Out Bound");
    }
  }

  void warning(String message) {
    CustomAlertDialog(
        title: message, desc: "Coba ganti dengan value yang lebih rendah");
  }

  @override
  void dispose() {
    courseIndexController.removeListener(onValueChanged);
    courseIndexController.dispose();
    quizIndexController.removeListener(onValueChanged);
    quizIndexController.dispose();
    super.dispose();
  }

  void reset(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    debugPrint("reset");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test Page",
      home: Scaffold(
        appBar: DefaultAppbar(title: "Test Page", parentContext: context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LabelAndTextField(
                    label: "Course Index",
                    controller: courseIndexController,
                  ),
                  LabelAndTextField(
                    label: "Quiz Index",
                    controller: quizIndexController,
                  ),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            reset(context);
          },
          tooltip: 'Reset',
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}

class LabelAndTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const LabelAndTextField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          // inputFormatters: <TextInputFormatter>[
          //   FilteringTextInputFormatter.allow(
          //     RegExp(r'^\d*$'),
          //   ),
          // ],
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFF696969), // Warna border
                width: 1.0, // Lebar border
              ),
              borderRadius: BorderRadius.circular(15.0), // Radius border
            ),
          ),
        ),
      ],
    );
  }
}
