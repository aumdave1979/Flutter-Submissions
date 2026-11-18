import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: Hero(
          tag: 'product_${product.id}',
          child: Image.network(
            product.image,
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${product.category} • \$${product.price.toStringAsFixed(2)}',
        ),
        trailing: ElevatedButton(onPressed: onAdd, child: const Text('Add')),
      ),
    );
  }
}
