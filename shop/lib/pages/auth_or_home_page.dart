import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:shop/models/auth.dart' show Auth;
import 'package:shop/pages/auth_page.dart' show AuthPage;
import 'package:shop/pages/products_overview_page.dart'
    show ProductsOverviewPage;

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);

    return auth.isAuth ? ProductsOverviewPage() : AuthPage();
  }
}
