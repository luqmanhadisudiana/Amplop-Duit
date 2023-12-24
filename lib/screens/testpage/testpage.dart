import 'package:amplop_duit/component/appbar/default_appbar.dart';
import 'package:amplop_duit/component/customAlertDialog/custom_alert_dialog.dart';
import 'package:amplop_duit/layout/navigation_wrapper.dart';
import 'package:amplop_duit/models/history.dart';
import 'package:amplop_duit/models/my_course_status.dart';
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
  TextEditingController courseIndexController = TextEditingController();
  TextEditingController quizIndexController = TextEditingController();
  TextEditingController ligaController = TextEditingController();
  TextEditingController heartController = TextEditingController();
  TextEditingController diamondController = TextEditingController();

  @override
  void initState() {
    super.initState();
    courseIndexController.addListener(() {
      onValueChanged("Course");
    });
    quizIndexController.addListener(() {
      onValueChanged("Quiz");
    });
    ligaController.addListener(ligaValueChange);
    heartController.addListener(() {
      onValueChanged("Heart");
    });
    diamondController.addListener(() {
      onValueChanged("Diamond");
    });

    _getCurrentLiga();
    _loadMyObject();
  }

  void _getCurrentLiga() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentLiga = prefs.getInt('currentLiga') ?? 0;

    setState(() {
      ligaController.text = currentLiga.toString();
    });
  }

  MyCourseStatus? _myCourseStatus;

  Future<void> _loadMyObject() async {
    MyCourseStatus myCourseStatus =
        Provider.of<MyCourseStatus>(context, listen: false);
    await myCourseStatus.loadFromSharedPreferences();

    courseIndexController.text =
        (myCourseStatus.getSelectedCourse + 1).toString();
    quizIndexController.text = (myCourseStatus.getselectedQuiz + 1).toString();
    heartController.text = myCourseStatus.heart.toString();
    diamondController.text = myCourseStatus.diamond.toString();

    setState(() {
      _myCourseStatus = myCourseStatus;
    });
  }

  void onValueChanged(String text) {
    CourseProvider courseProvider =
        Provider.of<CourseProvider>(context, listen: false);
    MyCourseStatus localmyCourseStatus =
        Provider.of<MyCourseStatus>(context, listen: false);

    int courseIndex = int.tryParse(courseIndexController.text) ?? 0;
    int quizIndex = int.tryParse(quizIndexController.text) ?? 0;
    int heart = int.tryParse(heartController.text) ?? 0;
    int diamond = int.tryParse(diamondController.text) ?? 0;

    int courseLength = courseProvider.getCourseList.length;

    debugPrint(
        'listening $text, quizIndex : $quizIndex, courseIndex $courseIndex, heart : $heart, diamond $diamond');

    if (_myCourseStatus != null && courseIndex != 0) {
      if (courseIndex < courseLength && courseIndex >= 1) {
        setState(() {
          _myCourseStatus!
              .setNewValue(heart, diamond, courseIndex - 1, quizIndex - 1);
        });
        localmyCourseStatus.setNewValue(
            heart, diamond, courseIndex - 1, quizIndex - 1);
      } else {
        warning("course");
      }

      int quizLenght =
          courseProvider.getCourseList[courseIndex].listQuestionAnswer.length;

      if (quizIndex < quizLenght && quizIndex >= 0) {
        setState(() {
          _myCourseStatus!
              .setNewValue(heart, diamond, courseIndex - 1, quizIndex - 1);
        });
        localmyCourseStatus.setNewValue(
            heart, diamond, courseIndex - 1, quizIndex - 1);
      } else {
        warning("quiz");
      }
    }
    localmyCourseStatus.saveSharedPreferences();
  }

  void ligaValueChange() async {
    if ((int.tryParse(ligaController.text) ?? 0) > 0 &&
        (int.tryParse(ligaController.text) ?? 0) <= 5) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('currentLiga', int.tryParse(ligaController.text) ?? 1);
    } else {
      warning("liga");
    }
  }

  void warning(String text) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => CustomAlertDialog(
        title: "Index Out Bound",
        desc: "Reseting value to default",
        action: () {
          if (text.toLowerCase() == "course") {
            courseIndexController.text = (1).toString();
          }
          if (text.toLowerCase() == "quiz") {
            quizIndexController.text = (0).toString();
          }
          if (text.toLowerCase() == "heart") {
            heartController.text = (5).toString();
          }
          if (text.toLowerCase() == "diamond") {
            diamondController.text = (5).toString();
          }
          if (text.toLowerCase() == "liga") {
            ligaController.text = (1).toString();
          }

          Navigator.of(context).pop();
          FocusManager.instance.primaryFocus?.unfocus(); // Unfocus TextField
        },
      ),
    );
  }

  @override
  void dispose() {
    courseIndexController.removeListener(() {
      onValueChanged("Course");
    });
    quizIndexController.removeListener(() {
      onValueChanged("Quiz");
    });
    heartController.removeListener(() {
      onValueChanged("Heart");
    });
    diamondController.removeListener(() {
      onValueChanged("Diamond");
    });
    ligaController.addListener(ligaValueChange);
    courseIndexController.dispose();
    quizIndexController.dispose();
    heartController.dispose();
    diamondController.dispose();
    ligaController.dispose();

    super.dispose();
  }

  void reset(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    debugPrint("pref clear");

    // CourseProvider localCourseProvider =
    //     Provider.of<CourseProvider>(context, listen: false);
    // localCourseProvider.reset();

    MyCourseStatus localmyCourseStatus =
        Provider.of<MyCourseStatus>(context, listen: false);
    localmyCourseStatus.reset();
    localmyCourseStatus.resetMyObject();
    debugPrint("reset object");

    ListSavedAnswer localMySavedAnswer =
        Provider.of<ListSavedAnswer>(context, listen: false);
    localMySavedAnswer.resetMyObject();
    debugPrint("reset saved answer");

    HistoryList localHistoryList =
        Provider.of<HistoryList>(context, listen: false);
    localHistoryList.resetMyObject();
    debugPrint("reset history");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  late ListSavedAnswer mySavedAnswer;
  bool showListSavedAnswer = false;

  void getFunction() async {
    var localmySavedAnswer =
        Provider.of<ListSavedAnswer>(context, listen: false);

    debugPrint("Get Data");
    setState(() {
      mySavedAnswer = localmySavedAnswer;
      showListSavedAnswer = true;
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
                    label: "Liga Index",
                    controller: ligaController,
                  ),
                  LabelAndTextField(
                    label: "Course Index + 1",
                    controller: courseIndexController,
                  ),
                  LabelAndTextField(
                    label: "Quiz Index  + 1",
                    controller: quizIndexController,
                  ),
                  LabelAndTextField(
                    label: "Heart",
                    controller: heartController,
                  ),
                  LabelAndTextField(
                    label: "Diamond",
                    controller: diamondController,
                  ),
                  Consumer<MyCourseStatus>(
                      builder: (context, myCourseStatus, child) {
                    return Text(
                        'Provider Data : \nDiamond: ${myCourseStatus.diamond}, Heart: ${myCourseStatus.heart}, selectedCourse: ${myCourseStatus.selectedCourse}, selectedQuiz: ${myCourseStatus.selectedQuiz}, ');
                  }),
                  Text(_myCourseStatus != null
                      ? 'SharedPreference Data : \nDiamond: ${_myCourseStatus!.diamond}, Heart: ${_myCourseStatus!.heart}, selectedCourse: ${_myCourseStatus!.selectedCourse}, selectedQuiz: ${_myCourseStatus!.selectedQuiz},'
                      : "No Data"),
                  const SizedBox(height: 20),
                  Consumer<MyCourseStatus>(
                      builder: (context, myCourseStatus, child) {
                    return ElevatedButton(
                      onPressed: () {
                        //Object
                        setState(() {
                          _myCourseStatus = MyCourseStatus(
                              heart: 5,
                              diamond: 5,
                              selectedCourse: 0,
                              selectedQuiz: -1);
                        });
                        //Provider
                        myCourseStatus.setNewValue(5, 5, 0, -1);
                        myCourseStatus.saveSharedPreferences();
                        //Controller
                        courseIndexController.text = (1).toString();
                        quizIndexController.text = (0).toString();
                        heartController.text = (5).toString();
                        diamondController.text = (5).toString();
                        ligaController.text = (1).toString();
                      },
                      child: const Text('Reset'),
                    );
                  }),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      debugPrint("starting");
                      getFunction();
                    },
                    child: const Text('Get Saved Answer'),
                  ),
                  showListSavedAnswer
                      ? Column(
                          children: [
                            mySavedAnswer.listSavedAnswer.isEmpty
                                ? const Text("No Data")
                                : const SizedBox(),
                            for (var i = 0;
                                i < mySavedAnswer.listSavedAnswer.length;
                                i++)
                              Text(
                                  '${mySavedAnswer.listSavedAnswer[i].courseIndex}, ${mySavedAnswer.listSavedAnswer[i].quizIndex},${mySavedAnswer.listSavedAnswer[i].indexSavedAnswer}')
                          ],
                        )
                      : const SizedBox()
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
