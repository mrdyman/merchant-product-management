import 'package:merchant_product_management/data/models/product_model.dart';
import 'package:merchant_product_management/domain/entities/product.dart';

class ProductModelMapper {
  const ProductModelMapper();

  // Remote/Model → Domain
  Product toEntity(ProductModel model) {
    return Product(
      id: model.id,
      name: model.name,
      description: model.description,
      price: model.price,
      updatedAt: model.updatedAt,
      isDirty: false,
      isDeleted: false,
    );
  }

  // Domain → Model (for API + sync)
  ProductModel toModel(Product entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      updatedAt: entity.updatedAt,
    );
  }
}