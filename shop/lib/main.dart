import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart' show Cart;
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart' show ProductList;
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart' show OrdersPage;
import 'package:shop/pages/product_detail_page.dart' show ProductDetailPage;
import 'package:shop/pages/product_page.dart' show ProductPage;
import 'package:shop/pages/products_overview_page.dart'
    show ProductsOverviewPage;
import 'package:shop/theme/app_theme.dart' show AppTheme;
import 'package:shop/utils/app_routes.dart' show AppRoutes;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.home: (ctx) => const ProductsOverviewPage(),
          AppRoutes.productDetail: (ctx) => const ProductDetailPage(),
          AppRoutes.cart: (ctx) => const CartPage(),
          AppRoutes.orders: (ctx) => const OrdersPage(),
          AppRoutes.products: (ctx) => const ProductPage(),
        },
      ),
    );
  }
}
