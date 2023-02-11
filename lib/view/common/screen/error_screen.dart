import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/utils/path.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Text("ページが見つかりませんでした。"),
          ElevatedButton(
            onPressed: () => context.go(kInitialPath),
            child: Text("戻る"),
          ),
        ],
      ),
    );
  }
}
