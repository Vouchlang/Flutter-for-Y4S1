import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Box _box = Hive.box('quotesBox');
  String quote = "Loading...";
  String author = "";

  @override
  void initState() {
    super.initState();
    _loadLastQuote(); // load from Hive first
    _fetchNewQuote(); // fetch new quote from API
  }

  // ---------- Load last saved quote from Hive ----------
  void _loadLastQuote() {
    final savedQuote = _box.get('lastQuote');
    if (savedQuote != null) {
      setState(() {
        quote = savedQuote['quote'];
        author = savedQuote['author'];
      });
    }
  }

  // ---------- Fetch new quote from API ----------
  Future<void> _fetchNewQuote() async {
    try {
      final res = await http.get(
        Uri.parse("https://dummyjson.com/quotes/random"),
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          quote = data['quote'];
          author = data['author'];
        });
        // Save the new quote to Hive
        _box.put('lastQuote', {"quote": quote, "author": author});
      } else {
        throw Exception("Failed to fetch quote");
      }
    } catch (_) {
      // Offline fallback: Hive already loaded
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cannot fetch new quote. Using offline data."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exercise 2: Hive Offline Quote")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '"$quote"',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text("- $author", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchNewQuote,
                child: const Text("Fetch New Quote"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
