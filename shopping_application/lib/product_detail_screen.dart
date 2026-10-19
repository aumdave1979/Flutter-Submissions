import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: Builder(
        builder: (context) {
          final product =
              ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

          return Center(
            child: Text(
              '${product['name']} - ${product['price']}',
            ),
          );
        },
      ),
    );
  }
}
