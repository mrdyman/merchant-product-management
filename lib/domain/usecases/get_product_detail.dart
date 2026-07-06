import '../../core/utils/typedefs.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductDetail {
  final ProductRepository repository;

  GetProductDetail(this.repository);

  Future<Result<Product>> call(int id) {
    return repository.getProduct(id);
  }
}