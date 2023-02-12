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

    final UserCredential userCredential = isRegister
        ? await auth.createUserWithEmailAndPassword(
            email: email, password: pass)
        : await auth.signInWithEmailAndPassword(email: email, password: pass);
    currentUser = auth.currentUser;

    final isVerified = auth.currentUser?.emailVerified;

    if (isVerified != null) {
      if (!isVerified) {
        auth.currentUser?.sendEmailVerification();
        await signOut();
      }
    }

    return userCredential.user?.emailVerified;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    currentUser = null;
    // notifyListeners();
  }

  void validation() {
    isValidEmail = emailController.text.isNotEmpty;
    isValidPass = passController.text.length > 7;

    notifyListeners();
  }
}
