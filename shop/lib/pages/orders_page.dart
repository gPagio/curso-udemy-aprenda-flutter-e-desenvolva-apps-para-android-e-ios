import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart' show Provider;
import 'package:shop/components/app_drawer.dart' show AppDrawer;
import 'package:shop/components/order_widget.dart' show OrderWidget;
import 'package:shop/models/order_list.dart' show OrderList;

class OrdersPage extends StatelessWidget {
  static final brlFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orderList = Provider.of<OrderList>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Meus Pedidos')),
      body: orderList.items.isEmpty
          ? Center(
              child: Text(
                'Nenhum pedido realizado!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: orderList.itemCount,
              itemBuilder: (ctx, i) => OrderWidget(order: orderList.items[i]),
            ),
      drawer: AppDrawer(),
    );
  }
}
