import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'new_example/counterModel.dart';
import 'new_example/homePage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteFruitsModel(), 
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomePage());
  }
}