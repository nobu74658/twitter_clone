import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:twitter_clone/data_models/user.dart';
import 'package:twitter_clone/models/db/database_manager.dart';

class UserRepository {
  UserRepository({required this.dbManager});

  final DatabaseManager dbManager;
  static User? currentUser;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future<bool?> signInUp({
    required String email,
    required String pass,
    required bool isRegister,
  }) async {
    final auth.UserCredential userCredential = isRegister
        ? await _auth.createUserWithEmailAndPassword(
            email: email, password: pass)
        : await _auth.signInWithEmailAndPassword(email: email, password: pass);

    final isVerified = _auth.currentUser?.emailVerified;

    if (isVerified != null) {
      if (!isVerified) {
        _auth.currentUser?.sendEmailVerification();
        await signOut();
      }
    }

    return userCredential.user?.emailVerified;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
