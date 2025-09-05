import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = Hive.box('data');
  List<dynamic> items = [];

  Future<void> fetchData() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() => items = data);

        // Save API response to Hive
        await box.put('posts', data);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load data from API')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Loaded cached data')));

      // If API fails, load cached data from Hive
      final cachedData = box.get('posts', defaultValue: []);
      setState(() => items = cachedData);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Offline-First App Example")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final post = items[index];
          return ListTile(
            title: Text(
              post['title'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(post['body']),
          );
        },
      ),
    );
  }
}
