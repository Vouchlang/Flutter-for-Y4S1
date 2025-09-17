import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/todo_bloc.dart';
import 'bloc/todo_event.dart';
import 'bloc/todo_state.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoBloc = context.read<TodoBloc>();
    return Scaffold(
      appBar: AppBar(title: Text("Second Page")),
      body: Center(
        child: Expanded(
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.todos[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                final editController = TextEditingController(
                                  text: state.todos[index],
                                );
                                return AlertDialog(
                                  title: Text("Edit Task"),
                                  content: TextField(
                                    controller: editController,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        final newTask = editController.text;
                                        if (newTask.isNotEmpty) {
                                          todoBloc.add(
                                            UpdateTodo(index, newTask),
                                          );
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: Text("Update"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            todoBloc.add(RemoveTodo(index));
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
