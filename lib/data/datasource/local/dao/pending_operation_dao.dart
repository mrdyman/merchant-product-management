import 'package:drift/drift.dart';

import 'package:merchant_product_management/data/datasource/local/app_database.dart';
import 'package:merchant_product_management/data/datasource/local/tables/pending_operations_table.dart';

part 'pending_operation_dao.g.dart';

@DriftAccessor(
  tables: [PendingOperations],
)
class PendingOperationDao
    extends DatabaseAccessor<AppDatabase>
    with _$PendingOperationDaoMixin {
  PendingOperationDao(AppDatabase db)
      : super(db);

  Future<List<PendingOperation>> getAll() {
    return select(pendingOperations).get();
  }

  Future<int> insertOperation(
    PendingOperationsCompanion companion,
  ) {
    return into(
      pendingOperations,
    ).insert(companion);
  }

  Future<void> deleteOperation(
    int id,
  ) {
    return (delete(pendingOperations)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  Future<void> updateRetryCount(
    int id,
    int retry,
  ) {
    return (update(pendingOperations)
          ..where((tbl) => tbl.id.equals(id)))
        .write(
      PendingOperationsCompanion(
        retryCount: Value(retry),
      ),
    );
  }
}