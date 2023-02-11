import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/utils/styles.dart';
import 'package:twitter_clone/view/common/primary_app_bar.dart';
import 'package:twitter_clone/view/common/primary_button.dart';
import 'package:twitter_clone/view/common/primary_text_field.dart';
import 'package:twitter_clone/view_model/login_view_model.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        appBar: AppBar(),
        widget: _textButton(context),
        leadingWidth: 100,
      ),
      body: Consumer<LoginViewModel>(
        builder: (context, model, child) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            children: [
              const Text(
                "アカウントを作成",
                style: titleBold,
              ),
              const SizedBox(height: 20),
              PrimaryTextField(
                hintText: "メール",
                controller: model.emailController,
                isEdit: model.emailController.text != "",
                suffixIcon: model.isValidEmail ? _suffixIcon(context) : null,
              ),
              const SizedBox(height: 20),
              PrimaryTextField(
                hintText: "パスワード",
                controller: model.passController,
                isEdit: model.passController.text != "",
                suffixIcon: model.isValidPass ? _suffixIcon(context) : null,
              ),
              PrimaryButton(
                  text: "次へ",
                  onPressed: () {
                    context.go("/customize");
                  })
            ],
          );
        },
      ),
    );
  }

  _textButton(BuildContext context) {
    return TextButton(
      style:
          ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.black)),
      child: const Text("キャンセル"),
      onPressed: () {
        context.go("/");
      },
    );
  }

  _suffixIcon(BuildContext context) {
    print("_suffixIcon");
    return Image.asset(
      "assets/images/verified.png",
      scale: 20,
      color: Colors.green,
    );
  }
}
