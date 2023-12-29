import 'package:amplop_duit/component/appbar/default_appbar.dart';
import 'package:amplop_duit/component/customAlertDialog/custom_alert_dialog.dart';
import 'package:amplop_duit/component/test/course_section.dart';
import 'package:amplop_duit/component/test/finance_section.dart';
import 'package:amplop_duit/component/test/history_section.dart';
import 'package:amplop_duit/component/test/saved_answer_section.dart';
import 'package:amplop_duit/layout/navigation_wrapper.dart';
import 'package:amplop_duit/models/finance.dart';
import 'package:amplop_duit/models/history.dart';
import 'package:amplop_duit/models/my_course_status.dart';
import 'package:amplop_duit/provider.dart';
import 'package:amplop_duit/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestPage extends StatefulWidget {
  final int? currentIndex;
  const TestPage({super.key, this.currentIndex});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TextEditingController ligaController = TextEditingController();
  TextEditingController courseIndexController = TextEditingController();
  TextEditingController quizIndexController = TextEditingController();
  TextEditingController heartController = TextEditingController();
  TextEditingController diamondController = TextEditingController();
  TextEditingController itemsController = TextEditingController();
  TextEditingController totalPointController = TextEditingController();

  @override
  void initState() {
    super.initState();
    itemsController.text = 3.toString();
    courseIndexController.addListener(() {
      onValueChanged("Course");
    });
    quizIndexController.addListener(() {
      onValueChanged("Quiz");
    });
    heartController.addListener(() {
      onValueChanged("Heart");
    });
    diamondController.addListener(() {
      onValueChanged("Diamond");
    });
    ligaController.addListener(ligaValueChange);
    totalPointController.addListener(totalPointChange);

    _getCurrentLiga();
    _loadMyObject();
    _getCurrentExpired();
    _getTotalPoint();
  }

  DateTime? expirationDate;
  DateTime? expirationDateWeekly;

  void _getCurrentExpired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? expirationDateString = prefs.getString("ExpiredDaily");
    String? expirationDateStringWeekly = prefs.getString("ExpiredWeekly");

    if (expirationDateString != null) {
      expirationDate = DateTime.parse(expirationDateString);
    }

    if (expirationDateStringWeekly != null) {
      expirationDateWeekly = DateTime.parse(expirationDateStringWeekly);
    }
  }

  void _getTotalPoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentTotalPoint = prefs.getInt('totalPoint') ?? 0;

    setState(() {
      totalPointController.text = currentTotalPoint.toString();
    });
  }

  void totalPointChange() async {
    debugPrint("Change Total Point");
    if (totalPointController.text != "") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('totalPoint', int.tryParse(totalPointController.text) ?? 0);
    }
  }

  void _getCurrentLiga() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentLiga = prefs.getInt('currentLiga') ?? 0;

    setState(() {
      ligaController.text = currentLiga.toString();
    });
  }

  void ligaValueChange() async {
    if (ligaController.text != "") {
      if ((int.tryParse(ligaController.text) ?? 0) > 0 &&
          (int.tryParse(ligaController.text) ?? 0) <= 5) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('currentLiga', int.tryParse(ligaController.text) ?? 1);
      } else {
        warning("liga");
      }
    }
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
    debugPrint("Length $courseLength");

    debugPrint(
        'listening $text, quizIndex : $quizIndex, courseIndex $courseIndex, heart : $heart, diamond $diamond');

    if (_myCourseStatus != null && courseIndex != 0) {
      if (courseIndex <= courseLength && courseIndex >= 1) {
        debugPrint("set");

        setState(() {
          _myCourseStatus!
              .setNewValue(heart, diamond, courseIndex - 1, quizIndex - 1);
        });
        localmyCourseStatus.setNewValue(
            heart, diamond, courseIndex - 1, quizIndex - 1);
      } else {
        warning("course");
      }

      int quizLenght = courseProvider
          .getCourseList[courseIndex - 1].listQuestionAnswer.length;

      if (quizIndex <= quizLenght && quizIndex >= 0) {
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
    itemsController.dispose();

    super.dispose();
  }

  void reset(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    debugPrint("pref clear");

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

    providerListDailyFinance =
        Provider.of<ListDailyFinance>(context, listen: false);
    providerListDailyFinance.resetMyObject();
    providerListMonthlyFinance =
        Provider.of<ListMonthlyFinance>(context, listen: false);
    providerListMonthlyFinance.resetMyObject();
    debugPrint("reset finance");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void resetMyCourse() {
    setState(() {
      _myCourseStatus = MyCourseStatus(
          heart: 5, diamond: 5, selectedCourse: 0, selectedQuiz: -1);
    });
    courseIndexController.text = (1).toString();
    quizIndexController.text = (0).toString();
    heartController.text = (5).toString();
    diamondController.text = (5).toString();
    ligaController.text = (1).toString();
  }

  ListSavedAnswer? mySavedAnswer;
  bool showListSavedAnswer = false;

  void getFunction() async {
    var localmySavedAnswer =
        Provider.of<ListSavedAnswer>(context, listen: false);

    debugPrint("Get Data ${localmySavedAnswer.listSavedAnswer.length}");
    setState(() {
      mySavedAnswer = localmySavedAnswer;
      showListSavedAnswer = true;
    });
  }

  List<MonthlyFinance> listMonthlyFinance = [];
  List<DailyFinance> listFinance = [];

  late ListMonthlyFinance providerListMonthlyFinance;
  late ListDailyFinance providerListDailyFinance;
  bool loadingState = false;

  void setAndSaved() {
    providerListDailyFinance =
        Provider.of<ListDailyFinance>(context, listen: false);
    providerListMonthlyFinance =
        Provider.of<ListMonthlyFinance>(context, listen: false);

    if (listMonthlyFinance.isNotEmpty && listFinance.isNotEmpty) {
      providerListMonthlyFinance.addBatch(listMonthlyFinance);
      providerListDailyFinance.addBatch(listFinance);
      providerListMonthlyFinance.saveToSharedPreferences();
      providerListDailyFinance.saveToSharedPreferences();
      debugPrint("done");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> listController = [
      totalPointController,
      ligaController,
      courseIndexController,
      quizIndexController,
      heartController,
      diamondController
    ];
    List<String> listLabel = [
      "Total Point",
      "Liga Index",
      "Course Index + 1\nMax 5",
      "Quiz Index + 1 \nMax 5",
      "Heart",
      "Diamond"
    ];
    return MaterialApp(
      title: "Test Page",
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: DefaultAppbar(
            height: 100,
            title: "Test Page",
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Course'),
                Tab(text: 'SavedAnswer'),
                Tab(text: 'Finance'),
                Tab(text: 'History'),
              ],
            ),
            parentContext: context,
            action: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => NavigationWrapper(
                          selectedIndex: widget.currentIndex ?? 4,
                        )),
              );
            },
          ),
          body: TabBarView(
            children: [
              // Tab 1
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      expirationDate != null
                          ? Text(
                              'heart & diamond reset at : ${DateFormat().format(expirationDate!)}')
                          : const Text("Tidak Ada Expired Date"),
                      expirationDateWeekly != null
                          ? Text(
                              'course reset at : ${DateFormat().format(expirationDateWeekly!)}')
                          : const Text("Tidak Ada Expired Date"),
                    ],
                  ),
                  CourseStatusTestSection(
                    listController: listController,
                    listLabel: listLabel,
                    localCourseStatus: _myCourseStatus,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Consumer<MyCourseStatus>(
                          builder: (context, myCourseStatus, child) {
                        return ElevatedButton(
                          onPressed: () {
                            //Provider
                            resetMyCourse();
                            myCourseStatus.setNewValue(5, 5, 0, -1);
                            myCourseStatus.saveSharedPreferences();
                          },
                          child: const Text('Reset My Status Course'),
                        );
                      }),
                      Consumer<MyCourseStatus>(
                          builder: (context, myCourseStatus, child) {
                        return ElevatedButton(
                          onPressed: () {
                            //Provider
                            resetMyCourse();
                            myCourseStatus.setNewValue(
                                5,
                                5,
                                myCourseStatus.getSelectedCourse,
                                myCourseStatus.getselectedQuiz);
                            myCourseStatus.saveSharedPreferences();
                          },
                          child: const Text('Reset Heart and Diamond'),
                        );
                      })
                    ],
                  )
                ],
              ),
              // SavedAnswer
              SavedAnswerTestSection(
                  getListFunction: getFunction,
                  isShowlist: showListSavedAnswer,
                  mySavedAnswer: mySavedAnswer),
              // Finance
              SingleChildScrollView(
                child: FinanceTestSection(
                    itemsController: itemsController,
                    listFinance: listFinance,
                    listMonthlyFinance: listMonthlyFinance,
                    setAndSaved: setAndSaved,
                    generateFunction: () {
                      ListFinanceHelper newResult =
                          generateList(int.tryParse(itemsController.text) ?? 0);

                      setState(() {
                        listFinance = newResult.listFinance;
                        listMonthlyFinance = newResult.listMonthlyFinance;
                      });
                    }),
              ),

              // History
              const HistoryStatusTestSection(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              reset(context);
            },
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),
        ),
      ),
    );
  }
}
