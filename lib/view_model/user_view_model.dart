import 'package:flutter/material.dart';
import 'package:twitter_clone/data_models/user.dart';
import 'package:twitter_clone/models/repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  UserViewModel({required this.userRepository});

  final UserRepository userRepository;
  User? get currentUser => UserRepository.currentUser;

  Future<void> getCurrentUser() async {
    await userRepository.getCurrentUser();
  }
}
