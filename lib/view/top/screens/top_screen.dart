import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/view/common/components/primary_app_bar.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(appBar: AppBar()),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: const Text("サインアウト"),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => context.go(kInitialPath),
            child: const Text("戻る"),
          ),
        ],
      ),
    );
  }
}
