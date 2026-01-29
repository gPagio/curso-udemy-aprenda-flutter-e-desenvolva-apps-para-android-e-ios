import 'dart:convert' show jsonEncode;

import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:http/http.dart' as http show patch;
import 'package:shop/exceptions/http_exception.dart' show HttpException;
import 'package:shop/utils/constants.dart' show Constants;

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _toggleFavorite() async {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    try {
      _toggleFavorite();

      final response = await http.patch(
        Uri.parse('${Constants.productBaseUrl}/$id.json'),
        body: jsonEncode({"isFavorite": isFavorite}),
      );

      if (response.statusCode >= 400) {
        _toggleFavorite();

        throw HttpException(
          msg:
              'Não foi possível ${isFavorite ? 'desfavoritar' : 'favoritar'} o produto!',
          statusCode: response.statusCode,
        );
      }
    } on HttpException {
      rethrow;
    } catch (error) {
      _toggleFavorite();
    }
  }
}
