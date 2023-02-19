import 'package:flutter/material.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar(
      {super.key,
      required this.appBar,
      this.leading,
      this.leadingWidth = 50,
      this.actions});

  final AppBar appBar;
  final Widget? leading;
  final double leadingWidth;
  final List<Widget>? actions;

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
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
