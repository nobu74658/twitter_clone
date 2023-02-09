import 'package:flutter/material.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({super.key, required this.appBar, required this.widget});

  final AppBar appBar;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Image.asset(
        "assets/images/logo.png",
        scale: 4,
      ),
      leadingWidth: 100,
      leading: widget,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
