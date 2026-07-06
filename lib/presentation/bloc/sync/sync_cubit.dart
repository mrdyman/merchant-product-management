import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_product_management/core/network/network_info.dart';
import 'package:merchant_product_management/data/datasource/local/dao/pending_operation_dao.dart';
import 'package:merchant_product_management/data/services/sync_service.dart';

import 'sync_state.dart';

class SyncCubit extends Cubit<SyncState> {
  final NetworkInfo networkInfo;
  final SyncService syncService;
  final PendingOperationDao pendingDao;

  SyncCubit({
    required this.networkInfo,
    required this.syncService,
    required this.pendingDao,
  }) : super(SyncState.initial()) {
    _init();
  }

  void _init() {
    _listenNetwork();
    _loadPendingCount();
  }

  void _listenNetwork() {
    networkInfo.onConnectionChanged.listen((isOnline) async {
      emit(state.copyWith(isOnline: isOnline));

      if (isOnline) {
        await syncPending();
      }
    });
  }

  Future<void> _loadPendingCount() async {
    final pending = await pendingDao.getAll();

    emit(state.copyWith(
      pendingCount: pending.length,
    ));
  }

  Future<void> syncPending() async {
    emit(state.copyWith(isSyncing: true));

    try {
      await syncService.synchronize();

      final pending = await pendingDao.getAll();

      emit(state.copyWith(
        isSyncing: false,
        pendingCount: pending.length,
      ));
    } catch (_) {
      emit(state.copyWith(isSyncing: false));
    }
  }
}