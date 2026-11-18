import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/cart_controller.dart';
import 'views/product_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartController(),
      child: const MaterialApp(
        title: 'Shopping Cart App',
        home: ProductListScreen(),
      ),
    ),
  );
}
