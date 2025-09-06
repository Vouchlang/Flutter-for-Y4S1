import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

/// A service class that handles all CRUD operations + API fetch
class QuotesService {
  final Box _box = Hive.box('quotesBox');

  /// Ensure box has an initial value
  void init() {
    if (_box.get('quotes') == null) {
      _box.put('quotes', []);
    }
  }

  /// Get all quotes from Hive
  List<Map<String, dynamic>> getQuotes() {
    final raw = _box.get('quotes', defaultValue: []);
    return (raw as List).map((e) => Map<String, dynamic>.from(e)).toList();
  }

  /// Save quotes back into Hive
  Future<void> saveQuotes(List<Map<String, dynamic>> quotes) async {
    await _box.put('quotes', quotes);
  }

  /// Fetch a random quote from API
  Future<Map<String, dynamic>> fetchNewQuote() async {
    final res = await http.get(
      Uri.parse("https://dummyjson.com/quotes/random"),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return {
        "quote": data['quote'],
        "author": data['author'],
        "id": DateTime.now().millisecondsSinceEpoch, // local unique ID
      };
    } else {
      throw Exception("Failed to fetch");
    }
  }
}
