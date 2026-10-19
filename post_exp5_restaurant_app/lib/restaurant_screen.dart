import 'package:flutter/material.dart';

import 'food_details_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FoodDetailsScreen(),
              ),
            );
          },
          child: const Text('Food Details'),
        ),
      ),
    );
  }
}
