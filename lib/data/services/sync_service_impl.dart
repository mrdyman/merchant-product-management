import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:merchant_product_management/core/network/network_info.dart';
import 'package:merchant_product_management/data/datasource/local/dao/pending_operation_dao.dart';
import 'package:merchant_product_management/data/datasource/local/product_local_data_source.dart';
import 'package:merchant_product_management/data/datasource/remote/product_remote_data_source.dart';
import 'package:merchant_product_management/data/models/pending_operation_model.dart';
import 'package:merchant_product_management/data/models/product_model.dart';
import 'package:merchant_product_management/data/services/sync_service.dart';

@LazySingleton(as: SyncService)
class SyncServiceImpl
    implements SyncService {

  SyncServiceImpl(
    this.local,
    this.remote,
    this.networkInfo,
    this.pendingDao,
  );

  final ProductLocalDataSource local;
  final ProductRemoteDataSource remote;
    final NetworkInfo networkInfo;
  final PendingOperationDao pendingDao;
  
  @override
  Future<void> synchronize() async{
     // 1. CHECK NETWORK
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) return;

    // 2. GET PENDING OPERATIONS
    final pending = await pendingDao.getAll();

    if (pending.isEmpty) return;

    // 3. PROCESS SEQUENTIALLY
    for (final op in pending) {
      try {
        final payload = jsonDecode(op.payload);

        final model = ProductModel.fromJson(payload);

        if (op.operation == PendingOperationType.create.name) {
          final created = await remote.createProduct(model);

          // optional: update local with server response
          await local.markClean(op.productId);
        }

        if (op.operation == PendingOperationType.update.name) {
          final updated = await remote.updateProduct(model);

          await local.markClean(op.productId);
        }

        // 4. REMOVE SUCCESSFUL OPERATION
        await pendingDao.deleteOperation(op.id);
      } catch (e) {
        // 5. RETRY LOGIC
        final newRetry = op.retryCount + 1;

        await pendingDao.updateRetryCount(op.id, newRetry);

        // simple backoff rule
        if (newRetry >= 5) {
          // optional: move to dead-letter queue or log
          await pendingDao.deleteOperation(op.id);
        }
      }
    }
  }
}