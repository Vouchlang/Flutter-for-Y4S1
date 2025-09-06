import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String quote = "Loading...";
  String author = "";

  Future<void> fetchQuote() async {
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
      } else {
        setState(() {
          quote = "Failed to fetch quote.";
          author = "";
        });
      }
    } catch (_) {
      setState(() {
        quote = "Error fetching quote.";
        author = "";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exercise 1: API Quote")),
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
                onPressed: fetchQuote,
                child: const Text("Fetch New Quote"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
