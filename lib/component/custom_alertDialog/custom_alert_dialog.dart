import 'package:amplop_duit/component/button/main_button.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title, desc;
  final Widget customIcon;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.desc,
    this.customIcon = const DefaultCustomIcon(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFD6CFEF),
      elevation: 8.0, // elevasi untuk efek shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      title: Column(
        children: [
          customIcon,
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins"),
          ),
        ],
      ),
      content: IntrinsicHeight(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            desc,
            style: const TextStyle(fontSize: 8, fontFamily: "Poppins"),
          ),
        ),
      ),
      actions: [
        Align(
          alignment: Alignment.center,
          child: MainButton(
            width: 100,
            height: 50,
            fontSize: 12,
            buttonText: "Oke",
            bgColor: const Color(0xFFFF6E30),
            action: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  // Fungsi untuk menampilkan AlertDialog kustom
  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: title,
          desc: desc,
        );
      },
    );
  }
}

class DefaultCustomIcon extends StatelessWidget {
  const DefaultCustomIcon({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.warning,
      color: Colors.orange,
      size: 60,
    );
  }
}
