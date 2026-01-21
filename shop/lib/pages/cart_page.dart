import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart' show Provider;
import 'package:shop/components/cart_item_widget.dart' show CartItemWidget;
import 'package:shop/models/cart.dart' show Cart;
import 'package:shop/models/order_list.dart' show OrderList;

class CartPage extends StatelessWidget {
  static final brlFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(title: Text("Carrinho")),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      brlFormatter.format(cart.totalAmount),
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).primaryTextTheme.headlineLarge?.color,
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Provider.of<OrderList>(
                        context,
                        listen: false,
                      ).addOrder(cart);
                      cart.clear();
                    },
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Text("COMPRAR"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, i) => CartItemWidget(cartItem: cartItems[i]),
            ),
          ),
        ],
      ),
    );
  }
}
