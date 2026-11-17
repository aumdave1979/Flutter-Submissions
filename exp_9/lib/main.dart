import 'package:flutter/material.dart';
import 'views/quote_screen.dart';

void main() {
  runApp(const QuoteApp());
}

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Quote App', home: QuoteScreen());
  }
}
