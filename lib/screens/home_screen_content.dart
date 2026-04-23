import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/price_formatter.dart';
import 'product_detail_screen.dart';
import 'profile_screen.dart';

class HomeScreenContent extends StatefulWidget {
  final Function(Product) onAddToCart;
  final List<Product> products;

  const HomeScreenContent({
    super.key,
    required this.onAddToCart,
    required this.products,
  });

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  String _userName = 'Bạn';

  Future<void> _openProfile() async {
    final result = await Navigator.pushNamed(
      context,
      ProfileScreen.routeName,
      arguments: _userName,
    );

    if (result is String && result.trim().isNotEmpty) {
      setState(() {
        _userName = result.trim();
      });
    }
  }

  Future<void> _openDetail(Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(
          product: product,
          onAddToCart: widget.onAddToCart,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' $_userName'),
        actions: [
          IconButton(
            onPressed: _openProfile,
            icon: const Icon(Icons.person_outline_rounded),
            tooltip: 'Hồ sơ',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F7F6), Color(0xFFF6F5EF)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Sản phẩm nổi bật',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Chạm vào sản phẩm để xem chi tiết hoặc thêm vào giỏ hàng.',
            ),
            const SizedBox(height: 14),
            ...widget.products.map(
              (item) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(color: Colors.teal.shade100),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.teal.shade50,
                    child: Icon(item.icon, color: Colors.teal.shade700),
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    '${item.category} • ${formatPrice(item.price)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart_rounded),
                    onPressed: () => widget.onAddToCart(item),
                  ),
                  onTap: () => _openDetail(item),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
