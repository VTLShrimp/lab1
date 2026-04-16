import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/price_formatter.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final Function(Product) onAddToCart;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  void _addToCart(BuildContext context) {
    onAddToCart(product);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết sản phẩm')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF0B7A75), Color(0xFF12A39D)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(product.icon, color: Colors.white, size: 40),
                  const SizedBox(height: 12),
                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.category,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              formatPrice(product.price),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sản phẩm phù hợp cho nhu cầu hằng ngày, thiết kế hiện đại và pin bền bỉ.',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _addToCart(context),
                icon: const Icon(Icons.add_shopping_cart_outlined),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Thêm vào giỏ'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
