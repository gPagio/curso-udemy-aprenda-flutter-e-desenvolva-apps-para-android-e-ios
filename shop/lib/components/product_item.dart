import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:shop/models/product.dart' show Product;
import 'package:shop/utils/app_routes.dart' show AppRoutes;

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () {
              product.toggleFavorite();
            },
            color: Theme.of(context).colorScheme.secondary,
            icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
          ),
          title: Text(product.title, textAlign: TextAlign.center),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(AppRoutes.productDetail, arguments: product);
          },
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
