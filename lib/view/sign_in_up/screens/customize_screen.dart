import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/utils/styles.dart';
import 'package:twitter_clone/view/common/primary_app_bar.dart';
import 'package:twitter_clone/view/common/primary_button.dart';
import 'package:twitter_clone/view/common/primary_switch_button.dart';

class CustomizeScreen extends StatelessWidget {
  const CustomizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isToggle = true;
    return Scaffold(
      appBar: PrimaryAppBar(appBar: AppBar(), widget: _leadingButton()),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "環境をカスタマイズする",
              style: titleBold,
            ),
            const SizedBox(height: 20),
            const Text(
              "Twitterコンテンツを閲覧したウェブの場所を追跡",
              style: bodyBold,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Twitterはこのデータを使って表示内容をカスタマイズします。このウェブ閲覧履歴とともに名前、メール、電話番号が保存されることはありません。",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: PrimarySwitchButton(value: isToggle),
                ),
              ],
            ),
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black54, fontSize: 14),
                children: [
                  TextSpan(text: "登録すると、Twitterの"),
                  TextSpan(
                    text: "利用規約",
                    style: TextStyle(
                      color: Colors.lightBlue,
                    ),
                  ),
                  TextSpan(text: "、"),
                  TextSpan(
                    text: "プライバシーポリシー",
                    style: TextStyle(
                      color: Colors.lightBlue,
                    ),
                  ),
                  TextSpan(text: "、"),
                  TextSpan(
                    text: "Cookieの使用",
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                  TextSpan(
                      text:
                          "に同意したとみなされます。Twitterは、プライバシーポリシーに記載されている目的で、メールアドレスや電話番号など、あなたの連絡先情報を利用することがあります。"),
                  TextSpan(
                    text: "詳細はこちら",
                    style: TextStyle(
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: PrimaryButton(
                  text: "次へ",
                  onPressed: () {
                    context.go('/privacy');
                    print("push primary button");
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _leadingButton() {
    return Container(
      width: 18,
      height: 18,
      child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {}),
    );
  }
}
