import 'package:flutter/material.dart';

import '../models/category_content_args.dart';
import '../utils/price_formatter.dart';

class CategoryContentScreen extends StatelessWidget {
  static const routeName = '/category-content';

  const CategoryContentScreen({super.key, required this.args});

  final CategoryContentArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nội dung • ${args.categoryName}')),
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
            Text(
              'Danh mục ${args.categoryName}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Nội dung theo danh mục được truyền dữ liệu từ màn Danh mục.',
            ),
            const SizedBox(height: 16),
            ...args.products.map(
              (product) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.teal.shade100),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal.shade50,
                    child: Icon(product.icon, color: Colors.teal.shade700),
                  ),
                  title: Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    '${product.category} • ${formatPrice(product.price)}',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
