import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/utils/styles.dart';
import 'package:twitter_clone/view/common/components/primary_app_bar.dart';

class CheckInviteEmailScreen extends StatelessWidget {
  const CheckInviteEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(appBar: AppBar()),
      body: ListView(
        children: [
          const Text(
            "認証メールを送信しました。",
            style: titleBold,
          ),
          const Text(
            "送信されたメールから認証を完了してください",
          ),
          ElevatedButton(
              onPressed: () => context.go(kLoginPath), child: Text("ログイン画面へ"))
        ],
      ),
    );
  }
}
