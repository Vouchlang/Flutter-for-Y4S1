import 'package:flutter/material.dart';
import '/new_example/counterModel.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoriteFruitsModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("My Favorites")),
      body: favorites.getFavorites.isEmpty
          ? const Center(child: Text("No favorite fruits yet!"))
          : ListView(
              children: favorites.getFavorites.map((fruit) {
                return ListTile(
                  title: Text(fruit),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      favorites.removeFruit(fruit);
                    },
                  ),
                );
              }).toList(),
            ),
    );
  }
}
