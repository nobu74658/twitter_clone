import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/utils/styles.dart';
import 'package:twitter_clone/view/common/firebase_error.dart';
import 'package:twitter_clone/view/common/primary_app_bar.dart';
import 'package:twitter_clone/view/common/primary_button.dart';
import 'package:twitter_clone/view/common/primary_text_field.dart';
import 'package:twitter_clone/view/common/show_dialog.dart';
import 'package:twitter_clone/view_model/login_view_model.dart';

class RegisterConfirmScreen extends StatelessWidget {
  const RegisterConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.read<LoginViewModel>();
    return Scaffold(
      appBar: PrimaryAppBar(
        appBar: AppBar(),
        widget: _textButton(context),
        leadingWidth: 100,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        children: [
          const Text(
            "アカウントを作成",
            style: titleBold,
          ),
          const SizedBox(height: 20),
          PrimaryTextField(
            readOnly: true,
            hintText: "メール",
            controller: loginViewModel.emailController,
            isEdit: loginViewModel.emailController.text != "",
          ),
          const SizedBox(height: 20),
          PrimaryTextField(
            readOnly: true,
            hintText: "パスワード",
            controller: loginViewModel.passController,
            isEdit: loginViewModel.passController.text != "",
          ),
          PrimaryButton(
              text: "登録する",
              onPressed:
                  (loginViewModel.isValidEmail & loginViewModel.isValidPass)
                      ? () async {
                          await _signInUp(context);
                        }
                      : null),
        ],
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

  Future<void> _signInUp(BuildContext context) async {
    final loginViewModel = context.read<LoginViewModel>();
    try {
      await loginViewModel.signInUp(isRegister: true).then((value) {
        if (value == null) {
          SD.unknownError(context);
        } else {
          context.go(value ? kInitialPath : kCheckInviteEmailPath);
        }
      });
    } on FirebaseAuthException catch (e) {
      EM.firebaseAuth(context, e.code);
    } catch (e) {
      EM.firebaseAuth(context, "error");
    }
  }
}
