import 'package:flutter/material.dart';
import 'package:shop/pages/product_detail_page.dart' show ProductDetailPage;
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme(),
      routes: {
        AppRoutes.home: (ctx) => ProductsOverviewPage(),
        AppRoutes.productDetail: (ctx) => ProductDetailPage(),
      },
    );
  }
}
