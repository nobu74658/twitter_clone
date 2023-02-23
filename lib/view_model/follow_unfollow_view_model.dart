import 'package:flutter/material.dart';

class FollowUnFollowViewModel extends ChangeNotifier {
  FollowUnFollowViewModel() : isFollowed = false;
  bool isFollowed;

  void changeIsFollow(bool isFollowed) {
    this.isFollowed = isFollowed;
    notifyListeners();
  }
}
