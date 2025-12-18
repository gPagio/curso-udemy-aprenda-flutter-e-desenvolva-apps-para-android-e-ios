import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid.dart' show ProductGrid;
import 'package:shop/components/badge.dart' show Badge;
import 'package:shop/models/cart.dart';
import 'package:shop/utils/app_routes.dart';

enum FilterOptions { favoritesOnly, all }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                value: FilterOptions.favoritesOnly,
                child: Text('Somente Favoritos'),
              ),
              PopupMenuItem(value: FilterOptions.all, child: Text('Todos')),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favoritesOnly) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cart);
              },
              icon: Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) =>
                Badge(value: cart.itemsCount.toString(), child: child!),
          ),
        ],
      ),
      body: ProductGrid(showFavoritesOnly: _showFavoritesOnly),
    );
  }
}
