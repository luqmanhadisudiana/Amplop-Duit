import 'package:amplop_duit/component/appbar/default_appbar.dart';
import 'package:amplop_duit/component/customAlertDialog/custom_alert_dialog.dart';
import 'package:amplop_duit/layout/navigation_wrapper.dart';
import 'package:amplop_duit/provider.dart';
import 'package:amplop_duit/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestPage extends StatefulWidget {
  final int? currentIndex;
  const TestPage({super.key, this.currentIndex});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late CoursePointerProvider coursePointerProvider;
  TextEditingController courseIndexController = TextEditingController();
  TextEditingController quizIndexController = TextEditingController();
  TextEditingController ligaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    coursePointerProvider =
        Provider.of<CoursePointerProvider>(context, listen: false);

    courseIndexController.text =
        (coursePointerProvider.getSelectedCourse + 1).toString();
    quizIndexController.text =
        (coursePointerProvider.getselectedQuiz + 1).toString();

    courseIndexController.addListener(() {
      onValueChanged("course");
    });
    quizIndexController.addListener(() {
      onValueChanged("quiz");
    });
    ligaController.addListener(ligaValueChange);
    _getCurrentLiga();
  }

  void onValueChanged(String text) {
    debugPrint(text);
    CoursePointerProvider coursePointerProvider =
        Provider.of<CoursePointerProvider>(context, listen: false);
    CourseProvider courseProvider =
        Provider.of<CourseProvider>(context, listen: false);

    int courseIndex = int.tryParse(courseIndexController.text) ?? 1;
    int quizIndex = int.tryParse(quizIndexController.text) ?? 0;

    if (courseIndex < courseProvider.getCourseList.length) {
      coursePointerProvider.setNewValue(courseIndex - 1, quizIndex - 1);
    } else {
      warning();
    }

    if (quizIndex == 0) {
      coursePointerProvider.setNewValue(courseIndex - 1, quizIndex - 1);
    } else if (quizIndex <
        courseProvider.getCourseList[courseIndex].listQuestionAnswer.length) {
      coursePointerProvider.setNewValue(courseIndex - 1, quizIndex - 1);
    } else {
      warning();
    }
  }

  void ligaValueChange() async {
    if ((int.tryParse(ligaController.text) ?? 0) > 0 &&
        (int.tryParse(ligaController.text) ?? 0) <= 5) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('currentLiga', int.tryParse(ligaController.text) ?? 1);
    } else {
      warning();
    }
  }

  void warning() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => CustomAlertDialog(
        title: "Index Out Bound",
        desc: "Reseting value to default",
        action: () {
          courseIndexController.text = (1).toString();
          quizIndexController.text = (0).toString();
          ligaController.text = (1).toString();

          Navigator.of(context).pop();
          FocusManager.instance.primaryFocus?.unfocus(); // Unfocus TextField
        },
      ),
    );
  }

  @override
  void dispose() {
    courseIndexController.removeListener(() {
      onValueChanged("course");
    });
    courseIndexController.dispose();
    quizIndexController.removeListener(() {
      onValueChanged("quiz");
    });
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

  void _getCurrentLiga() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentLiga = prefs.getInt('currentLiga') ?? 0;

    setState(() {
      ligaController.text = currentLiga.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test Page",
      home: Scaffold(
        appBar: DefaultAppbar(
          title: "Test Page",
          parentContext: context,
          action: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => NavigationWrapper(
                        selectedIndex: widget.currentIndex ?? 0,
                      )),
            );
          },
        ),
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
                  LabelAndTextField(
                    label: "Liga Index",
                    controller: ligaController,
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
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.selection = TextSelection(
                baseOffset: 0,
                extentOffset: controller.text.length,
              );
            });
          },
        ),
      ],
    );
  }
}
