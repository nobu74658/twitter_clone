import 'package:flutter/material.dart';

class FavoriteViewModel extends ChangeNotifier {
  FavoriteViewModel() : isFavorite = false;

  bool isFavorite;
}
