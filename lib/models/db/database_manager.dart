import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_clone/data_models/user.dart';

class DatabaseManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // userIdでユーザーをデータベースから取得
  Future<User> getUserInfoFromDbById(String userId) async {
    final query =
        await _db.collection("users").where("userId", isEqualTo: userId).get();
    return User.fromMap(query.docs[0].data());
  }

  // userIdでユーザーをデータベースから探す
  Future<bool> searchUserInDbByUserId(String userId) async {
    final query =
        await _db.collection("users").where("userId", isEqualTo: userId).get();
    if (query.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> insertUser(User user) async {
    _db.collection("users").doc(user.userId).set(user.toMap());
  }
}
