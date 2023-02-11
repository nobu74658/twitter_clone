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
  final auth = FirebaseAuth.instance;

  final TextEditingController emailController;
  final TextEditingController passController;
  bool isValidEmail;
  bool isValidPass;

  /// メールアドレスでログイン・新規アカウント登録
  Future<bool?> signInUp({bool isRegister = true}) async {
    final String email = emailController.text;
    final String pass = emailController.text;

    final UserCredential userCredential = isRegister
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

    return userCredential.user?.emailVerified;
  }

  void validation() {
    isValidEmail = emailController.text.isNotEmpty;
    isValidPass = passController.text.length > 7;

    notifyListeners();
  }
}
