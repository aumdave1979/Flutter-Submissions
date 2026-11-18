import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../controllers/app_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products =
        ModalRoute.of(context)!.settings.arguments as List<Product>;
    final app = context.watch<AppController>();

    final categoryCount = products.map((p) => p.category).toSet().length;
    final avgPrice = products.isEmpty
        ? 0.0
        : products.fold(0.0, (sum, p) => sum + p.price) / products.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Store Statistics')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _statCard('Total Products', '${products.length}'),
            _statCard('Categories', '$categoryCount'),
            _statCard('Avg Price', '\$${avgPrice.toStringAsFixed(2)}'),
            _statCard('Cart Value', '\$${app.total.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value) {
    return Card(
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
