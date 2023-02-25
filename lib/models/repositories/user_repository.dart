import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/data_models/tweet.dart';
import 'package:twitter_clone/data_models/user.dart';
import 'package:twitter_clone/data_models/user_desc.dart';
import 'package:twitter_clone/models/db/database_manager.dart';
import 'package:uuid/uuid.dart';

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
            await dbManager.searchUserById(firebaseUser.uid);
        if (!isUserExistedInDb) {
          await dbManager.setCurrentUser(_convertToUser(firebaseUser));
        }
        currentUser = await dbManager.getUserById(firebaseUser.uid);
      }
    }
    return userCredential.user?.emailVerified;
  }

  // ユーザー情報を更新
  Future<void> updateCurrentUser() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      final isUserExistedInDb =
          await dbManager.searchUserById(firebaseUser.uid);
      if (!isUserExistedInDb) {
        await dbManager.setCurrentUser(_convertToUser(firebaseUser));
      }
      // await setFollowingFollowedNum(firebaseUser.uid);
      currentUser = await dbManager.getUserById(firebaseUser.uid);
    }
  }

  Future<User> getCurrentUser() async {
    if (currentUser == null) {
      await updateCurrentUser();
      return currentUser!;
    }
    return currentUser!;
  }

  // サインアウト
  Future<void> signOut() async {
    await _auth.signOut();
    currentUser = null;
  }

  // ユーザーの情報をuserIdで取得
  Future<User> getUserById(String userId) async {
    if (await dbManager.searchUserById(userId)) {
      return await dbManager.getUserById(userId);
    } else {
      return User(
        userId: userId,
        userName: "unknown",
        followingNum: 0,
        followedNum: 0,
        createdAt: DateTime.now(),
        bio: '',
      );
    }
  }

  // firebaseUserをデータベースに追加
  Future<void> setCurrentUser(auth.User firebaseUser) async {
    await dbManager.setCurrentUser(_convertToUser(firebaseUser));
  }

  _convertToUser(auth.User firebaseUser) {
    return User(
        userId: firebaseUser.uid,
        userName: firebaseUser.displayName ?? "unknown",
        email: firebaseUser.email,
        bio: "ここに自己紹介を表示することができます。",
        followingNum: 0,
        followedNum: 0,
        createdAt: DateTime.now());
  }

  // 画像を取得する
  Future<File?> pickImage({required bool isFromGallery}) async {
    if (kIsWeb) {
      return null;
    }
    final imagePicker = ImagePicker();
    if (isFromGallery) {
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      return (pickedImage != null) ? File(pickedImage.path) : null;
    } else {
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.camera);
      return (pickedImage != null) ? File(pickedImage.path) : null;
    }
  }

  // ユーザー情報を変更する
  Future<void> updateUser(
      {required File? imageFile,
      required String? userName,
      required String? bio}) async {
    final storageId = Uuid().v1();
    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await dbManager.uploadImageToStorage(imageFile, storageId);
    }
    User newUserInfo = currentUser!.copyWith(
      userIcon: imageUrl,
      userName: userName,
      bio: bio,
    );
    currentUser = newUserInfo;

    await dbManager.updateUser(newUserInfo);
    UserDesc userDesc = UserDesc(
      userId: currentUser!.userId,
      userName: currentUser!.userName,
      bio: currentUser!.bio,
      userIcon: currentUser!.userIcon,
    );
    // Tweet中のユーザー情報を更新
    await dbManager.updateAllTweet(userDesc);

    // following, followed中のユーザー情報を更新
    await dbManager.updateAllFollowingFollowed(userDesc);
  }

  // パスワードを変更
  Future<void> passReset(String pass) async {
    await _auth.currentUser!.updatePassword(pass);
  }

  // メールアドレスを変更
  Future<void> emailReset(String email) async {
    await _auth.currentUser!.updateEmail(email).then((value) async {
      User user = currentUser!.copyWith(
        email: email,
      );
      await dbManager.updateUser(user);
    });
  }

  // userIdを返す、tweet_view_modelで使用
  String printUserId() {
    return currentUser!.userId;
  }

  // フォローする
  Future<void> setFollowing(UserDesc otherUserDesc) async {
    final currentUserDesc = UserDesc(
      userId: currentUser!.userId,
      userName: currentUser!.userName,
      bio: currentUser!.bio,
      userIcon: currentUser!.userIcon,
    );
    currentUser =
        currentUser!.copyWith(followingNum: currentUser!.followingNum + 1);
    await dbManager.setFollowing(currentUserDesc, otherUserDesc);
  }

  Future<List<UserDesc>> getFollowingUsers() async {
    return await dbManager.getFollowingUsers(currentUser!.userId);
  }

  Future<List<UserDesc>> getFollowedUsers() async {
    return await dbManager.getFollowedUsers(currentUser!.userId);
  }

  Future<void> deleteFollowingUser(String otherUserId) async {
    await dbManager.deleteFollowing(currentUser!.userId, otherUserId);
    currentUser =
        currentUser!.copyWith(followingNum: currentUser!.followingNum - 1);
  }

  Future<bool> isFollowingUser(String otherUserId) async {
    return await dbManager.isFollowingUser(currentUser!.userId, otherUserId);
  }

  Future<List<Tweet>> getFavoriteTweets() async {
    return await dbManager.getFavoriteTweets(currentUser!.userId);
  }

  Future<void> setFavoriteTweet(Tweet tweet) async {
    await dbManager.setFavoriteTweet(currentUser!.userId, tweet);
  }

  Future<void> deleteFavoriteTweet(Tweet tweet) async {
    await dbManager.deleteFavoriteTweet(currentUser!.userId, tweet);
  }

  Future<List<Tweet>> getCurrentUserTweet() async {
    return await dbManager.getCurrentUserTweet(currentUser!.userId);
  }
}
