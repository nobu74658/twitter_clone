import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/data_models/tweet/tweet.dart';
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

  File? imageFile;
  bool isImagePicked = false;

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
      imageFile: imageFile,
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

  Future<void> getImage({required bool isFromGallery}) async {
    isImagePicked = false;
    isProcessing = true;
    notifyListeners();

    imageFile = await userRepository.pickImage(isFromGallery: isFromGallery);

    if (imageFile != null) isImagePicked = true;
    isProcessing = false;
    notifyListeners();
  }

  Stream<QuerySnapshot> getTweetSnapshot() {
    return tweetRepository.getTweetsSnapshot();
  }
}
