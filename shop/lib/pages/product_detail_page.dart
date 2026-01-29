import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:shop/models/product.dart' show Product;

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});
  static final brlFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(product.imageUrl, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10),
              Text(
                brlFormatter.format(product.price),
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(product.description, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
