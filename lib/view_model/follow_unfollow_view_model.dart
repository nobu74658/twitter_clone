import 'package:flutter/material.dart';

class FollowUnFollowViewModel extends ChangeNotifier {
  FollowUnFollowViewModel() : isFollowed = false;
  bool isFollowed;
  bool isProcessing = false;

  void changeIsFollow(bool isFollowed) {
    isProcessing = true;
    notifyListeners();

    this.isFollowed = isFollowed;

    isProcessing = false;
    notifyListeners();
  }
}
