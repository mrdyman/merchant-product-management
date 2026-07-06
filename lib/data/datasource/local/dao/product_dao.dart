import 'package:drift/drift.dart';
import 'package:merchant_product_management/data/datasource/local/tables/products_table.dart';

import '../app_database.dart';

part 'product_dao.g.dart';

@DriftAccessor(tables: [Products])
class ProductDao extends DatabaseAccessor<AppDatabase>
    with _$ProductDaoMixin {
  ProductDao(AppDatabase db) : super(db);

  Future<List<Product>> getAllProducts() {
    return select(products).get();
  }

  Future<Product?> getProduct(int id) {
    return (select(products)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> insertProduct(
    ProductsCompanion companion,
  ) {
    return into(products).insertOnConflictUpdate(companion);
  }

  Future<void> insertProducts(
    List<ProductsCompanion> companions,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        products,
        companions,
      );
    });
  }

  Future<void> updateDirtyStatus(
    int id,
    bool dirty,
  ) {
    return (update(products)
          ..where((tbl) => tbl.id.equals(id)))
        .write(
      ProductsCompanion(
        isDirty: Value(dirty),
      ),
    );
  }

  Future<void> deleteProduct(
    int id,
  ) {
    return (delete(products)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}