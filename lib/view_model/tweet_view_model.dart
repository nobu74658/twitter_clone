import 'package:flutter/material.dart';
import 'package:twitter_clone/models/repositories/user_repository.dart';

class TweetViewModel extends ChangeNotifier {
  TweetViewModel({required this.userRepository});

  final UserRepository userRepository;
  bool isProcessing = false;
}
