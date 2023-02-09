import 'package:flutter/material.dart';
import 'package:twitter_clone/models/repositories/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required this.userRepository});
  final UserRepository userRepository;
  
}