import 'package:amplop_duit/component/appbar/default_appbar.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PendapatanPage extends StatefulWidget {
  const PendapatanPage({super.key});

  // final String? restorationId;

  @override
  State<PendapatanPage> createState() => _PendapatanPageState();
}

class _PendapatanPageState extends State<PendapatanPage> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pendapatan',
        theme: MyAppTheme.buildTheme(),
        home: Scaffold(
          appBar: DefaultAppbar(title: "Pendapatan", parentContext: context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("Label"),
                    Expanded(
                      child: TextField(
                          controller: dateInput,
                          //editing controller of this TextField
                          decoration: InputDecoration(
                            // icon: Icon(Icons.calendar_today), //icon of text field
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              ),
                              onPressed: null,
                            ),
                            // labelText: "Enter Date" //label text of field
                          ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              debugPrint(pickedDate
                                  .toString()); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                              debugPrint(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              setState(() {
                                dateInput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            }
                          }),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text("Label"),
                    Expanded(child: const TextField()),
                  ],
                ),
                Row(
                  children: [
                    const Text("Label"),
                    Expanded(child: const TextField()),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
