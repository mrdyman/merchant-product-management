import 'product.dart';

class PaginatedProducts {
  final List<Product> items;
  final int currentPage;
  final bool hasMore;

  const PaginatedProducts({
    required this.items,
    required this.currentPage,
    required this.hasMore,
  });
}