import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Box _box = Hive.box('quotesBox');

  @override
  void initState() {
    super.initState();
    // Ensure there is a list initialized
    if (_box.get('quotes') == null) {
      _box.put('quotes', []);
    }
  }

  // ---------- Get all quotes ----------
  List<Map<String, dynamic>> _getQuotes() {
    final raw = _box.get('quotes', defaultValue: []);
    return (raw as List).map((e) => Map<String, dynamic>.from(e)).toList();
  }

  // ---------- Save all quotes ----------
  Future<void> _saveQuotes(List<Map<String, dynamic>> quotes) async {
    await _box.put('quotes', quotes);
    setState(() {});
  }

  // ---------- Add a new quote ----------
  Future<void> _addQuote() async {
    final quoteController = TextEditingController();
    final authorController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Quote"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: quoteController,
              decoration: const InputDecoration(hintText: "Quote"),
            ),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(hintText: "Author"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Add"),
          ),
        ],
      ),
    );

    if (result != true) return;

    final quotes = _getQuotes();
    quotes.insert(0, {
      "quote": quoteController.text,
      "author": authorController.text,
      "id": DateTime.now().millisecondsSinceEpoch,
    });
    await _saveQuotes(quotes);
  }

  @override
  Widget build(BuildContext context) {
    final quotes = _getQuotes();

    return Scaffold(
      appBar: AppBar(title: const Text("Exercise 3: Multiple Quotes")),
      body: quotes.isEmpty
          ? const Center(child: Text("No quotes. Add one!"))
          : ListView.builder(
              itemCount: quotes.length,
              itemBuilder: (_, i) {
                final q = quotes[i];
                return ListTile(
                  title: Text('"${q['quote']}"'),
                  subtitle: Text("- ${q['author']}"),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addQuote,
        child: const Icon(Icons.add),
        tooltip: "Add Quote",
      ),
    );
  }
}
