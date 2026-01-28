import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart' show Product;
import 'package:shop/data/dummy_data.dart' show dummyProducts;
import 'package:uuid/v7.dart' show UuidV7;
import 'package:http/http.dart' as http show post;

class ProductList with ChangeNotifier {
  final _baseUrl =
      'https://curso-udemy-flutter-shop-default-rtdb.firebaseio.com';
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  Future<void> addProduct(Product product) {
    final request = http.post(
      Uri.parse('$_baseUrl/products.json'),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isFavorite,
      }),
    );

    return request.then<void>((response) {
      final firebaseId = jsonDecode(response.body)['name'];
      _items.add(
        Product(
          id: firebaseId,
          name: product.name,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
          isFavorite: product.isFavorite,
        ),
      );
      notifyListeners();
    });
  }

  Future<void> updateProduct(Product product) {
    final index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> saveProduct(Map<String, Object> formData) {
    final bool hasId = formData['id'] != null;

    final product = Product(
      id: hasId ? formData['id'] as String : UuidV7().generate(),
      name: formData['name'] as String,
      description: formData['description'] as String,
      price: formData['price'] as double,
      imageUrl: formData['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  void removeProduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }
}
