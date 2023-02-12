import 'package:flutter/material.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar(
      {super.key, required this.appBar, this.leading, this.leadingWidth = 50});

  final AppBar appBar;
  final Widget? leading;
  final double leadingWidth;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Image.asset(
        "assets/images/logo.png",
        scale: 4,
      ),
      leadingWidth: leadingWidth,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
