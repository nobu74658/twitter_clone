import 'package:flutter/material.dart';

class PageViewModel extends ChangeNotifier {
  PageViewModel() : currentIndex = 2;

  int currentIndex;

  void pageTransition(int nextIndex) {
    currentIndex = nextIndex;
    notifyListeners();
  }
}
