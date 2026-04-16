import 'cart_item.dart';

class Order {
  final String id;
  final DateTime createdAt;
  final List<CartItem> items;
  final int total;

  Order({
    required this.id,
    required this.createdAt,
    required List<CartItem> items,
    required this.total,
  }) : items = List.unmodifiable(items);

  factory Order.fromCartItems(List<CartItem> cartItems) {
    final createdAt = DateTime.now();
    final items = cartItems
        .map((item) => CartItem(product: item.product, quantity: item.quantity))
        .toList(growable: false);

    return Order(
      id: createdAt.microsecondsSinceEpoch.toString(),
      createdAt: createdAt,
      items: items,
      total: items.fold(0, (sum, item) => sum + item.total),
    );
  }

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}
