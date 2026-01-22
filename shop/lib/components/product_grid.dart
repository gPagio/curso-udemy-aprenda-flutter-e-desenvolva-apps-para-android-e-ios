import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider, Provider;
import 'package:shop/components/product_grid_item.dart' show ProductGridItem;
import 'package:shop/models/product.dart' show Product;
import 'package:shop/models/product_list.dart' show ProductList;

class ProductGrid extends StatelessWidget {
  final bool showFavoritesOnly;

  const ProductGrid({super.key, required this.showFavoritesOnly});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = showFavoritesOnly
        ? provider.favoriteItems
        : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: ProductGridItem(),
      ),
    );
  }
}
