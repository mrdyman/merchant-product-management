import '../../core/utils/typedefs.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProduct {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  Future<Result<void>> call(Product product) {
    return repository.updateProduct(product);
  }
}