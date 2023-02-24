import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/utils/styles.dart';
import 'package:twitter_clone/view/common/components/firebase_error.dart';
import 'package:twitter_clone/view/common/components/primary_app_bar.dart';
import 'package:twitter_clone/view/common/components/primary_button.dart';
import 'package:twitter_clone/view/common/components/primary_text_field.dart';
import 'package:twitter_clone/view/common/components/show_dialog.dart';
import 'package:twitter_clone/view_model/sign_in_up_view_model.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    super.key,
    this.isRegister = true,
  });

  final bool isRegister;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        appBar: AppBar(),
        leading: _textButton(context),
        leadingWidth: 100,
      ),
      body: Consumer<SignInUpViewModel>(
        builder: (context, model, child) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            children: [
              Text(
                isRegister ? "アカウントを作成" : "ログイン",
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
                isObscure: true,
                hintText: "パスワード",
                controller: model.passController,
                isEdit: model.passController.text != "",
                suffixIcon: model.isValidPass ? _suffixIcon(context) : null,
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                text: isRegister ? "次へ" : "ログイン",
                onPressed: isRegister
                    ? () {
                        context.go(kCustomizePath);
                      }
                    : () async {
                        await _login(context);
                      },
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => isRegister
                      ? context.go(kLoginPath)
                      : context.go(kRegisterPath),
                  child: Text(isRegister ? "ログイン画面へ" : "新規アカウント登録"),
                ),
              ),
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

  _login(BuildContext context) async {
    final signInUpViewModel = context.read<SignInUpViewModel>();
    try {
      await signInUpViewModel.signInUp(isRegister: false).then((value) {
        if (value == null) {
          SD.unknownError(context);
        } else {
          context.go(value ? kTopPath : kCheckInviteEmailPath);
        }
      });
    } on FirebaseAuthException catch (e) {
      EM.firebaseAuth(context, e.code);
    } catch (e) {
      EM.firebaseAuth(context, "error");
    }
  }
}
