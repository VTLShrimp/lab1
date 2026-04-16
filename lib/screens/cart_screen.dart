import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/checkout_args.dart';
import '../models/order.dart';
import '../utils/price_formatter.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onOrderConfirmed,
  });

  final List<CartItem> cartItems;
  final ValueChanged<Order> onOrderConfirmed;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> get _items => widget.cartItems;

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _updateQuantity(int index, int newQuantity) {
    if (newQuantity <= 0) {
      _removeItem(index);
      return;
    }

    setState(() {
      _items[index].quantity = newQuantity;
    });
  }

  int _getTotal() {
    return _items.fold(0, (sum, item) => sum + item.total);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE8F7F6), Color(0xFFF6F5EF)],
        ),
      ),
      child: _items.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 56,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Giỏ hàng trống',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(color: Colors.teal.shade100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.teal.shade50,
                                    child: Icon(
                                      item.product.icon,
                                      color: Colors.teal.shade700,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          formatPrice(item.product.price),
                                          style: const TextStyle(
                                            color: Colors.teal,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => _removeItem(index),
                                    icon: const Icon(Icons.close),
                                    color: Colors.red,
                                    iconSize: 20,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => _updateQuantity(
                                          index,
                                          item.quantity - 1,
                                        ),
                                        icon: const Icon(Icons.remove),
                                        iconSize: 18,
                                      ),
                                      Text(
                                        '${item.quantity}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => _updateQuantity(
                                          index,
                                          item.quantity + 1,
                                        ),
                                        icon: const Icon(Icons.add),
                                        iconSize: 18,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Tổng: ${formatPrice(item.total)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tổng tiền:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            formatPrice(_getTotal()),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _items.isEmpty
                              ? null
                              : () async {
                                  final order = await Navigator.push<Order>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CheckoutScreen(
                                        args: CheckoutArgs(
                                          cartItems: _items
                                              .map(
                                                (item) => CartItem(
                                                  product: item.product,
                                                  quantity: item.quantity,
                                                ),
                                              )
                                              .toList(growable: false),
                                        ),
                                      ),
                                    ),
                                  );

                                  if (order == null || !mounted) {
                                    return;
                                  }

                                  widget.onOrderConfirmed(order);

                                  setState(() {
                                    _items.clear();
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Đặt hàng thành công! Tổng: ${formatPrice(order.total)}',
                                      ),
                                    ),
                                  );
                                },
                          icon: const Icon(Icons.shopping_bag_outlined),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text('Thanh toán'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
