import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/app_controller.dart';
import 'views/login_screen.dart';
import 'views/product_list_screen.dart';
import 'views/product_detail_screen.dart';
import 'views/cart_screen.dart';
import 'views/checkout_screen.dart';
import 'views/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appController = AppController();
  await appController.loadUser();

  runApp(
    ChangeNotifierProvider.value(
      value: appController,
      child: MaterialApp(
        title: 'E-Commerce App',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        initialRoute: appController.userEmail == null ? '/login' : '/home',
        routes: {
          '/login': (_) => const LoginScreen(),
          '/home': (_) => const ProductListScreen(),
          '/detail': (_) => const ProductDetailScreen(),
          '/cart': (_) => const CartScreen(),
          '/checkout': (_) => const CheckoutScreen(),
          '/dashboard': (_) => const DashboardScreen(),
        },
      ),
    ),
  );
}
