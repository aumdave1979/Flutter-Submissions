import 'package:flutter/material.dart';
import 'views/book_search_screen.dart';

void main() {
  runApp(const BookSearchApp());
}

class BookSearchApp extends StatelessWidget {
  const BookSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Book Search App',
      home: BookSearchScreen(),
    );
  }
}
