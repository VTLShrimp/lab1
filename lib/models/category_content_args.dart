import 'product.dart';

class CategoryContentArgs {
  final String categoryName;
  final List<Product> products;

  const CategoryContentArgs({
    required this.categoryName,
    required this.products,
  });
}
