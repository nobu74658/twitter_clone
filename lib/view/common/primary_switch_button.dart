import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimarySwitchButton extends StatelessWidget {
  const PrimarySwitchButton({super.key, required this.value, this.onChanged});

  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: null,
      trailing: CupertinoSwitch(value: value, onChanged: onChanged),
    );
  }
}
