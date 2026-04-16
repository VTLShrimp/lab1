import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/order.dart';
import '../models/product.dart';
import 'cart_screen.dart';
import 'home_screen_content.dart';
import 'order_history_screen.dart';

class AppShell extends StatefulWidget {
  static const routeName = '/';

  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  final List<CartItem> _cartItems = [];
  final List<Order> _orders = [];

  void _addToCart(Product product) {
    setState(() {
      final existingItem = _cartItems.firstWhere(
        (item) => item.product.id == product.id,
        orElse: () => CartItem(product: product),
      );

      if (existingItem.product.id == product.id &&
          _cartItems.contains(existingItem)) {
        existingItem.quantity++;
      } else {
        _cartItems.add(existingItem);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} đã thêm vào giỏ hàng'),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  void _addOrder(Order order) {
    setState(() {
      _orders.insert(0, order);
      _selectedIndex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: switch (_selectedIndex) {
          0 => const Text('Sản phẩm'),
          1 => const Text('Giỏ hàng'),
          _ => const Text('Đơn đã xác nhận'),
        },
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreenContent(onAddToCart: _addToCart),
          CartScreen(cartItems: _cartItems, onOrderConfirmed: _addOrder),
          OrderHistoryScreen(orders: _orders),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: _cartItems.isEmpty ? null : Text('${_cartItems.length}'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            activeIcon: Badge(
              label: _cartItems.isEmpty ? null : Text('${_cartItems.length}'),
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Giỏ hàng',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.receipt_long_outlined),
            activeIcon: const Icon(Icons.receipt_long),
            label: 'Đơn hàng',
          ),
        ],
      ),
    );
  }
}
