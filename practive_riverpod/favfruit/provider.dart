import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifier.dart';

final savedFruitsProvider =
    StateNotifierProvider<SavedFruitsNotifier, List<String>>((ref) {
      return SavedFruitsNotifier();
    });
