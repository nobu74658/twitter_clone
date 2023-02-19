import 'package:flutter/material.dart';
import 'package:twitter_clone/models/repositories/user_repository.dart';

class SignInUpViewModel extends ChangeNotifier {
  SignInUpViewModel({required this.userRepository})
      : emailController = TextEditingController(),
        passController = TextEditingController(),
        isValidEmail = false,
        isValidPass = false;
  final UserRepository userRepository;
  bool isProcessing = false;

  final TextEditingController emailController;
  final TextEditingController passController;
  bool isValidEmail;
  bool isValidPass;

  /// メールアドレスでログイン・新規アカウント登録
  Future<bool?> signInUp({bool isRegister = true}) async {
    print("signInUp in view model");
    isProcessing = true;
    notifyListeners();

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

    isProcessing = false;
    notifyListeners();

    return isVerified;
  }

  Future<void> signOut() async {
    isProcessing = true;
    notifyListeners();

    await userRepository.signOut();

    isProcessing = false;
    notifyListeners();
  }

  void validation() {
    isValidEmail = emailController.text.isNotEmpty;
    isValidPass = passController.text.length > 7;

    notifyListeners();
  }

  // パスワードを変更
  Future<void> passReset() async {
    isProcessing = true;
    notifyListeners();

    final pass = passController.text;

    await userRepository.passReset(pass);

    isProcessing = false;
    notifyListeners();
  }

  void endProcess() {
    isProcessing = false;
    notifyListeners();
  }

  // メールアドレスを変更
  Future<void> emailReset() async {
    isProcessing = true;
    notifyListeners();

    final email = emailController.text;
    await userRepository.emailReset(email);

    isProcessing = false;
    notifyListeners();
  }
}
