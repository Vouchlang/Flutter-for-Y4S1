import 'package:flutter/material.dart';
import 'quotes_service.dart';

class QuotesController {
  final QuotesService _service;
  final BuildContext context;
  final VoidCallback refreshUI; // to call setState from HomeScreen

  QuotesController(this._service, this.context, this.refreshUI);

  // ---------- ADD QUOTE ----------
  Future<void> addQuote() async {
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

    final quotes = _service.getQuotes();
    quotes.insert(0, {
      "quote": quoteController.text,
      "author": authorController.text,
      "id": DateTime.now().millisecondsSinceEpoch,
    });
    await _service.saveQuotes(quotes);
    refreshUI();
  }

  // ---------- EDIT QUOTE ----------
  Future<void> editQuote(int index) async {
    final quotes = _service.getQuotes();
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
      "id": q['id'],
    };
    await _service.saveQuotes(quotes);
    refreshUI();
  }

  // ---------- DELETE QUOTE ----------
  Future<void> deleteQuote(int index) async {
    final quotes = _service.getQuotes();
    quotes.removeAt(index);
    await _service.saveQuotes(quotes);
    refreshUI();
  }

  // ---------- FETCH NEW QUOTE ----------
  Future<void> fetchNewQuote(Function setLoading) async {
    setLoading(true);
    try {
      final newQuote = await _service.fetchNewQuote();
      final quotes = _service.getQuotes();
      quotes.insert(0, newQuote);
      await _service.saveQuotes(quotes);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cannot fetch new quote. Using offline data."),
        ),
      );
    } finally {
      setLoading(false);
      refreshUI();
    }
  }
}
