import 'package:flutter/material.dart';

import '../models/category_content_args.dart';
import '../models/product.dart';
import 'category_content_screen.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/categories';

  const CategoryScreen({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final categories = <String, List<Product>>{};
    for (final product in products) {
      categories.putIfAbsent(product.category, () => []).add(product);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Danh mục sản phẩm')),
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
          children: categories.entries
              .map((entry) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.teal.shade100),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal.shade50,
                      child: Icon(
                        Icons.category_rounded,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    title: Text(
                      entry.key,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text('${entry.value.length} sản phẩm'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        CategoryContentScreen.routeName,
                        arguments: CategoryContentArgs(
                          categoryName: entry.key,
                          products: entry.value,
                        ),
                      );
                    },
                  ),
                );
              })
              .toList(growable: false),
        ),
      ),
    );
  }
}
