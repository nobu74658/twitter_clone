import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:twitter_clone/data_models/tweet.dart';
import 'package:twitter_clone/data_models/user.dart';
import 'package:twitter_clone/data_models/user_desc.dart';
import 'package:twitter_clone/utils/keys.dart';

class DatabaseManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  ///-------------users <start>-------------///

  // Userを新規作成
  Future<void> setCurrentUser(User user) async {
    await _db.collection(users_collection).doc(user.userId).set(user.toMap());
  }

  // userIdでUserを探す
  Future<bool> searchUserById(String userId) async {
    final query = await _db
        .collection(users_collection)
        .where(user_id, isEqualTo: userId)
        .get();
    if (query.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  // userIdでUserを取得
  Future<User> getUserById(String userId) async {
    final query = await _db
        .collection(users_collection)
        .where(user_id, isEqualTo: userId)
        .get();
    return User.fromMap(query.docs[0].data());
  }

  // Userを更新
  Future<void> updateUser(User user) async {
    await _db
        .collection(users_collection)
        .doc(user.userId)
        .update(user.toMap());
  }

  // Firebase Storageに画像を追加＆URLを返す
  Future<String> uploadImageToStorage(File imageFile, String storageId) async {
    final storageRef = _storage.ref().child(storageId);
    final uploadTask = storageRef.putFile(imageFile);
    return await uploadTask
        .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
  }

  ///-------------users <end>-------------///

  ///-------------tweets <start>-------------///

  // Tweetを新規作成
  Future<void> setTweet(Tweet tweet) async {
    await _db
        .collection(tweets_collection)
        .doc(tweet.tweetId)
        .set(tweet.toMap());
  }

  // TweetをtweetIdで削除する
  Future<void> deleteTweet(String tweetId) async {
    await _db.collection(tweets_collection).doc(tweetId).delete();
  }

  // userIdでTweetを全て取得
  Future<List<Tweet>> getTweetByUserId(String userId) async {
    final query = await _db
        .collection(tweets_collection)
        .where(user_id, isEqualTo: userId)
        .get();
    final tweets = <Tweet>[];
    for (int i = 0; i < query.docs.length; i++) {
      tweets.add(
        Tweet.fromMap(
          query.docs[i].data(),
        ),
      );
    }
    return tweets;
  }

  // Tweetを更新（Userを更新した際に呼び出す）
  Future<void> updateAllTweet(UserDesc userDesc) async {
    final tweets = await getTweetByUserId(userDesc.userId);
    final tasks = <Future<void>>[];
    for (var tweet in tweets) {
      tasks.add(updateTweet(userDesc, tweet.tweetId));
    }
    print("updateAllTweet start");
    print(DateTime.now());
    await Future.wait(tasks);
    print(DateTime.now());
    print("updateAllTweet end");
  }

  Future<void> updateTweet(UserDesc userDesc, String tweetId) async {
    await _db
        .collection(tweets_collection)
        .doc(tweetId)
        .update(userDesc.toMap());
  }

  ///-------------tweets <end>-------------///

  ///-------------following followed <start>-------------///

  // 他ユーザーをフォローした時に、following, followedを追加
  Future<void> setFollowing(
      UserDesc currentUserDesc, UserDesc otherUserDesc) async {
    final currentUserRef =
        _db.collection(users_collection).doc(currentUserDesc.userId);
    final followingRef = currentUserRef
        .collection(following_collection)
        .doc(otherUserDesc.userId);
    final otherUserRef =
        _db.collection(users_collection).doc(otherUserDesc.userId);
    final followedRef = otherUserRef
        .collection(followed_collection)
        .doc(currentUserDesc.userId);
    await _db.runTransaction((transaction) async {
      transaction.set(followingRef, otherUserDesc.toMap());
      transaction.set(currentUserRef, {"followingNum": FieldValue.increment(1)},
          SetOptions(merge: true));
      transaction.set(followedRef, currentUserDesc.toMap());
      transaction.set(otherUserRef, {"followedNum": FieldValue.increment(1)},
          SetOptions(merge: true));
    });
  }

  // フォロー中のユーザーをfollowingから削除
  Future<void> deleteFollowing(String currentUserId, String otherUserId) async {
    final currentUserRef = _db.collection(users_collection).doc(currentUserId);
    final followingRef =
        currentUserRef.collection(following_collection).doc(otherUserId);
    final otherUserRef = _db.collection(users_collection).doc(otherUserId);
    final followedRef =
        otherUserRef.collection(followed_collection).doc(currentUserId);

    await _db.runTransaction((transaction) async {
      transaction.delete(followingRef);
      transaction.set(currentUserRef,
          {"followingNum": FieldValue.increment(-1)}, SetOptions(merge: true));
      transaction.delete(followedRef);
      transaction.set(otherUserRef, {"followedNum": FieldValue.increment(-1)},
          SetOptions(merge: true));
    });
  }

  // folloingの中のユーザーを全て取得
  Future<List<UserDesc>> getFollowingUsers(String userId) async {
    final followingUsers = <UserDesc>[];
    final query = await _db
        .collection(users_collection)
        .doc(userId)
        .collection(following_collection)
        .get();
    for (int i = 0; i < query.docs.length; i++) {
      followingUsers.add(UserDesc.fromMap(query.docs[i].data()));
    }
    return followingUsers;
  }

  // followedの中のユーザーを取得
  Future<List<UserDesc>> getFollowedUsers(String userId) async {
    final followedUsers = <UserDesc>[];
    final query = await _db
        .collection(users_collection)
        .doc(userId)
        .collection(followed_collection)
        .get();
    for (int i = 0; i < query.docs.length; i++) {
      followedUsers.add(UserDesc.fromMap(query.docs[i].data()));
    }
    return followedUsers;
  }

  // following, followedの中のユーザーデータを全て更新する
  Future<void> updateAllFollowingFollowed(UserDesc userDesc) async {
    final followedQuery = await _db
        .collectionGroup(followed_collection)
        .where(user_id, isEqualTo: userDesc.userId)
        .get();
    final followingQuery = await _db
        .collectionGroup(following_collection)
        .where(user_id, isEqualTo: userDesc.userId)
        .get();
    final tasks = <Future<void>>[];
    print(followingQuery.docs.length);
    for (int i = 0; i < followingQuery.docs.length; i++) {
      tasks.add(followingQuery.docs[i].reference.set(userDesc.toMap()));
    }
    for (int i = 0; i < followedQuery.docs.length; i++) {
      tasks.add(followedQuery.docs[i].reference.set(userDesc.toMap()));
    }
    await Future.wait(tasks);
  }

  // フォロー、フォロワー数を取得して書き込む
  Future<void> updateFollowingFollowedNum(String userId) async {
    final followingNum = await _db
        .collection(users_collection)
        .doc(userId)
        .collection(following_collection)
        .count()
        .get();
    final followedNum = await _db
        .collection(users_collection)
        .doc(userId)
        .collection(followed_collection)
        .count()
        .get();
    await _db.collection(users_collection).doc(userId).set(
      {
        "followingNum": followingNum.count,
        "followedNum": followedNum.count,
        "updateTime": FieldValue.serverTimestamp()
      },
      SetOptions(merge: true),
    );
  }

  Future<bool> isFollowingUser(String userId, String otherUserId) async {
    final query = await _db
        .collection(users_collection)
        .doc(userId)
        .collection(following_collection)
        .where(user_id, isEqualTo: otherUserId)
        .get();
    if (query.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  ///-------------following followed <end>-------------///

  ///-------------favorite-tweet, favorite-by-user <end>-------------///
  // Tweetをいいねする

  // Tweetのいいねの数を更新する

  // Tweetのいいねを取り消す

  // Tweetのいいねの数をtweetIdで取得する

  /// いいねしたツイートを全て取得する
  Future<List<Tweet>> getFavoriteTweets(String userId) async {
    List<Tweet> favoriteTweets = [];
    final query = await _db
        .collection(users_collection)
        .doc(userId)
        .collection(favorite_tweet)
        .get();
    for (int i = 0; i < query.docs.length; i++) {
      favoriteTweets.add(
        Tweet.fromMap(
          query.docs[i].data(),
        ),
      );
    }
    return favoriteTweets;
  }

  ///-------------favorite-tweet, favorite-by-user <end>-------------///
}
