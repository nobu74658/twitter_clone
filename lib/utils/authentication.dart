import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/utils/path.dart';

/// 参考
/// https://blog.codemagic.io/firebase-authentication-google-sign-in-using-flutter-jpn/

class Authentication {
  static Future<void> initializeFirebase({
    required BuildContext context,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    await Future.delayed(const Duration(seconds: 3));

    if (user != null) {
      context.go(kTopPath);
    } else {
      context.go(kLoginPath);
    }
  }
}
