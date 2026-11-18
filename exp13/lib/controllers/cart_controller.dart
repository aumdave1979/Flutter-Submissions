import 'package:flutter/material.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartController extends ChangeNotifier {
  final Map<int, CartItem> _items = {};
  final List<Product> _wishlist = [];

  List<CartItem> get items => _items.values.toList();
  List<Product> get wishlist => _wishlist;

  int get totalQuantity =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.values.fold(
    0.0,
    (sum, item) => sum + (item.product.price * item.quantity),
  );

  double get tax => subtotal * 0.05;
  double get total => subtotal + tax;

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity--;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Task 1: Wishlist methods
  bool isWishlisted(int productId) => _wishlist.any((p) => p.id == productId);

  void toggleWishlist(Product product) {
    if (isWishlisted(product.id)) {
      _wishlist.removeWhere((p) => p.id == product.id);
    } else {
      _wishlist.add(product);
    }
    notifyListeners();
  }
}
