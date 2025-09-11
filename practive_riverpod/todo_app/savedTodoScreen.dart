import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider.dart';

class SavedTodosScreen extends ConsumerWidget {
  const SavedTodosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Saved Todos")),
      body: todos.isEmpty
          ? Center(child: Text("No saved todos yet"))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  title: Text(todo.title, style: TextStyle()),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      ref.read(todoProvider.notifier).deleteTodo(todo.id);
                    },
                  ),
                );
              },
            ),
    );
  }
}
