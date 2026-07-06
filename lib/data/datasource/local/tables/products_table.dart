import 'package:drift/drift.dart';

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get description => text()();

  RealColumn get price => real()();

  DateTimeColumn get updatedAt => dateTime()();

  /// Product has local changes waiting for sync.
  BoolColumn get isDirty =>
      boolean().withDefault(const Constant(false))();

  /// Reserved for future delete sync support.
  BoolColumn get isDeleted =>
      boolean().withDefault(const Constant(false))();
}