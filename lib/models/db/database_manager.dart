import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:twitter_clone/data_models/tweet.dart';
import 'package:twitter_clone/data_models/user.dart';

class DatabaseManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  // ユーザーをデータベースに追加
  Future<void> insertUser(User user) async {
    await _db.collection("users").doc(user.userId).set(user.toMap());
  }

  // ユーザー情報を更新
  Future<void> updateUserInfo(User user) async {
    await _db.collection("users").doc(user.userId).update(user.toMap());
  }

  // Firebase Storageに画像を追加＆URLを返す
  Future<String> uploadImageToStorage(File imageFile, String storageId) async {
    final storageRef = _storage.ref().child(storageId);
    final uploadTask = storageRef.putFile(imageFile);
    return await uploadTask
        .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
  }

  Future<void> updateEmail(User user) async {
    await _db.collection("users").doc(user.userId).update(user.toMap());
  }

  Future<void> insertTweet(Tweet tweet) async {
    await _db.collection("tweets").doc(tweet.tweetId).set(tweet.toMap());
  }

  // tweetをtweetIdで削除する
  Future<void> deleteTweet(String tweetId) async {
    await _db.collection("tweets").doc(tweetId).delete();
  }
}
