import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat, DateFormat;
import 'package:shop/models/order.dart' show Order;

class OrderWidget extends StatefulWidget {
  final Order order;

  const OrderWidget({super.key, required this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  static final dhFormatter = DateFormat('dd/MM/yyyy HH:mm');

  static final brlFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Pedido #${'${widget.order.id.split('-').first} - ${widget.order.id.split('-').last}'}',
            ),
            subtitle: Text(
              'Total: ${brlFormatter.format(widget.order.total)} - Date: ${dhFormatter.format(widget.order.dateTime)}',
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              height: widget.order.products.length * 25.0 + 10,
              child: ListView(
                children: widget.order.products.map((p) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        p.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${p.quantity}x ${brlFormatter.format(p.price)}',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
