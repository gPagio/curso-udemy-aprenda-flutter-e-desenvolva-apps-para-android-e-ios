import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:shop/components/app_drawer.dart' show AppDrawer;
import 'package:shop/components/product_item.dart' show ProductItem;
import 'package:shop/models/product_list.dart' show ProductList;
import 'package:shop/utils/app_routes.dart' show AppRoutes;

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList productList = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.productForm);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: productList.items.isEmpty
            ? Center(
                child: Text(
                  'Nenhum produto cadastrado!',
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: productList.itemsCount,
                itemBuilder: (ctx, i) => Column(
                  children: [
                    ProductItem(product: productList.items[i]),
                    const Divider(),
                  ],
                ),
              ),
      ),
    );
  }
}
