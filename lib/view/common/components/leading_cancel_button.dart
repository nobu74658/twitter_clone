import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeadingCancelButton extends StatelessWidget {
  const LeadingCancelButton(
    this.context, {
    super.key,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style:
          ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.black)),
      child: const Text(
        "キャンセル",
      ),
      onPressed: () {
        context.pop();
      },
    );
  }
}
