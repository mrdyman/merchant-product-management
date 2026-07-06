import 'package:drift/drift.dart';
import 'package:merchant_product_management/data/datasource/local/app_database.dart'
    as db;

import '../../../../domain/entities/product.dart' as domain;

class DriftProductMapper {
  const DriftProductMapper();

  /// Drift -> Domain
  domain.Product toEntity(db.Product data) {
    return domain.Product(
      id: data.id,
      name: data.name,
      description: data.description,
      price: data.price,
      updatedAt: data.updatedAt,
      isDirty: data.isDirty,
      isDeleted: data.isDeleted,
    );
  }

  /// Domain -> Drift
  db.ProductsCompanion toCompanion(domain.Product entity) {
    return db.ProductsCompanion(
      id: entity.id == null
          ? const Value.absent()
          : Value(entity.id!),
      name: Value(entity.name),
      description: Value(entity.description),
      price: Value(entity.price),
      updatedAt: Value(entity.updatedAt),
      isDirty: Value(entity.isDirty),
      isDeleted: Value(entity.isDeleted),
    );
  }
}