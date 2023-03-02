import 'dart:io';
import 'package:flutter/material.dart';
import 'package:twitter_clone/data_models/user/user.dart';
import 'package:twitter_clone/data_models/userDesc/user_desc.dart';
import 'package:twitter_clone/models/repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  UserViewModel({required this.userRepository})
      : nameController = TextEditingController(),
        bioController = TextEditingController();

  final UserRepository userRepository;
  User? get currentUser => UserRepository.currentUser;

  File? imageFile;
  bool isImagePicked = false;

  TextEditingController nameController;
  TextEditingController bioController;

  bool isProcessing = false;

  // 現在のログインユーザーの情報を取得
  Future<User> getCurrentUser() async {
    return await userRepository.getCurrentUser();
  }

  // 画像取得
  Future<void> getImage({required bool isFromGallery}) async {
    isImagePicked = false;
    isProcessing = true;
    notifyListeners();

    imageFile = await userRepository.pickImage(isFromGallery: isFromGallery);

    if (imageFile != null) isImagePicked = true;
    isProcessing = false;
    notifyListeners();
  }

  // ユーザープロフィールの編集
  Future<void> updateUserInfo() async {
    isProcessing = true;
    notifyListeners();

    await userRepository.updateUser(
        imageFile: imageFile,
        userName: nameController.text,
        bio: bioController.text);

    isProcessing = false;
    notifyListeners();
  }

  // userIdから他ユーザーの情報を取得
  Future<User> getUserInfoById(String userId) async {
    return await userRepository.getUserById(userId);
  }

  Future<void> followUnFollowUser(User otherUser, bool isFollowing) async {
    isProcessing = true;
    notifyListeners();

    if (isFollowing) {
      await userRepository.deleteFollowingUser(otherUser.userId);
    } else {
      final otherUserDesc = UserDesc(
        userId: otherUser.userId,
        userName: otherUser.userName,
        bio: otherUser.bio,
        userIcon: otherUser.userIcon,
      );
      await userRepository.setFollowing(otherUserDesc);
    }
    userRepository.getCurrentUser();

    isProcessing = false;
    notifyListeners();
  }

  Future<List<UserDesc>> getFollowUsers() async {
    return await userRepository.getFollowingUsers();
  }

  Future<List<UserDesc>> getFollowers() async {
    return await userRepository.getFollowedUsers();
  }

  Future<bool> isFollowingUser(String otherUserId) async {
    return await userRepository.isFollowingUser(otherUserId);
  }
}
