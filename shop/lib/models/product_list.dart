import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart' show Product;
import 'package:uuid/v7.dart' show UuidV7;
import 'package:http/http.dart' as http show post, get;

class ProductList with ChangeNotifier {
  final _url =
      'https://curso-udemy-flutter-shop-default-rtdb.firebaseio.com/products.json';
  final List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse(_url));

    if (response.body == 'null') return;

    final Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach(((productId, productData) {
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ),
      );
    }));
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse(_url),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isFavorite,
      }),
    );

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
