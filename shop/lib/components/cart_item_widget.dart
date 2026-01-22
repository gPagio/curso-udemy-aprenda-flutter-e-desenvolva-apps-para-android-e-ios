import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart' show Provider;
import 'package:shop/models/cart.dart' show Cart;
import 'package:shop/models/cart_item.dart' show CartItem;
import 'package:shop/models/product_list.dart' show ProductList;

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  static final brlFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final ProductList productListProvider = Provider.of<ProductList>(context);

    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.error,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(Icons.delete, color: Colors.white, size: 40),
      ),
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItem.productId);
      },
      confirmDismiss: (_) async {
        return await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Tem certeza?'),
            content: Text('Quer remover o item do carrinho de compras?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Não'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Sim'),
              ),
            ],
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
              child: Image.network(
                productListProvider.items
                    .where((p) => p.id == cartItem.productId)
                    .first
                    .imageUrl,
              ),
            ),
            title: Text(cartItem.name),
            subtitle: Text(
              "Total: ${brlFormatter.format(cartItem.quantity * cartItem.price)}",
            ),
            trailing: Text(
              "${cartItem.quantity}x ${brlFormatter.format(cartItem.price)}",
            ),
          ),
        ),
      ),
    );
  }
}
