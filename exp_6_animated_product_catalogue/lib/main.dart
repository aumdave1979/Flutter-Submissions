import 'package:exp_6_animated_product_catalogue/login_screen.dart';
import 'package:flutter/material.dart';
import 'counter_screen.dart';
// import 'product_list_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: const LoginScreen(),
      routes: {
        '/counter': (context) => const CounterScreen(),
        '/login': (context) => const LoginScreen(),
      },
    ),
  );
}
