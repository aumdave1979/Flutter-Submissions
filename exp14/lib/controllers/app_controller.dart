import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}

class AppController extends ChangeNotifier {
  String? userEmail;
  final Map<int, CartItem> _cart = {};

  List<CartItem> get cartItems => _cart.values.toList();
  int get totalQuantity => _cart.values.fold(0, (s, i) => s + i.quantity);
  double get subtotal =>
      _cart.values.fold(0.0, (s, i) => s + (i.product.price * i.quantity));
  double get total => subtotal * 1.05; // 5% tax

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('user_email');
    notifyListeners();
  }

  Future<void> login(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    userEmail = email;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    userEmail = null;
    notifyListeners();
  }

  void addToCart(Product product) {
    if (_cart.containsKey(product.id)) {
      _cart[product.id]!.quantity++;
    } else {
      _cart[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  void removeFromCart(int id) {
    if (!_cart.containsKey(id)) return;
    if (_cart[id]!.quantity > 1) {
      _cart[id]!.quantity--;
    } else {
      _cart.remove(id);
    }
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
