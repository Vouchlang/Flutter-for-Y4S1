import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState(todos: [])) {
    on<AddTodo>((event, emit) {
      final updatedTodos = List<String>.from(state.todos)..add(event.task);
      emit(TodoState(todos: updatedTodos));
    });

    on<RemoveTodo>((event, emit) {
      final updatedTodos = List<String>.from(state.todos)
        ..removeAt(event.index);
      emit(TodoState(todos: updatedTodos));
    });

    on<UpdateTodo>((event, emit) {
      final updatedTodos = List<String>.from(state.todos);
      updatedTodos[event.index] = event.updatedTask;
      emit(TodoState(todos: updatedTodos));
    });
  }
}
