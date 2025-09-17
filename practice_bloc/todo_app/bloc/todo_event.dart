import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTodo extends TodoEvent {
  final String task;
  AddTodo(this.task);

  @override
  List<Object?> get props => [task];
}

class RemoveTodo extends TodoEvent {
  final int index;
  RemoveTodo(this.index);

  @override
  List<Object?> get props => [index];
}

class UpdateTodo extends TodoEvent {
  final int index;
  final String updatedTask;

  UpdateTodo(this.index, this.updatedTask);

  @override
  List<Object?> get props => [index, updatedTask];
}
