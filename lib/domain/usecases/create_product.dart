import '../../core/utils/typedefs.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class CreateProduct {
  final ProductRepository repository;

  CreateProduct(this.repository);

  Future<Result<void>> call(Product product) {
    return repository.createProduct(product);
  }
}