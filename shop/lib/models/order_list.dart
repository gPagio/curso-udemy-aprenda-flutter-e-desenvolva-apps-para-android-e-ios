import 'dart:convert';

import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:shop/models/cart.dart' show Cart;
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart' show Order;
import 'package:shop/utils/constants.dart' show Constants;
import 'package:http/http.dart' as http show post, get;

class OrderList with ChangeNotifier {
  final String? _token;
  List<Order> _items = [];

  OrderList([this._token = '', List<Order> _items = const []]) {
    this._items.addAll(_items);
  }

  List<Order> get items {
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final respose = await http.post(
      Uri.parse('${Constants.ordersBaseUrl}.json?auth=$_token'),
      body: jsonEncode({
        'total': cart.totalAmount,
        'dateTime': date.toIso8601String(),
        'products': cart.items.values
            .map(
              (cartItem) => {
                'id': cartItem.id,
                'productId': cartItem.productId,
                'name': cartItem.name,
                'quantity': cartItem.quantity,
                'price': cartItem.price,
              },
            )
            .toList(),
      }),
    );

    final id = jsonDecode(respose.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> loadOrders() async {
    List<Order> items = [];

    final response = await http.get(
      Uri.parse('${Constants.ordersBaseUrl}.json?auth=$_token'),
    );

    if (response.body == 'null') return;

    final Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach(((orderId, orderData) {
      items.add(
        Order(
          id: orderId,
          dateTime: DateTime.parse(orderData['dateTime']),
          total: double.parse(orderData['total'].toString()),
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartItem(
              id: item['id'],
              productId: item['productId'],
              name: item['name'],
              quantity: item['quantity'] as int,
              price: (item['price'] as num).toDouble(),
            );
          }).toList(),
        ),
      );
    }));

    _items = items.reversed.toList();
    notifyListeners();
  }
}
