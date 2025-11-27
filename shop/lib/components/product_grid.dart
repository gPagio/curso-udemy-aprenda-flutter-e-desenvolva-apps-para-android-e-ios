import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider, Provider;
import 'package:shop/components/product_item.dart' show ProductItem;
import 'package:shop/models/product.dart' show Product;
import 'package:shop/models/product_list.dart' show ProductList;

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider(
        create: (_) => loadedProducts[i],
        child: ProductItem(),
      ),
    );
  }
}
