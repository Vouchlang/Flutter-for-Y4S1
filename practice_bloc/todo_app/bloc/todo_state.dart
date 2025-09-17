import 'package:equatable/equatable.dart';

class TodoState extends Equatable {
  final List<String> todos;

  TodoState({required this.todos});

  @override
  List<Object?> get props => [todos];
}
