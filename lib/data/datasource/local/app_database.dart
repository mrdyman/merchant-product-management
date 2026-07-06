import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'dao/pending_operation_dao.dart';
import 'dao/product_dao.dart';
import 'tables/pending_operations_table.dart';
import 'tables/products_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Products,
    PendingOperations,
  ],
  daos: [
    ProductDao,
    PendingOperationDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();

    final file = File(
      p.join(
        dir.path,
        'merchant_product.sqlite',
      ),
    );

    return NativeDatabase(file);
  });
}