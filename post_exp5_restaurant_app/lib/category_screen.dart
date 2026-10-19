import 'package:flutter/material.dart';

import 'restaurant_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Category')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RestaurantScreen(),
              ),
            );
          },
          child: const Text('Restaurant'),
        ),
      ),
    );
  }
}
