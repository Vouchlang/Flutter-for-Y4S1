import 'package:flutter/material.dart';
import 'quotes_contoller.dart';
import 'quotes_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late QuotesService _service;
  late QuotesController _controller;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _service = QuotesService();
    _controller = QuotesController(_service, context, () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final quotes = _service.getQuotes();
    return Scaffold(
      appBar: AppBar(title: const Text("Offline-First Quotes CRUD")),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : quotes.isEmpty
          ? const Center(child: Text("No quotes. Add or fetch one."))
          : ListView.builder(
              itemCount: quotes.length,
              itemBuilder: (_, i) {
                final q = quotes[i];
                return ListTile(
                  title: Text('"${q['quote']}"'),
                  subtitle: Text("- ${q['author']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _controller.editQuote(i),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _controller.deleteQuote(i),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "fetch",
            onPressed: () => _controller.fetchNewQuote(
              (val) => setState(() => _loading = val),
            ),
            child: const Icon(Icons.refresh),
            tooltip: "Fetch Random Quote",
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "add",
            onPressed: () => _controller.addQuote(),
            child: const Icon(Icons.add),
            tooltip: "Add Quote",
          ),
        ],
      ),
    );
  }
}
