import 'package:flutter/material.dart';
import 'package:twitter_clone/utils/styles.dart';
import 'package:twitter_clone/view/common/primary_app_bar.dart';
import 'package:twitter_clone/view/common/primary_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        appBar: AppBar(),
        widget: _textButton(),
        leadingWidth: 100,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        children: [
          const Text(
            "アカウントを作成",
            style: titleBold,
          ),
          PrimaryTextField(
            hintText: "名前",
            controller: TextEditingController(),
          ),
          const SizedBox(height: 20),
          PrimaryTextField(
            hintText: "メール",
            controller: TextEditingController(),
          ),
          const SizedBox(height: 20),
          PrimaryTextField(
            hintText: "生年月日",
            controller: TextEditingController(),
          ),
        ],
      ),
    );
  }

  _textButton() {
    return TextButton(
      style:
          ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.black)),
      child: Text("キャンセル"),
      onPressed: () {},
    );
  }
}
