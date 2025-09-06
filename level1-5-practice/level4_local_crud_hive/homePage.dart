import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'quote_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late QuoteService _service;
  final Box _box = Hive.box('quotesBox');

  @override
  void initState() {
    super.initState();
    _service = QuoteService(_box);
    if (_box.get('quotes') == null) {
      _box.put('quotes', []);
    }
  }

  @override
  Widget build(BuildContext context) {
    final quotes = _service.getQuotes();

    return Scaffold(
      appBar: AppBar(title: const Text("Quotes CRUD with Service")),
      body: ListView.builder(
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
                  onPressed: () async {
                    await _service.editQuote(context, i);
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await _service.deleteQuote(i);
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _service.addQuote(context);
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
