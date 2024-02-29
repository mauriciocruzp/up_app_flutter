import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;

  const TopBar({super.key, required this.title, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.center,
        color: backgroundColor,
        height: 80,
        child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomCenter,
            child: Text(title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ))),
      )
    ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(57);
}
