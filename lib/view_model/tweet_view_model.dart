import 'package:flutter/material.dart';
import 'package:twitter_clone/models/repositories/tweet_repository.dart';
import 'package:twitter_clone/models/repositories/user_repository.dart';

class TweetViewModel extends ChangeNotifier {
  TweetViewModel({
    required this.userRepository,
    required this.tweetRepository,
  }) : descController = TextEditingController();

  final UserRepository userRepository;
  final TweetRepository tweetRepository;
  bool isProcessing = false;
  TextEditingController descController;

  Future<void> postTweet() async {
    isProcessing = true;
    notifyListeners();

    final desc = descController.text;
    descController.clear();

    await tweetRepository.postTweet(
      userId: userRepository.printUserId(),
      desc: desc,
    );

    isProcessing = false;
    notifyListeners();
  }

  endProcess() {
    isProcessing = false;
    notifyListeners();
  }

  Future<void> deleteTweet(String tweetId) async {
    isProcessing = true;
    notifyListeners();

    await tweetRepository.deleteTweet(
      tweetId,
    );

    isProcessing = false;
    notifyListeners();
  }
}
