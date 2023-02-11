import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/models/repositories/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required this.userRepository})
      : emailController = TextEditingController(),
        passController = TextEditingController(),
        isValidEmail = false,
        isValidPass = false;
  final UserRepository userRepository;

  final TextEditingController emailController;
  final TextEditingController passController;
  bool isValidEmail;
  bool isValidPass;

  /// メールアドレスでログイン・新規アカウント登録
  Future<void> signInUp({required bool isRegister}) async {
    final String email = emailController.text;
    final String pass = emailController.text;
    final auth = FirebaseAuth.instance;

    isRegister
        ? await auth.createUserWithEmailAndPassword(
            email: email, password: pass)
        : await auth.signInWithEmailAndPassword(email: email, password: pass);

    final isVerified = auth.currentUser?.emailVerified;

    if (isVerified != null) {
      if (!isVerified) {
        auth.currentUser?.sendEmailVerification();
        await auth.signOut();
      }
    }

    await auth.currentUser?.sendEmailVerification();
  }

  void validation() {
    isValidEmail = emailController.text.isNotEmpty;
    print("email" + isValidEmail.toString());
    isValidPass = passController.text.length > 7;
    print("pass" + isValidPass.toString());
    notifyListeners();
  }
}
