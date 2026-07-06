import '../../core/utils/typedefs.dart';
import '../entities/paginated_products.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Result<PaginatedProducts>> getProducts({
    required int page,
  });

  Future<Result<Product>> getProduct(int id);

  Future<Result<void>> createProduct(Product product);

  Future<Result<void>> updateProduct(Product product);

  Future<Result<void>> syncPendingChanges();
}