import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  final List<String> headerData;
  final List<double> customWidth;
  const TableHeader(
      {super.key,
      required this.headerData,
      this.customWidth = const [0.20, 0.4, 0.4]});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double containerWidth = constraints.maxWidth;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var i = 0; i < headerData.length; i++)
            Container(
              width: containerWidth * customWidth[i],
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: i < 1
                    ? null
                    : const Border(
                        left: BorderSide(color: Color(0xFFE9E9E9), width: 1.0)),
              ),
              child: Center(
                  child: Text(
                headerData[i],
                style: const TextStyle(
                  color: Color(0xFF2F2F2F),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              )),
            ),
        ],
      );
    });
  }
}

// import 'package:flutter/material.dart';

// class TableHeader extends StatelessWidget {
//   final String text;
//   final bool leftBorder;
//   const TableHeader({super.key, required this.text, this.leftBorder = true});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: leftBorder
//               ? const Border(
//                   left: BorderSide(color: Color(0xFFE9E9E9), width: 1.0))
//               : null,
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(
//             color: Color(0xFF2F2F2F),
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }
