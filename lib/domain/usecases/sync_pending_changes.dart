import '../../core/utils/typedefs.dart';
import '../repositories/product_repository.dart';

class SyncPendingChanges {
  final ProductRepository repository;

  SyncPendingChanges(this.repository);

  Future<Result<void>> call() {
    return repository.syncPendingChanges();
  }
}