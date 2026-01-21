import 'package:shop/models/cart_item.dart' show CartItem;

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.total,
    required this.products,
    required this.dateTime,
  });
}
