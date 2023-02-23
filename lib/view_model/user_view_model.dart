import 'dart:io';
import 'package:flutter/material.dart';
import 'package:twitter_clone/data_models/user.dart';
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
  Future<void> getCurrentUser() async {
    await userRepository.getCurrentUser();
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

    await userRepository.updateUserInfo(
        imageFile: imageFile,
        userName: nameController.text,
        bio: bioController.text);

    isProcessing = false;
    notifyListeners();
  }

  // userIdから他ユーザーの情報を取得
  Future<User> getUserInfoById(String userId) async {
    return await userRepository.getUserInfoById(userId);
  }

  Future<void> followUnFollowUser(String otherUserId, bool isFollow) async {
    isProcessing = true;
    notifyListeners();

    isFollow
        ? await userRepository.deleteFollowUser(otherUserId)
        : await userRepository.followUser(otherUserId);

    isProcessing = false;
    notifyListeners();
  }

  Future<List<User>> getFollowUsers() async {
    final users = await userRepository.getFollowUsers();
    return users;
  }

  Future<List<User>> getFollowers() async {
    final users = await userRepository.getFollowers();
    return users;
  }
}
