import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:twitter_clone/data_models/user.dart';
import 'package:twitter_clone/models/db/database_manager.dart';

class UserRepository {
  UserRepository({required this.dbManager});

  final DatabaseManager dbManager;
  static User? currentUser;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // 新規登録・ログイン
  Future<bool?> signInUp({
    required String email,
    required String pass,
    required bool isRegister,
  }) async {
    final auth.UserCredential userCredential = isRegister
        ? await _auth.createUserWithEmailAndPassword(
            email: email, password: pass)
        : await _auth.signInWithEmailAndPassword(email: email, password: pass);

    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      final isVerified = firebaseUser.emailVerified;

      if (isVerified == false) {
        if (!isVerified) {
          firebaseUser.sendEmailVerification();
          await signOut();
        }
      } else {
        final isUserExistedInDb =
            await dbManager.searchUserInDbByUserId(firebaseUser.uid);
        if (!isUserExistedInDb) {
          await dbManager.insertUser(_convertToUser(firebaseUser));
        }
        currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);
      }
    }
    return userCredential.user?.emailVerified;
  }

  // サインアウト
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ユーザー自身の情報を取得
  Future<bool> getUserInfo() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);
      return true;
    }
    return false;
  }

  // 他ユーザーの情報を取得
  Future<User> getUserInfoById(String userId) async {
    if (await dbManager.searchUserInDbByUserId(userId)) {
      return await dbManager.getUserInfoFromDbById(userId);
    } else {
      return User(
          userId: userId,
          userName: "unknown",
          follow: 0,
          follower: 0,
          createdAt: DateTime.now());
    }
  }

  // firebaseUserをデータベースに追加
  Future<void> insertUser(auth.User firebaseUser) async {
    await dbManager.insertUser(_convertToUser(firebaseUser));
  }

  _convertToUser(auth.User firebaseUser) {
    return User(
        userId: firebaseUser.uid,
        userName: firebaseUser.displayName ?? "unknown",
        email: firebaseUser.email,
        bio: "",
        follow: 0,
        follower: 0,
        createdAt: DateTime.now());
  }
}
