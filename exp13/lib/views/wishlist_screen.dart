import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: cart.wishlist.isEmpty
          ? const Center(child: Text('Your wishlist is empty.'))
          : ListView.builder(
              itemCount: cart.wishlist.length,
              itemBuilder: (context, index) {
                final product = cart.wishlist[index];
                return ListTile(
                  leading: Image.network(product.image, width: 40, height: 40),
                  title: Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => cart.toggleWishlist(product),
                  ),
                );
              },
            ),
    );
  }
}
