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
    await _db
        .collection("follow-followed")
        .doc(user.userId)
        .set({"followUserId": [], "followerId": []});
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

  Future<void> followUser(String userId, String otherUserId) async {
    final batch = _db.batch();

    var followRef = _db.collection("follow-followed").doc(userId);
    final followUsers = await getFollowUsers(userId);
    var followUserIds = <String>[];
    followUserIds.add(otherUserId);
    if (followUsers != null) {
      for (int i = 0; i < followUsers.length; i++) {
        followUserIds.add(followUsers[i].userId);
      }
    }
    batch.update(followRef, {"followUserId": followUserIds});

    var followerRef = _db.collection("follow-followed").doc(otherUserId);
    final followers = await getFollowers(otherUserId);
    var followerIds = <String>[];
    followerIds.add(userId);
    if (followers != null) {
      for (int i = 0; i < followers.length; i++) {
        followerIds.add(followers[i].userId);
      }
    }
    batch.update(followerRef, {"followerId": followerIds});

    await batch.commit();
  }

  Future<void> deleteFollowUser(String userId, String otherUserId) async {
    final batch = _db.batch();

    var followRef = _db.collection("follow-followed").doc(userId);
    final followUsers = await getFollowUsers(userId);
    var followUserIds = <String>[];
    if (followUsers != null) {
      for (int i = 0; i < followUsers.length; i++) {
        if (followUsers[i].userId != otherUserId) {
          followUserIds.add(followUsers[i].userId);
        }
      }
    }
    print(followUserIds);
    batch.update(followRef, {"followUserId": followUserIds});

    var followerRef = _db.collection("follow-followed").doc(otherUserId);
    final followers = await getFollowers(otherUserId);
    var followerIds = <String>[];
    if (followers != null) {
      for (int i = 0; i < followers.length; i++) {
        if (followers[i].userId != userId) {
          followerIds.add(followers[i].userId);
        }
      }
    }
    batch.update(followerRef, {"followerId": followerIds});

    await batch.commit();
  }

  Future<List<User>?> getFollowUsers(String userId) async {
    print("userId$userId");
    final field = await _db
        .collection("follow-followed")
        .doc(userId)
        .get()
        .then((value) => value.data()?["followUserId"]);
    var followUserIds = <String>[];
    if (field != null) {
      for (int i = 0; i < field.length; i++) {
        followUserIds.add(field?[i]);
      }
      print(followUserIds);
      var followUsers = <User>[];
      for (int i = 0; i < followUserIds.length; i++) {
        followUsers.add(await getUserInfoFromDbById(followUserIds[i]));
      }
      return followUsers;
    }
    return null;
  }

  Future<List<User>?> getFollowers(String userId) async {
    final field = await _db
        .collection("follow-followed")
        .doc(userId)
        .get()
        .then((value) => value.data()?["followerId"]);
    var followerIds = <String>[];
    if (field != null) {
      for (int i = 0; i < field.length; i++) {
        followerIds.add(field?[i]);
      }
      print(followerIds);
      var followers = <User>[];
      for (int i = 0; i < followerIds.length; i++) {
        followers.add(await getUserInfoFromDbById(followerIds[i]));
      }
      return followers;
    }
    return null;
  }

  // フォロー、フォロワー数を取得する
  Future<void> getFollowFollowerNum(String userId) async {
    final followUsers = await getFollowUsers(userId);
    int followUserNum = followUsers?.length ?? 0;
    final followers = await getFollowers(userId);
    int followerNum = followers?.length ?? 0;

    await _db
        .collection("users")
        .doc(userId)
        .update({"follow": followUserNum, "follower": followerNum});
  }
}
