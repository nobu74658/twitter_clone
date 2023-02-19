import 'package:flutter/material.dart';
import 'package:twitter_clone/models/repositories/user_repository.dart';

class TweetViewModel extends ChangeNotifier {
  TweetViewModel({required this.userRepository})
      : descController = TextEditingController();

  final UserRepository userRepository;
  bool isProcessing = false;
  TextEditingController descController;

  Future<void> postTweet() async {
    isProcessing = true;
    notifyListeners();

    isProcessing = false;
    notifyListeners();
  }

  endProcess() {
    isProcessing = false;
    notifyListeners();
  }
}
