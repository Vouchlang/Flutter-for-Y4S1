import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedFruitsNotifier extends StateNotifier<List<String>> {
  SavedFruitsNotifier() : super([]);

  void toggleFruit(String fruit) {
    if (state.contains(fruit)) {
      state = state.where((f) => f != fruit).toList();
    } else {
      state = [...state, fruit];
    }
  }

  void clearAll() {
    state = [];
  }
}
