import 'package:amplop_duit/component/appbar/default_appbar.dart';
import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/customAlertDialog/custom_alert_dialog.dart';
import 'package:amplop_duit/component/input/row_label_input.dart';
import 'package:amplop_duit/component/switchSection/switch_section.dart';
import 'package:amplop_duit/layout/navigation_wrapper.dart';
import 'package:amplop_duit/models/finance.dart';
import 'package:amplop_duit/screens/smart%20finance/smart_finance.dart';
import 'package:amplop_duit/theme.dart';
import 'package:amplop_duit/util/formated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';

class PendapatanPage extends StatefulWidget {
  const PendapatanPage({super.key});

  @override
  State<PendapatanPage> createState() => _PendapatanPageState();
}

class _PendapatanPageState extends State<PendapatanPage> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  TextEditingController nominalFormattedController = TextEditingController();
  TextEditingController nominalHiddenController = TextEditingController();

  TextEditingController deskripsi = TextEditingController();
  // final FocusNode _focusNode = FocusNode();
  final FocusNode _hiddenInputFocusNode = FocusNode();
  int nominal = 0;

  bool selected = true;

  void changeSelected() {
    setState(() {
      selected = !selected;
    });
  }

  @override
  void initState() {
    super.initState();
    dateInput.text = ""; //set the initial value of text field
    // _focusNode.addListener(_formatText);
    nominalHiddenController.addListener(() {
      nominalHiddenController.selection =
          TextSelection.collapsed(offset: nominalHiddenController.text.length);
      String visibleInputValue = nominalHiddenController.text;
      int temp = int.tryParse(visibleInputValue) ?? 0;
      double tempDouble = temp.toDouble();
      nominalFormattedController.text =
          formatToMoneyText(tempDouble, decimal: 0);
      setState(() {
        nominal = temp;
      });
    });
  }

  void datePickAction() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now());

    if (pickedDate != null) {
      debugPrint(pickedDate
          .toString()); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      debugPrint(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      setState(() {
        dateInput.text = formattedDate; //set output date to TextField value.
      });
    }
  }

  DateTime? convertToDate(String input) {
    try {
      // Membuat objek DateFormat dengan format yang sesuai
      final DateFormat format = DateFormat('dd/MM/yyyy');
      // Parse String menjadi DateTime
      return format.parseStrict(input);
    } catch (e) {
      // Jika parsing gagal, kembalikan null
      return null;
    }
  }

  // void _formatText() {
  //   int number = nominal;

  //   if (!_focusNode.hasFocus) {
  //     nominalController.text = formatToMoneyText(number.toDouble());
  //   }
  // }

  @override
  void dispose() {
    dateInput.dispose();
    nominalController.dispose();
    nominalFormattedController.dispose();
    nominalHiddenController.dispose();
    deskripsi.dispose();
    _hiddenInputFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pendapatan',
        theme: MyAppTheme.buildTheme(),
        home: Scaffold(
          appBar: DefaultAppbar(
            title: "Pendapatan",
            parentContext: context,
            action: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const NavigationWrapper(
                          selectedIndex: 2,
                        )),
              );
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SwitchSection(
                  width: 150,
                  spacerWidth: 40,
                  leftLabel: "Uang Masuk",
                  rightLabel: "Uang Keluar",
                  selected: selected,
                  action: () {
                    changeSelected();
                    dateInput.text = "";
                    nominalController.text = "";
                    deskripsi.text = "";
                    setState(() {
                      nominal = 0;
                    });
                  },
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Column(
                    children: [
                      RowLabelInput(
                        controller: dateInput,
                        label: "Tanggal",
                        inputDecoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                            ),
                            onPressed: null,
                          ),
                        ),
                        readOnly: true,
                        action: () {
                          datePickAction();
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RowLabelInput(
                        controller: deskripsi,
                        label: "Deskripsi",
                        inputDecoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RowLabelInput(
                        controller: nominalFormattedController,
                        label: "Nominal",
                        textInputType: TextInputType.number,
                        inputDecoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                          ),
                        ),
                        readOnly: true,
                        action: () {
                          FocusScope.of(context)
                              .requestFocus(_hiddenInputFocusNode);
                        },
                      ),

                      // Hidden Input
                      Opacity(
                        opacity: 0.0,
                        child: RowLabelInput(
                          controller: nominalHiddenController,
                          focusNode: _hiddenInputFocusNode,
                          label: "Nominal",
                          textInputType: TextInputType.number,
                          inputDecoration: const InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFE9E9E9))),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF5338BC)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: MainButton(
                    buttonText: "Menyimpan",
                    action: () {
                      debugPrint(dateInput.text);
                      debugPrint(deskripsi.text);
                      debugPrint(nominal.toString());
                      DateTime? parsedDate = convertToDate(dateInput.text);

                      if (parsedDate != null && nominal != 0) {
                        listFinance.add(DailyFinance(
                            status: selected ? "Uang Masuk" : "Uang Keluar",
                            deskripsi: deskripsi.text,
                            datetime: parsedDate,
                            nominal: nominal));

                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                CustomAlertDialog(
                                  title: "Data Berhasil ditambahkan",
                                  desc:
                                      '${selected ? "Uang masuk" : "Uang keluar"} sebesar ${formatToMoneyText(nominal.toDouble())} untuk ${deskripsi.text}',
                                  customIcon: const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  ),
                                  action: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SmartFinancePage(
                                                isDisplayBulanan: false,
                                              )),
                                    );
                                  },
                                ));
                      } else {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                const CustomAlertDialog(
                                    title: "Data Tidak berhasil ditambahkan",
                                    desc:
                                        'Periksa kembali saat penginputan data'));

                        debugPrint("Gagal");
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
