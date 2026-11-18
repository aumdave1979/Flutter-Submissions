import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class ProductController {
  static const _cacheKey = 'cached_products';

  Future<List<Product>> fetchProducts() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      if (response.statusCode == 200) {
        // Save locally for offline access
        await prefs.setString(_cacheKey, response.body);
        final List data = jsonDecode(response.body);
        return data.map((e) => Product.fromJson(e)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      // Offline fallback: load previously saved data
      final cached = prefs.getString(_cacheKey);
      if (cached != null) {
        final List data = jsonDecode(cached);
        return data.map((e) => Product.fromJson(e)).toList();
      }
      throw Exception('No internet and no cached data available.');
    }
  }
}
