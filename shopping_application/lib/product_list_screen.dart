import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product List'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Electronics'),
              Tab(text: 'Clothing'),
              Tab(text: 'Books'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListTile(
              title: const Text('Laptop'),
              subtitle: const Text('50000'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: {
                    'name': 'Laptop',
                    'price': 50000,
                  },
                );
              },
            ),
            Center(child: Text('Clothing')),
            Center(child: Text('Books')),
          ],
        ),
      ),
    );
  }
}
