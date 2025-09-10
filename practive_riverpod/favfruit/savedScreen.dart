import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider.dart';

class SavedFruitsScreen extends ConsumerWidget {
  const SavedFruitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedFruits = ref.watch(savedFruitsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Saved Fruits")),
      body: savedFruits.isEmpty
          ? const Center(child: Text("No fruits saved yet 🍽️"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: savedFruits.length,
              itemBuilder: (context, index) {
                final fruit = savedFruits[index];
                final isSaved = savedFruits.contains(fruit);
                return ListTile(
                  title: Text(fruit),
                  trailing: IconButton(
                    icon: Icon(
                      isSaved ? Icons.favorite : Icons.favorite_border,
                      color: isSaved ? Colors.red : null,
                    ),
                    onPressed: () {
                      ref.read(savedFruitsProvider.notifier).toggleFruit(fruit);
                    },
                  ),
                );
              },
            ),
    );
  }
}
