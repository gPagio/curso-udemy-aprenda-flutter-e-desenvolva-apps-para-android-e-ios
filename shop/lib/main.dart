import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, MultiProvider, ChangeNotifierProxyProvider;
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart' show Cart;
import 'package:shop/models/order_list.dart' show OrderList;
import 'package:shop/models/product_list.dart' show ProductList;
import 'package:shop/pages/auth_or_home_page.dart' show AuthOrHomePage;
import 'package:shop/pages/cart_page.dart' show CartPage;
import 'package:shop/pages/orders_page.dart' show OrdersPage;
import 'package:shop/pages/product_detail_page.dart' show ProductDetailPage;
import 'package:shop/pages/product_form_page.dart' show ProductFormPage;
import 'package:shop/pages/products_page.dart' show ProductsPage;
import 'package:shop/theme/app_theme.dart' show AppTheme;
import 'package:shop/utils/app_routes.dart' show AppRoutes;

void main() {
  dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList('', []),
          update: (ctx, auth, previous) {
            return ProductList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.authOrHome: (ctx) => const AuthOrHomePage(),
          AppRoutes.productDetail: (ctx) => const ProductDetailPage(),
          AppRoutes.cart: (ctx) => const CartPage(),
          AppRoutes.orders: (ctx) => const OrdersPage(),
          AppRoutes.products: (ctx) => const ProductsPage(),
          AppRoutes.productForm: (ctx) => const ProductFormPage(),
        },
      ),
    );
  }
}
