import 'package:amplop_duit/component/button/main_button.dart';
import 'package:flutter/material.dart';

class ActionItem {
  final String text;
  final Color color;
  final Function()? onPressed;

  ActionItem({required this.text, this.onPressed, required this.color});
}

class CustomAlertDialog extends StatelessWidget {
  final String title, desc;
  final Widget customIcon;
  final Function? action;
  final List<ActionItem>? actions;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.desc,
    this.customIcon = const DefaultCustomIcon(),
    this.action,
    this.actions,
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
      actions: actions != null
          ? actions!
              .map((item) => MainButton(
                    width: 100,
                    height: 50,
                    fontSize: 12,
                    buttonText: item.text,
                    bgColor: item.color,
                    action: () {
                      debugPrint("Button clicked: ${item.text}");
                      if (item.onPressed != null) {
                        item.onPressed!();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ))
              .toList()
          : [
              Align(
                alignment: Alignment.center,
                child: MainButton(
                  width: 100,
                  height: 50,
                  fontSize: 12,
                  buttonText: "Oke",
                  bgColor: const Color(0xFFFF6E30),
                  action: () {
                    debugPrint("Bottom modal click!");
                    if (action != null) {
                      action!();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
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
