import 'package:flutter/material.dart';
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
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        children: [
          Text(
            "アカウントを作成",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          PrimaryTextField(
            hintText: "名前",
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
