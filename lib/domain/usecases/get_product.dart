import 'package:merchant_product_management/domain/entities/product.dart';

import '../../core/utils/typedefs.dart';
import '../entities/paginated_products.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Result<PaginatedProducts>> call({
    required int page,
  }) {
    return repository.getProducts(page: page);
  }
}

class GetProduct {
  final ProductRepository repository;

  GetProduct(this.repository);

  Future<Result<Product>> call(int id) {
    return repository.getProduct(id);
  }
}