// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:merchant_product_management/core/network/connectivity_service.dart'
    as _i394;
import 'package:merchant_product_management/core/network/dio_client.dart'
    as _i371;
import 'package:merchant_product_management/core/network/network_info.dart'
    as _i588;
import 'package:merchant_product_management/data/datasource/local/app_database.dart'
    as _i456;
import 'package:merchant_product_management/data/datasource/local/dao/pending_operation_dao.dart'
    as _i106;
import 'package:merchant_product_management/data/datasource/local/product_local_data_source.dart'
    as _i910;
import 'package:merchant_product_management/data/datasource/remote/product_remote_data_source.dart'
    as _i18;
import 'package:merchant_product_management/data/datasource/remote/product_remote_data_source_impl.dart'
    as _i957;
import 'package:merchant_product_management/data/services/sync_service.dart'
    as _i602;
import 'package:merchant_product_management/data/services/sync_service_impl.dart'
    as _i318;
import 'package:merchant_product_management/di/register_module.dart' as _i210;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i456.AppDatabase>(() => registerModule.database);
    gh.lazySingleton<_i18.ProductRemoteDataSource>(
      () => _i957.ProductRemoteDataSourceImpl(gh<_i371.DioClient>()),
    );
    gh.lazySingleton<_i588.NetworkInfo>(
      () => _i588.NetworkInfoImpl(gh<_i394.ConnectivityService>()),
    );
    gh.lazySingleton<_i602.SyncService>(
      () => _i318.SyncServiceImpl(
        gh<_i910.ProductLocalDataSource>(),
        gh<_i18.ProductRemoteDataSource>(),
        gh<_i588.NetworkInfo>(),
        gh<_i106.PendingOperationDao>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i210.RegisterModule {}
