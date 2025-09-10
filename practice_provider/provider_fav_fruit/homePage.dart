import 'package:flutter/material.dart';
import '/new_example/favoritePage.dart';
import 'package:provider/provider.dart';
import 'counterModel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<String> allFruits = const [
    "Apple",
    "Banana",
    "Mango",
    "Orange",
    "Pineapple",
    "Watermelon",
  ];

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoriteFruitsModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Fruits"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              favorites.clearAll();
            },
          ),
        ],
      ),
      body: ListView(
        children: allFruits.map((fruit) {
          final isFavorite = favorites.getFavorites.contains(fruit);
          return ListTile(
            title: Text(fruit),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                if (isFavorite) {
                  favorites.removeFruit(fruit);
                } else {
                  favorites.addFruit(fruit);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
