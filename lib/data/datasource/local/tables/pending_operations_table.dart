import 'package:drift/drift.dart';

class PendingOperations extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Local product ID.
  IntColumn get productId => integer()();

  /// create/update/delete
  TextColumn get operation => text()();

  /// Serialized ProductModel JSON.
  TextColumn get payload => text()();

  IntColumn get retryCount =>
      integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}