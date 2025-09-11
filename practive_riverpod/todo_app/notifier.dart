import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todoClass.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(String title) {
    final newTodo = Todo(id: DateTime.now().toString(), title: title);
    state = [...state, newTodo];
  }

  void toggleTodo(String id) {
    state = state
        .map(
          (todo) => todo.id == id
              ? todo.copyWith(isCompleted: !todo.isCompleted)
              : todo,
        )
        .toList();
  }

  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
