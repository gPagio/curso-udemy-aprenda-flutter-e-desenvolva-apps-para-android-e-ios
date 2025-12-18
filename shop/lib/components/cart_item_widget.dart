import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart' show Provider;
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

    return Card(
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
    );
  }
}
