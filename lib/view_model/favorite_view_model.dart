import 'package:flutter/material.dart';
import 'package:twitter_clone/data_models/tweet.dart';
import 'package:twitter_clone/models/repositories/user_repository.dart';

class FavoriteViewModel extends ChangeNotifier {
  FavoriteViewModel({required this.userRepository})
      : favoriteTweets = [],
        isProcessing = false;

  List<Tweet> favoriteTweets;
  bool isProcessing;
  UserRepository userRepository;

  Future<void> getFavoriteTweets() async {
    isProcessing = true;
    notifyListeners();

    favoriteTweets = await userRepository.getFavoriteTweets();

    isProcessing = false;
    notifyListeners();
  }
}
