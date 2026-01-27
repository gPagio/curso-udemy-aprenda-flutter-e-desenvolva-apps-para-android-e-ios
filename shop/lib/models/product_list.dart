import 'package:flutter/material.dart';
import 'package:shop/models/product.dart' show Product;
import 'package:shop/data/dummy_data.dart' show dummyProducts;
import 'package:uuid/v7.dart' show UuidV7;

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void saveProduct(Map<String, Object> formData) {
    final bool hasId = formData['id'] != null;

    final product = Product(
      id: hasId ? formData['id'] as String : UuidV7().generate(),
      name: formData['name'] as String,
      description: formData['description'] as String,
      price: formData['price'] as double,
      imageUrl: formData['imageUrl'] as String,
    );

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
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
