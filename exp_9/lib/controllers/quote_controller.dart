import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/quote.dart';

class QuoteController {
  Future<Quote?> fetchQuote(String category) async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/quotes?limit=100'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List quotes = data['quotes'] ?? [];
        if (quotes.isEmpty) return null;

        // Filter quotes matching the selected category
        final filtered = quotes.where((q) {
          final text = (q['quote'] ?? '').toString().toLowerCase();
          return text.contains(category.toLowerCase());
        }).toList();

        final listToUse = filtered.isNotEmpty ? filtered : quotes;
        final randomQuote = listToUse[Random().nextInt(listToUse.length)];
        return Quote.fromJson(randomQuote);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: Could not fetch quote.');
    }
  }
}
