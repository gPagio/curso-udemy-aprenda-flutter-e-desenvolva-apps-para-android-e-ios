import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/exceptions/http_exception.dart' show HttpException;
import 'package:shop/models/product.dart' show Product;
import 'package:shop/utils/constants.dart' show Constants;
import 'package:uuid/v7.dart' show UuidV7;
import 'package:http/http.dart' as http show post, get, patch, delete;

class ProductList with ChangeNotifier {
  final String _token;
  final List<Product> _items = [];

  ProductList(this._token, List<Product> items);

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(
      Uri.parse('${Constants.productBaseUrl}.json'),
    );

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
      Uri.parse('${Constants.productBaseUrl}.json'),
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

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('${Constants.productBaseUrl}/${product.id}.json'),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }),
      );

      _items[index] = product;
      notifyListeners();
    }
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

  Future<void> removeProduct(Product product) async {
    final index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final indexProduct = _items[index];
      _items.remove(indexProduct);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Constants.productBaseUrl}/${product.id}.json'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, indexProduct);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possível excluir o produto!',
          statusCode: response.statusCode,
        );
      }
    }
  }

  int get itemsCount {
    return _items.length;
  }
}
