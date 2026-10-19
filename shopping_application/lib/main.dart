import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'product_list_screen.dart';
import 'product_detail_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: const HomeScreen(),
      routes: {
        '/products': (context) => const ProductListScreen(),
        '/details': (context) => const ProductDetailsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    ),
  );
}
