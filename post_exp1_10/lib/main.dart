import 'package:flutter/material.dart';
import 'views/joke_screen.dart';

void main() {
  runApp(const JokeApp());
}

class JokeApp extends StatelessWidget {
  const JokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Random Jokes App', home: JokeScreen());
  }
}
