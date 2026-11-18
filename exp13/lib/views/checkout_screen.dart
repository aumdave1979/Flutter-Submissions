import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _addressController = TextEditingController();
  String _paymentMethod = 'Cash on Delivery';

  void _placeOrder(CartController cart) {
    if (_addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a delivery address.')),
      );
      return;
    }

    cart.clearCart();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order placed using $_paymentMethod!')),
    );
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Address
            const Text(
              'Delivery Address',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _addressController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Enter your full address...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // 2. Order Summary
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Items: ${cart.totalQuantity}'),
                    Text('Subtotal: \$${cart.subtotal.toStringAsFixed(2)}'),
                    Text('Tax (5%): \$${cart.tax.toStringAsFixed(2)}'),
                    const Divider(),
                    Text(
                      'Total: \$${cart.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 3. Payment Method Selection
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text('Cash on Delivery'),
              value: 'Cash on Delivery',
              groupValue: _paymentMethod,
              onChanged: (val) => setState(() => _paymentMethod = val!),
            ),
            RadioListTile<String>(
              title: const Text('UPI'),
              value: 'UPI',
              groupValue: _paymentMethod,
              onChanged: (val) => setState(() => _paymentMethod = val!),
            ),
            RadioListTile<String>(
              title: const Text('Credit / Debit Card'),
              value: 'Credit / Debit Card',
              groupValue: _paymentMethod,
              onChanged: (val) => setState(() => _paymentMethod = val!),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => _placeOrder(cart),
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
