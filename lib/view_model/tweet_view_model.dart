import 'package:flutter/material.dart';
import 'package:twitter_clone/data_models/tweet.dart';
import 'package:twitter_clone/models/repositories/tweet_repository.dart';
import 'package:twitter_clone/models/repositories/user_repository.dart';

class TweetViewModel extends ChangeNotifier {
  TweetViewModel({
    required this.userRepository,
    required this.tweetRepository,
  })  : descController = TextEditingController(),
        currentUserTweets = [];

  final UserRepository userRepository;
  final TweetRepository tweetRepository;
  bool isProcessing = false;
  TextEditingController descController;
  List<Tweet> currentUserTweets;

  Future<void> postTweet() async {
    isProcessing = true;
    notifyListeners();

    final desc = descController.text;
    descController.clear();
    final curretUser = await userRepository.getCurrentUser();
    final tweet = await tweetRepository.postTweet(
      userId: userRepository.printUserId(),
      userName: curretUser.userName,
      userIcon: curretUser.userIcon,
      bio: curretUser.bio,
      desc: desc,
    );
    currentUserTweets.add(tweet);

    isProcessing = false;
    notifyListeners();
  }

  endProcess() {
    isProcessing = false;
    notifyListeners();
  }

  Future<void> deleteTweet(Tweet tweet) async {
    isProcessing = true;
    notifyListeners();

    await tweetRepository.deleteTweet(
      tweet.tweetId,
    );
    currentUserTweets.remove(tweet);

    isProcessing = false;
    notifyListeners();
  }

  Future<void> getCurrentUserTweet() async {
    isProcessing = true;
    notifyListeners();

    currentUserTweets = await userRepository.getCurrentUserTweet();

    isProcessing = false;
    notifyListeners();
  }
}
