import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/view_model/sign_in_up_view_model.dart';

class SignOutTextButton extends StatelessWidget {
  const SignOutTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final signInUpViewModel = context.read<SignInUpViewModel>();
        await signInUpViewModel
            .signOut()
            .then((value) => context.go(kLoginPath));
      },
      child: const Text("サインアウト"),
    );
  }
}
