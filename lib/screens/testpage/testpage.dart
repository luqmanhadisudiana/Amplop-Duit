import 'package:amplop_duit/component/appbar/default_appbar.dart';
import 'package:amplop_duit/component/customAlertDialog/custom_alert_dialog.dart';
import 'package:amplop_duit/component/input/row_label_input.dart';
import 'package:amplop_duit/component/table/data/default_row_data.dart';
import 'package:amplop_duit/component/table/table_header.dart';
import 'package:amplop_duit/component/table/table_row.dart';
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

  late ListMonthlyFinance providerListMonthlyFinance;
  late ListDailyFinance providerListDailyFinance;
  bool loadingState = false;

  void setAndSaved() {
    providerListDailyFinance =
        Provider.of<ListDailyFinance>(context, listen: false);
    providerListMonthlyFinance =
        Provider.of<ListMonthlyFinance>(context, listen: false);

    providerListMonthlyFinance.addBatch(listMonthlyFinance);
    providerListDailyFinance.addBatch(listFinance);
    providerListMonthlyFinance.saveToSharedPreferences();
    providerListDailyFinance.saveToSharedPreferences();
    debugPrint("done");
  }

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> listController = [
      ligaController,
      courseIndexController,
      quizIndexController,
      heartController,
      diamondController
    ];
    List<String> listLabel = [
      "Liga Index",
      "Course Index + 1",
      "Quiz Index + 1",
      "Heart",
      "Diamond"
    ];
    return MaterialApp(
      title: "Test Page",
      home: Scaffold(
        appBar: DefaultAppbar(
          title: "Test Page",
          parentContext: context,
          action: () {
            Navigator.pop(context);
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
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (var i = 0; i < listController.length; i++)
                      RowLabelInput(
                        label: listLabel[i],
                        controller: listController[i],
                        textInputType: TextInputType.number,
                        inputDecoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                          ),
                        ),
                      ),
                    Consumer<MyCourseStatus>(
                        builder: (context, myCourseStatus, child) {
                      return Text(
                          'Provider State Data : \nDiamond: ${myCourseStatus.diamond}, Heart: ${myCourseStatus.heart}, selectedCourse: ${myCourseStatus.selectedCourse}, selectedQuiz: ${myCourseStatus.selectedQuiz}, ');
                    }),
                    Text(_myCourseStatus != null
                        ? 'Local Data : \nDiamond: ${_myCourseStatus!.diamond}, Heart: ${_myCourseStatus!.heart}, selectedCourse: ${_myCourseStatus!.selectedCourse}, selectedQuiz: ${_myCourseStatus!.selectedQuiz},'
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
                    SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                                    const TableHeader(headerData: [
                                      "Course Index",
                                      "Quiz Index",
                                      "IndexSavedAnswer"
                                    ]),
                                    mySavedAnswer.listSavedAnswer.isEmpty
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            height: 100,
                                            width: double.maxFinite,
                                            color: const Color(0xFFEDEDED),
                                            child: const Center(
                                              child: Text(
                                                "Kosong",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFD1D1D1)),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    for (var i = 0;
                                        i <
                                            mySavedAnswer
                                                .listSavedAnswer.length;
                                        i++)
                                      TableRowData(childList: [
                                        DefaultRowData(
                                            text: mySavedAnswer
                                                .listSavedAnswer[i].courseIndex
                                                .toString()),
                                        DefaultRowData(
                                            text: mySavedAnswer
                                                .listSavedAnswer[i].quizIndex
                                                .toString()),
                                        DefaultRowData(
                                            text: mySavedAnswer
                                                .listSavedAnswer[i]
                                                .indexSavedAnswer
                                                .toString()),
                                      ], useDivider: true)
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Finance
                    SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                debugPrint(
                                    "Set Provider Finance to Dummy Data");
                                setAndSaved();
                              },
                              child: const Text('Set Provider to Dummy Data'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("Data Monthly Finance"),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("Data Dummy"),
                                Column(
                                  children: [
                                    const TableHeader(
                                      headerData: [
                                        "Date",
                                        "Nominal",
                                      ],
                                      customWidth: [0.5, 0.5],
                                    ),
                                    listMonthlyFinance.isEmpty
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            height: 100,
                                            width: double.maxFinite,
                                            color: const Color(0xFFEDEDED),
                                            child: const Center(
                                              child: Text(
                                                "Kosong",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFD1D1D1)),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    for (var i = 0;
                                        i < listMonthlyFinance.length;
                                        i++)
                                      TableRowData(childList: [
                                        DefaultRowData(
                                            text: DateFormat('MM.yyyy').format(
                                                listMonthlyFinance[i]
                                                    .datetime)),
                                        DefaultRowData(
                                            text: listMonthlyFinance[i]
                                                .nominal
                                                .toString()),
                                      ], customWidth: const [
                                        0.5,
                                        0.5
                                      ]),
                                  ],
                                ),
                                const Text("Data Provider"),
                                Consumer<ListMonthlyFinance>(
                                    builder: (context, data, child) {
                                  return Column(
                                    children: [
                                      const TableHeader(
                                        headerData: [
                                          "Date",
                                          "Nominal",
                                        ],
                                        customWidth: [0.5, 0.5],
                                      ),
                                      data.listMonthlyFinance.isEmpty
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30.0),
                                              height: 100,
                                              width: double.maxFinite,
                                              color: const Color(0xFFEDEDED),
                                              child: const Center(
                                                child: Text(
                                                  "Kosong",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xFFD1D1D1)),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      for (var i = 0;
                                          i < data.listMonthlyFinance.length;
                                          i++)
                                        TableRowData(childList: [
                                          DefaultRowData(
                                              text: DateFormat('MM.yyyy')
                                                  .format(data
                                                      .listMonthlyFinance[i]
                                                      .datetime)),
                                          DefaultRowData(
                                              text: data
                                                  .listMonthlyFinance[i].nominal
                                                  .toString()),
                                        ], customWidth: const [
                                          0.5,
                                          0.5
                                        ]),
                                    ],
                                  );
                                })
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("Data Dummy Daily Finance"),
                                Column(
                                  children: [
                                    const TableHeader(
                                      headerData: [
                                        "Date",
                                        "Nominal",
                                        "Date",
                                        "Nominal",
                                      ],
                                      customWidth: [0.25, 0.25, 0.25, 0.25],
                                    ),
                                    listMonthlyFinance.isEmpty
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            height: 100,
                                            width: double.maxFinite,
                                            color: const Color(0xFFEDEDED),
                                            child: const Center(
                                              child: Text(
                                                "Kosong",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFD1D1D1)),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    for (var i = 0; i < listFinance.length; i++)
                                      TableRowData(childList: [
                                        DefaultRowData(
                                            text: DateFormat('dd.MM.yyyy')
                                                .format(
                                                    listFinance[i].datetime)),
                                        DefaultRowData(
                                            text: listFinance[i]
                                                .nominal
                                                .toString()),
                                        DefaultRowData(
                                            text: listFinance[i]
                                                .deskripsi
                                                .toString()),
                                        DefaultRowData(
                                            text: listFinance[i]
                                                .status
                                                .toString()),
                                      ], customWidth: const [
                                        0.25,
                                        0.25,
                                        0.25,
                                        0.25
                                      ]),
                                  ],
                                ),
                                const Text("Data Provider"),
                                Consumer<ListDailyFinance>(
                                    builder: (context, data, child) {
                                  return Column(
                                    children: [
                                      const TableHeader(
                                        headerData: [
                                          "Date",
                                          "Nominal",
                                          "Date",
                                          "Nominal",
                                        ],
                                        customWidth: [0.25, 0.25, 0.25, 0.25],
                                      ),
                                      data.listDailyFinance.isEmpty
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30.0),
                                              height: 100,
                                              width: double.maxFinite,
                                              color: const Color(0xFFEDEDED),
                                              child: const Center(
                                                child: Text(
                                                  "Kosong",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xFFD1D1D1)),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      for (var i = 0;
                                          i < data.listDailyFinance.length;
                                          i++)
                                        TableRowData(childList: [
                                          DefaultRowData(
                                              text: DateFormat('dd.MM.yyyy')
                                                  .format(data
                                                      .listDailyFinance[i]
                                                      .datetime)),
                                          DefaultRowData(
                                              text: data
                                                  .listDailyFinance[i].nominal
                                                  .toString()),
                                          DefaultRowData(
                                              text: data
                                                  .listDailyFinance[i].deskripsi
                                                  .toString()),
                                          DefaultRowData(
                                              text: data
                                                  .listDailyFinance[i].status
                                                  .toString()),
                                        ], customWidth: const [
                                          0.25,
                                          0.25,
                                          0.25,
                                          0.25
                                        ]),
                                    ],
                                  );
                                })
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ],
            ),
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
