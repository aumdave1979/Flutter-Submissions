import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookController {
  Future<List<Book>> searchBooks(String keyword) async {
    try {
      final response = await http.get(
        Uri.parse('https://openlibrary.org/search.json?q=$keyword&limit=20'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List docs = data['docs'] ?? [];
        return docs.map((item) => Book.fromJson(item)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: Could not search books.');
    }
  }
}
