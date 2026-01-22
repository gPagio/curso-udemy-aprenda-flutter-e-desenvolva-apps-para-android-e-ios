import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:shop/components/app_drawer.dart' show AppDrawer;
import 'package:shop/models/product_list.dart' show ProductList;

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList productList = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar Produtos')),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productList.itemsCount,
          itemBuilder: (ctx, i) => Text(productList.items[i].name),
        ),
      ),
    );
  }
}
