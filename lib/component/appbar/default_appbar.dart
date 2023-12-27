import 'package:flutter/material.dart';

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final BuildContext parentContext;
  final Function? action;
  final TabBar? bottom;
  final double? height;

  const DefaultAppbar(
      {super.key,
      required this.title,
      required this.parentContext,
      this.action,
      this.bottom,
      this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: "Poppins", fontSize: 16, fontWeight: FontWeight.w500),
      ),
      bottom: bottom,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (action != null) {
            action!();
          } else {
            Navigator.pop(parentContext);
          }
        },
      ),
    );
  }
}
