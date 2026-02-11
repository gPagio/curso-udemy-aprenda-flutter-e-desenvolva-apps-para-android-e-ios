import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:shop/models/auth.dart' show Auth;
import 'package:shop/utils/app_routes.dart' show AppRoutes;

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Bem Vindo!'),
            accountEmail: Text('Usuário'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart_outlined),
            title: Text('Loja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.authOrHome);
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.orders);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar Produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.products);
            },
          ),
          Spacer(),
          SafeArea(
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () {
                Provider.of<Auth>(context, listen: false).logout();

                Navigator.of(
                  context,
                ).pushReplacementNamed(AppRoutes.authOrHome);
              },
            ),
          ),
        ],
      ),
    );
  }
}
