import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke.dart';

class JokeController {
  Future<Joke?> fetchJoke() async {
    try {
      final response = await http.get(
        Uri.parse('https://official-joke-api.appspot.com/random_joke'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data == null || data.isEmpty) return null;
        return Joke.fromJson(data);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: Could not fetch joke.');
    }
  }
}
