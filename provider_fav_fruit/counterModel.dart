import 'package:flutter/material.dart';

class FavoriteFruitsModel with ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get getFavorites => List.unmodifiable(_favorites);

  void addFruit(String fruit) {
    _favorites.add(fruit);
    notifyListeners();
  }

  void removeFruit(String fruit) {
    _favorites.remove(fruit);
    notifyListeners();
  }

  void clearAll() {
    _favorites.clear();
    notifyListeners();
  }
}
