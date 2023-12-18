import 'package:amplop_duit/component/appbar/default_appbar.dart';
import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/input/row_label_input.dart';
import 'package:amplop_duit/component/switchSection/switch_section.dart';
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
  TextEditingController deskripsi = TextEditingController();
  final FocusNode _focusNode = FocusNode();
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
    _focusNode.addListener(_formatText);
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

  void _formatText() {
    int number = nominal;

    if (!_focusNode.hasFocus) {
      nominalController.text = formatToMoneyText(number.toDouble());
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(nominal.toString());
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
                    builder: (context) => const SmartFinancePage()),
              );
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SwitchSection(
                  width: 120,
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
                RowLabelInput(
                  controller: dateInput,
                  label: "Tanggal",
                  inputDecoration: const InputDecoration(
                    border: UnderlineInputBorder(),
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
                RowLabelInput(
                  controller: deskripsi,
                  label: "Deskripsi",
                  inputDecoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                ),
                RowLabelInput(
                  focusNode: _focusNode,
                  controller: nominalController,
                  label: "Nominal",
                  inputDecoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                    TextInputFormatter.withFunction(
                      (oldValue, newValue) {
                        // Mengambil nilai numerik dari teks
                        final double newNumericValue =
                            double.tryParse(newValue.text) ?? 0.0;

                        //Save Unformat Nominal
                        setState(() {
                          nominal = int.tryParse(newValue.text) ?? 0;
                        });

                        // Mengubah nilai numerik ke dalam format mata uang
                        final formattedValue =
                            formatToMoneyText(newNumericValue);

                        // Memastikan nilai controller tidak berubah terus-menerus
                        if (formattedValue != newValue.text) {
                          // Update nilai pada controller
                          nominalController.value = TextEditingValue(
                            text: formattedValue,
                            selection: TextSelection.collapsed(
                                offset: formattedValue.length),
                          );
                        }

                        return newValue;
                      },
                    ),
                  ],
                ),
                Center(
                  child: MainButton(
                    buttonText: "Menyimpan",
                    action: () {
                      debugPrint(dateInput.text);
                      debugPrint(deskripsi.text);
                      debugPrint(nominal.toString());
                      DateTime? parsedDate = convertToDate(dateInput.text);

                      if (parsedDate != null) {
                        listFinance.add(DailyFinance(
                            status: selected ? "Uang Masuk" : "Uang Keluar",
                            deskripsi: deskripsi.text,
                            datetime: parsedDate,
                            nominal: nominal));
                      } else {
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
