import 'package:flutter/material.dart';

class PageViewModel extends ChangeNotifier {
  PageViewModel() : currentIndex = 0;

  int currentIndex;

  void pageTransition(int nextIndex) {
    currentIndex = nextIndex;
    notifyListeners();
  }
}
