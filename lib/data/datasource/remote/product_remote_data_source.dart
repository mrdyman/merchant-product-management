import '../../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    required int page,
  });

  Future<ProductModel> getProduct(int id);

  Future<void> createProduct(ProductModel product);

  Future<void> updateProduct(ProductModel product);
}