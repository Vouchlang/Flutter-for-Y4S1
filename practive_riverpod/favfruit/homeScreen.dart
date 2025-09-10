import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider.dart';
import 'savedScreen.dart';

class FruitListScreen extends ConsumerWidget {
  const FruitListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedFruits = ref.watch(savedFruitsProvider);
    final fruits = [
      'Apple',
      'Banana',
      'Mango',
      'Orange',
      'Grapes',
      'Pineapple',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Fruits List")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: fruits.length,
                itemBuilder: (context, index) {
                  final fruit = fruits[index];
                  final isSaved = savedFruits.contains(fruit);
                  return ListTile(
                    title: Text(fruit),
                    trailing: IconButton(
                      icon: Icon(
                        isSaved ? Icons.favorite : Icons.favorite_border,
                        color: isSaved ? Colors.red : null,
                      ),
                      onPressed: () {
                        ref
                            .read(savedFruitsProvider.notifier)
                            .toggleFruit(fruit);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.list),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SavedFruitsScreen()),
          );
        },
      ),
    );
  }
}
