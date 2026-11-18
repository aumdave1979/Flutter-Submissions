import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: cart.items.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        title: Text(
                          item.product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '\$${item.product.price.toStringAsFixed(2)} x ${item.quantity}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () =>
                                  cart.removeFromCart(item.product.id),
                            ),
                            Text('${item.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => cart.addToCart(item.product),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Total Quantity: ${cart.totalQuantity}'),
                      Text('Subtotal: \$${cart.subtotal.toStringAsFixed(2)}'),
                      Text('Tax (5%): \$${cart.tax.toStringAsFixed(2)}'),
                      const SizedBox(height: 6),
                      Text(
                        'Total: \$${cart.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CheckoutScreen(),
                            ),
                          );
                        },
                        child: const Text('Proceed to Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
