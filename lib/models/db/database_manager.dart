import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:twitter_clone/data_models/tweet/tweet.dart';
import 'package:twitter_clone/data_models/user/user.dart';
import 'package:twitter_clone/data_models/userDesc/user_desc.dart';
import 'package:twitter_clone/utils/keys.dart';
import 'package:uuid/uuid.dart';

class DatabaseManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  ///-------------users <start>-------------///

  // Userを新規作成
  Future<void> setCurrentUser(User user) async {
    await _db.collection(users_collection).doc(user.userId).set(user.toJson());
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
    return User.fromJson(query.docs[0].data());
  }

  // Userを更新
  Future<void> updateUser(User user) async {
    await _db
        .collection(users_collection)
        .doc(user.userId)
        .update(user.toJson());
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
        .set(tweet.toJson());
  }

  // TweetをtweetIdで削除する
  Future<void> deleteTweet(String tweetId) async {
    await _db.collection(tweets_collection).doc(tweetId).delete();
    final query = await _db
        .collectionGroup(favorite_tweet_collection)
        .where(tweet_id, isEqualTo: tweetId)
        .get();
    final tasks = <Future<void>>[];
    for (int i = 0; i < query.docs.length; i++) {
      tasks.add(query.docs[i].reference.delete());
    }
    await Future.wait(tasks);
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
        Tweet.fromJson(
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
        .update(userDesc.toJson());
  }

  Future<List<Tweet>> getCurrentUserTweet(String userId) async {
    List<Tweet> tweets = [];
    final query = await _db
        .collection(tweets_collection)
        .where(user_id, isEqualTo: userId)
        .get();
    for (int i = 0; i < query.docs.length; i++) {
      tweets.add(
        Tweet.fromJson(
          query.docs[i].data(),
        ),
      );
    }
    return tweets;
  }

  ///-------------tweets <end>-------------///

  ///-------------following followed <start>-------------///

  // 他ユーザーをフォローした時に、relationshipsに書き込み
  Future<void> setRelationships(
    String followingId,
    String followedId,
  ) async {
    final relationshipId = Uuid().v1();
    await _db.collection(relationships_collectin).doc(relationshipId).set(
      {
        relationship_id: relationshipId,
        following_id: followingId,
        followed_id: followedId,
        "createdAt": FieldValue.serverTimestamp(),
      },
    );
  }

  // フォロー中のユーザーをrelationshipsから削除
  Future<void> deleteRelationship(String followingId, String followedId) async {
    final query = await _db
        .collection(relationships_collectin)
        .where(following_id, isEqualTo: followingId)
        .where(
          followed_id,
          isEqualTo: followedId,
        )
        .get();
    if (query.docs.isNotEmpty) {
      final relationshipId = query.docs[0].data()["relationshipId"];
      await _db
          .collection(relationships_collectin)
          .doc(relationshipId)
          .delete();
    }
  }

  // relationshipsの中から自分がfollowしているユーザーを全て取得
  Future<List<UserDesc>> getFollowingUsersFromRelationships(
      String userId) async {
    final followingUsers = <UserDesc>[];
    final query = await _db
        .collection(relationships_collectin)
        .where(following_id, isEqualTo: userId)
        .get();
    for (int i = 0; i < query.docs.length; i++) {
      final followingId = query.docs[i].data()["followedId"];
      print(followingId);
      final followingUser = await _db
          .collection(users_collection)
          .doc(followingId)
          .get()
          .then((value) => User.fromJson(value.data()!));
      if (followingUser != null) {
        final followingUserDesc = UserDesc(
          userId: followingUser.userId,
          userName: followingUser.userName,
          userIcon: followingUser.userIcon,
          bio: followingUser.bio,
        );
        followingUsers.add(followingUserDesc);
      }
    }
    return followingUsers;
  }

  // relationshipの中から自分のフォロワーを全て取得
  Future<List<UserDesc>> getFollowedUsersFromRelationships(
      String userId) async {
    final followedUsers = <UserDesc>[];
    final query = await _db
        .collection(relationships_collectin)
        .where(followed_id, isEqualTo: userId)
        .get();
    for (int i = 0; i < query.docs.length; i++) {
      final followedId = query.docs[i].data()["followingId"];
      final followedUser =
          await _db.collection(users_collection).doc(followedId).get().then(
                (value) => User.fromJson(value.data()!),
              );
      if (followedUser != null) {
        final followedUserDesc = UserDesc(
          userId: followedUser.userId,
          userName: followedUser.userName,
          userIcon: followedUser.userIcon,
          bio: followedUser.bio,
        );
        followedUsers.add(followedUserDesc);
      }
    }
    return followedUsers;
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

  // 自分がフォローしているユーザーなのかどうか
  Future<bool> isFollowingUserFromRelationships(
      String userId, String otherUserId) async {
    final query = await _db
        .collection(relationships_collectin)
        .where(following_id, isEqualTo: userId)
        .where(followed_id, isEqualTo: otherUserId)
        .get();
    if (query.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  ///-------------following followed <end>-------------///

  ///-------------favorite-tweets <start>-------------///

  /// いいねしたツイートを全て取得する
  Future<List<Tweet>> getFavoriteTweets(String userId) async {
    List<Tweet> favoriteTweets = [];
    final query = await _db
        .collection(favorite_tweet_collection)
        .where(user_id, isEqualTo: userId)
        .get();
    for (int i = 0; i < query.docs.length; i++) {
      final favoriteTweetId = query.docs[i].data()[tweet_id];
      final favoriteTweet =
          await _db.collection(tweets_collection).doc(favoriteTweetId).get();
      favoriteTweets.add(
        Tweet.fromJson(
          favoriteTweet.data()!,
        ),
      );
    }
    return favoriteTweets;
  }

  // Tweetをいいねする
  // Tweetのいいねの数を更新する
  Future<void> setFavoriteTweet(String userId, String tweetId) async {
    final favoriteTweetId = Uuid().v1();
    final favoriteTweetRef =
        _db.collection(favorite_tweet_collection).doc(favoriteTweetId);
    final tweetRef = _db.collection(tweets_collection).doc(tweetId);
    await _db.runTransaction(
      (transaction) async {
        transaction.set(
          favoriteTweetRef,
          {
            favorite_tweet_id: favoriteTweetId,
            tweet_id: tweetId,
            user_id: userId,
            "createdAt": FieldValue.serverTimestamp(),
          },
        );
        transaction.set(
          tweetRef,
          {favorite_num: FieldValue.increment(1)},
          SetOptions(merge: true),
        );
      },
    );
  }

  // Tweetのいいねを取り消す
  // Tweetのいいねの数を更新する
  Future<void> deleteFavoriteTweet(String userId, String tweetId) async {
    final query = await _db
        .collection(favorite_tweet_collection)
        .where(tweet_id, isEqualTo: tweetId)
        .where(user_id, isEqualTo: userId)
        .get();
    if (query.docs.isNotEmpty) {
      String favoriteTweetId = query.docs[0][favorite_tweet_id];
      final favoriteTweetRef =
          _db.collection(favorite_tweet_collection).doc(favoriteTweetId);
      final tweetRef = _db.collection(tweets_collection).doc(tweetId);
      await _db.runTransaction(
        (transaction) async {
          transaction.delete(favoriteTweetRef);
          transaction.set(
            tweetRef,
            {favorite_num: FieldValue.increment(-1)},
            SetOptions(merge: true),
          );
        },
      );
    }
  }

  ///-------------favorite-tweets <end>-------------///
}
