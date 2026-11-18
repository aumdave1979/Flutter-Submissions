import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../controllers/product_controller.dart';
import '../controllers/app_controller.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductController _productCtrl = ProductController();
  late Future<List<Product>> _productsFuture;

  String _searchQuery = '';
  String _selectedCategory = 'All';
  double _maxPrice = 1000;

  @override
  void initState() {
    super.initState();
    _productsFuture = _productCtrl.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () async {
              final products = await _productsFuture;
              if (context.mounted) {
                Navigator.pushNamed(context, '/dashboard', arguments: products);
              }
            },
          ),
          IconButton(
            icon: Badge(
              label: Text('${app.totalQuantity}'),
              isLabelVisible: app.totalQuantity > 0,
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await app.logout();
              if (context.mounted)
                Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final allProducts = snapshot.data ?? [];
          final categories = [
            'All',
            ...allProducts.map((p) => p.category).toSet(),
          ];

          // Multi-condition filter: Search + Category + Max Price
          final filtered = allProducts.where((p) {
            final matchSearch = p.title.toLowerCase().contains(_searchQuery);
            final matchCategory =
                _selectedCategory == 'All' || p.category == _selectedCategory;
            final matchPrice = p.price <= _maxPrice;
            return matchSearch && matchCategory && matchPrice;
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) =>
                      setState(() => _searchQuery = val.toLowerCase()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedCategory,
                        items: categories
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedCategory = val!),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('Max: \$${_maxPrice.toInt()}'),
                    Slider(
                      value: _maxPrice,
                      min: 10,
                      max: 1000,
                      onChanged: (val) => setState(() => _maxPrice = val),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? const Center(
                        child: Text('No products match your filters.'),
                      )
                    : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final product = filtered[index];
                          return ProductCard(
                            product: product,
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/detail',
                              arguments: product,
                            ),
                            onAdd: () => context
                                .read<AppController>()
                                .addToCart(product),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
