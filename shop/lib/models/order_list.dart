import 'dart:math' show Random;

import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:shop/models/cart.dart' show Cart;
import 'package:shop/models/order.dart' show Order;

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
