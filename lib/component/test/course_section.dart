import 'package:amplop_duit/component/input/row_label_input.dart';
import 'package:amplop_duit/models/my_course_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseStatusTestSection extends StatelessWidget {
  final List<TextEditingController> listController;
  final List<String> listLabel;
  final MyCourseStatus? localCourseStatus;
  const CourseStatusTestSection(
      {super.key,
      required this.listController,
      required this.listLabel,
      this.localCourseStatus});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 20),
        Consumer<MyCourseStatus>(builder: (context, data, child) {
          return Text(
              'Provider State Data : \nDiamond: ${data.diamond}, Heart: ${data.heart}, selectedCourse: ${data.selectedCourse}, selectedQuiz: ${data.selectedQuiz}, attempt: ${data.attempt}');
        }),
        Text(localCourseStatus != null
            ? 'Local Data : \nDiamond: ${localCourseStatus!.diamond}, Heart: ${localCourseStatus!.heart}, selectedCourse: ${localCourseStatus!.selectedCourse}, selectedQuiz: ${localCourseStatus!.selectedQuiz}, attempt: ${localCourseStatus!.attempt}'
            : "Local Data : No Data"),
        const SizedBox(height: 20),
      ],
    );
  }
}
