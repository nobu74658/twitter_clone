import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/models/repositories/user_repository.dart';

class SignInUpViewModel extends ChangeNotifier {
  SignInUpViewModel({required this.userRepository})
      : emailController = TextEditingController(),
        passController = TextEditingController(),
        isValidEmail = false,
        isValidPass = false;
  final UserRepository userRepository;
  final auth = FirebaseAuth.instance;
  User? currentUser;

  final TextEditingController emailController;
  final TextEditingController passController;
  bool isValidEmail;
  bool isValidPass;

  /// メールアドレスでログイン・新規アカウント登録
  Future<bool?> signInUp({bool isRegister = true}) async {
    print("signInUp in view model");

    final String email = emailController.text;
    final String pass = passController.text;

    bool? isVerified = await userRepository.signInUp(
      email: email,
      pass: pass,
      isRegister: isRegister,
    );
    if (isVerified == true) {
      emailController.clear();
      passController.clear();
      isValidEmail = false;
      isValidPass = false;
      notifyListeners();
    }

    return isVerified;
  }

  Future<void> signOut() async {
    await userRepository.signOut();
    currentUser = null;
    notifyListeners();
  }

  void validation() {
    isValidEmail = emailController.text.isNotEmpty;
    isValidPass = passController.text.length > 7;

    notifyListeners();
  }
}
