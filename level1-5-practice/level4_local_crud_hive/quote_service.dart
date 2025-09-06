import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class QuoteService {
  final Box _box;

  QuoteService(this._box);

  // ---------- READ QUOTES ----------
  List<Map<String, dynamic>> getQuotes() {
    final raw = _box.get('quotes', defaultValue: []);
    return (raw as List).map((e) => Map<String, dynamic>.from(e)).toList();
  }

  // ---------- SAVE QUOTES ----------
  Future<void> saveQuotes(List<Map<String, dynamic>> quotes) async {
    await _box.put('quotes', quotes);
  }

  // ---------- ADD QUOTE ----------
  Future<void> addQuote(BuildContext context) async {
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

    final quotes = getQuotes();
    quotes.insert(0, {
      "quote": quoteController.text,
      "author": authorController.text,
      "id": DateTime.now().millisecondsSinceEpoch,
    });

    await saveQuotes(quotes);
  }

  // ---------- EDIT QUOTE ----------
  Future<void> editQuote(BuildContext context, int index) async {
    final quotes = getQuotes();
    final q = quotes[index];

    final quoteController = TextEditingController(text: q['quote']);
    final authorController = TextEditingController(text: q['author']);

    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Quote"),
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
            child: const Text("Save"),
          ),
        ],
      ),
    );

    if (result != true) return;

    quotes[index] = {
      "quote": quoteController.text,
      "author": authorController.text,
      "id": q['id'], // keep the same ID
    };

    await saveQuotes(quotes);
  }

  // ---------- DELETE QUOTE ----------
  Future<void> deleteQuote(int index) async {
    final quotes = getQuotes();
    quotes.removeAt(index);
    await saveQuotes(quotes);
  }
}
