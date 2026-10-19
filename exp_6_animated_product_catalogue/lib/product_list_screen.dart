import 'package:flutter/material.dart';

import 'product_details_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  void _openProduct(
    BuildContext context,
    String name,
    int price,
    String heroTag,
  ) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ProductDetailsScreen(
            productName: name,
            productPrice: price,
            heroTag: heroTag,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );

          return FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalogue'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ProductCard(
            productName: 'Laptop',
            productPrice: 50000,
            heroTag: 'laptop',
            onTap: () => _openProduct(context, 'Laptop', 50000, 'laptop'),
          ),
          ProductCard(
            productName: 'Phone',
            productPrice: 30000,
            heroTag: 'phone',
            onTap: () => _openProduct(context, 'Phone', 30000, 'phone'),
          ),
          ProductCard(
            productName: 'Headphones',
            productPrice: 5000,
            heroTag: 'headphones',
            onTap: () =>
                _openProduct(context, 'Headphones', 5000, 'headphones'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/counter');
            },
            child: const Text('Animated Counter'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('Animated Login'),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({
    required this.productName,
    required this.productPrice,
    required this.heroTag,
    required this.onTap,
    super.key,
  });

  final String productName;
  final int productPrice;
  final String heroTag;
  final VoidCallback onTap;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isSelected = false;

  Future<void> _selectProduct() async {
    if (_isSelected) {
      return;
    }

    setState(() {
      _isSelected = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 300));
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: _selectProduct,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(_isSelected ? 20 : 16),
          color: _isSelected ? Colors.blue.shade100 : Colors.white,
          child: Row(
            children: [
              Hero(
                tag: widget.heroTag,
                child: const Icon(
                  Icons.shopping_bag,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text('Price: ${widget.productPrice}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
