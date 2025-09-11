import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifier.dart';
import 'todoClass.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>(
  (ref) => TodoNotifier(),
);
