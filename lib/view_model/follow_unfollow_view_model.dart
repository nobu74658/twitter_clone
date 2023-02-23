import 'package:flutter/material.dart';

class FollowUnFollowViewModel extends ChangeNotifier {
  FollowUnFollowViewModel() : isFollowed = false;
  bool isFollowed;
  bool isProcessing = false;

  Future<void> changeIsFollow(bool isFollowed) async {
    isProcessing = true;
    notifyListeners();

    this.isFollowed = isFollowed;

    isProcessing = false;
    notifyListeners();
  }
}
