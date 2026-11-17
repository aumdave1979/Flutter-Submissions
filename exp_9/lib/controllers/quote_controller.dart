import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quote.dart';

class QuoteController {
  Future<Quote?> fetchQuote() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/quotes/random'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data == null || data.isEmpty) {
          return null; // Empty-response state
        }
        return Quote.fromJson(data);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(
        'Network error: Could not fetch quote.',
      ); // Graceful failure handling
    }
  }
}
