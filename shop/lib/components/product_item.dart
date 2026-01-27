import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart' show Product;
import 'package:shop/models/product_list.dart' show ProductList;
import 'package:shop/utils/app_routes.dart' show AppRoutes;

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed(AppRoutes.productForm, arguments: product);
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () {
                final ProductList productListProvider =
                    Provider.of<ProductList>(context, listen: false);

                showDialog<String>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Tem Certeza?'),
                    content: Text(
                      'Tem Ceteza que Deseja Excluir ${product.name}?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, 'Cancelar'),
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, 'OK'),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                ).then((value) {
                  if (value == 'OK') {
                    productListProvider.removeProduct(product.id);
                  }
                });
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
