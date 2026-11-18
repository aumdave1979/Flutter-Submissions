import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;
  final bool isWishlisted;
  final VoidCallback onToggleWishlist;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAdd,
    required this.isWishlisted,
    required this.onToggleWishlist,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: Image.network(
          product.image,
          width: 50,
          height: 50,
          fit: BoxFit.contain,
        ),
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${product.category} • \$${product.price.toStringAsFixed(2)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                isWishlisted ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: onToggleWishlist,
            ),
            ElevatedButton(onPressed: onAdd, child: const Text('Add')),
          ],
        ),
      ),
    );
  }
}
