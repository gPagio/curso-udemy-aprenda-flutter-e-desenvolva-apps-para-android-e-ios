import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart' show Provider;
import 'package:shop/components/app_drawer.dart' show AppDrawer;
import 'package:shop/components/order_widget.dart' show OrderWidget;
import 'package:shop/models/order_list.dart' show OrderList;

class OrdersPage extends StatefulWidget {
  static final brlFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders().then((_) => setState(() => _isLoading = false));
  }

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<OrderList>(context, listen: false).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    final OrderList orderList = Provider.of<OrderList>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Meus Pedidos')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: orderList.items.isEmpty
                  ? Center(
                      child: Text(
                        'Nenhum pedido realizado!',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: orderList.itemCount,
                      itemBuilder: (ctx, i) =>
                          OrderWidget(order: orderList.items[i]),
                    ),
            ),
      drawer: AppDrawer(),
    );
  }
}
