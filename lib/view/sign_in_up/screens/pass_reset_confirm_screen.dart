import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/view/common/components/firebase_error.dart';
import 'package:twitter_clone/view/common/components/leading_cancel_button.dart';
import 'package:twitter_clone/view/common/components/primary_app_bar.dart';
import 'package:twitter_clone/view/common/components/primary_button.dart';
import 'package:twitter_clone/view/common/components/primary_text_field.dart';
import 'package:twitter_clone/view_model/sign_in_up_view_model.dart';

class PassResetConfirmScreen extends StatelessWidget {
  const PassResetConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        leading: LeadingCancelButton(context),
        leadingWidth: 100,
        appBar: AppBar(),
      ),
      body: Consumer<SignInUpViewModel>(
        builder: (context, model, child) {
          return model.isProcessing
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  children: [
                    const Text("新しいパスワードを入力してください"),
                    PrimaryTextField(
                      hintText: "パスワード",
                      controller: model.passController,
                      isEdit: model.passController.text != "",
                      suffixIcon:
                          model.isValidPass ? _suffixIcon(context) : null,
                    ),
                    PrimaryButton(
                      text: "パスワードを変更する",
                      onPressed: () async {
                        try {
                          await model
                              .passReset()
                              .then((value) => context.go(kInitialPath));
                        } on FirebaseAuthException catch (e) {
                          EM.firebaseAuth(context, e.code);
                        } catch (e) {
                          EM.firebaseAuth(context, "error");
                        }
                        model.endProcess();
                      },
                    ),
                  ],
                );
        },
      ),
    );
  }

  _suffixIcon(BuildContext context) {
    return Image.asset(
      "assets/images/verified.png",
      scale: 20,
      color: Colors.green,
    );
  }

  _textButton(BuildContext context) {
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
