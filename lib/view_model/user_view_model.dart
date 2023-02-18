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

  Future<void> getCurrentUser() async {
    await userRepository.getCurrentUser();
  }

  Future<void> getImage({required bool isFromGallery}) async {
    isImagePicked = false;
    isProcessing = true;
    notifyListeners();

    imageFile = await userRepository.pickImage(isFromGallery: isFromGallery);

    if (imageFile != null) isImagePicked = true;
    isProcessing = false;
    notifyListeners();
  }

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
}
