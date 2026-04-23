import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/order.dart';
import '../models/product.dart';
import 'cart_screen.dart';
import 'category_screen.dart';
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
  final List<Product> _products = const [
    Product(
      id: 'p1',
      name: 'Tai nghe Orion X',
      category: 'Âm thanh',
      price: 1290000,
      icon: Icons.headphones_rounded,
    ),
    Product(
      id: 'p2',
      name: 'Đồng hồ Nova Fit',
      category: 'Phụ kiện',
      price: 2190000,
      icon: Icons.watch_rounded,
    ),
    Product(
      id: 'p3',
      name: 'Loa Mini Beam',
      category: 'Smart Home',
      price: 890000,
      icon: Icons.speaker_rounded,
    ),
    Product(
      id: 'p4',
      name: 'Bàn phím Pulse K84',
      category: 'Phụ kiện',
      price: 1590000,
      icon: Icons.keyboard_rounded,
    ),
    Product(
      id: 'p5',
      name: 'Chuột Aero Click',
      category: 'Phụ kiện',
      price: 690000,
      icon: Icons.mouse_rounded,
    ),
    Product(
      id: 'p6',
      name: 'Đèn ngủ Luna Lite',
      category: 'Smart Home',
      price: 520000,
      icon: Icons.light_mode_rounded,
    ),
    Product(
      id: 'p7',
      name: 'Camera SafeEye C2',
      category: 'Smart Home',
      price: 1790000,
      icon: Icons.videocam_rounded,
    ),
    Product(
      id: 'p8',
      name: 'Sạc nhanh Volt 65W',
      category: 'Điện năng',
      price: 490000,
      icon: Icons.bolt_rounded,
    ),
    Product(
      id: 'p9',
      name: 'Pin dự phòng Nova 20K',
      category: 'Điện năng',
      price: 990000,
      icon: Icons.battery_charging_full_rounded,
    ),
    Product(
      id: 'p10',
      name: 'Tai nghe AirBeat S',
      category: 'Âm thanh',
      price: 2390000,
      icon: Icons.earbuds_rounded,
    ),
    Product(
      id: 'p11',
      name: 'Micro WaveCast Mini',
      category: 'Âm thanh',
      price: 1290000,
      icon: Icons.mic_external_on_rounded,
    ),
    Product(
      id: 'p12',
      name: 'Vòng tay HealthBand 2',
      category: 'Sức khỏe',
      price: 1190000,
      icon: Icons.health_and_safety_rounded,
    ),
    Product(
      id: 'p13',
      name: 'Cân thông minh FitScale',
      category: 'Sức khỏe',
      price: 1350000,
      icon: Icons.monitor_weight_rounded,
    ),
    Product(
      id: 'p14',
      name: 'Hub USB-C Orbit 7in1',
      category: 'Văn phòng',
      price: 890000,
      icon: Icons.usb_rounded,
    ),
    Product(
      id: 'p15',
      name: 'Giá đỡ Flex Stand',
      category: 'Văn phòng',
      price: 390000,
      icon: Icons.stay_current_portrait_rounded,
    ),
  ];

  void _selectTab(int index) {
    Navigator.pop(context);
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openCategoryScreen() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(products: _products),
      ),
    );
  }

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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal.shade600),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.storefront_rounded, color: Colors.white, size: 32),
                  SizedBox(height: 8),
                  Text(
                    'LAB1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '2224802010523 - Vũ Thanh Lâm',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Trang chủ'),
              onTap: () => _selectTab(0),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart_outlined),
              title: const Text('Giỏ hàng'),
              onTap: () => _selectTab(1),
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text('Đơn hàng'),
              onTap: () => _selectTab(2),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.category_outlined),
              title: const Text('Danh mục'),
              onTap: _openCategoryScreen,
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreenContent(onAddToCart: _addToCart, products: _products),
          CartScreen(cartItems: _cartItems, onOrderConfirmed: _addOrder),
          OrderHistoryScreen(orders: _orders),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
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
