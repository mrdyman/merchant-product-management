import 'package:dartz/dartz.dart';

import 'package:merchant_product_management/core/error/failures.dart';
import 'package:merchant_product_management/core/network/network_info.dart';
import 'package:merchant_product_management/core/utils/typedefs.dart';
import 'package:merchant_product_management/data/datasource/local/product_local_data_source.dart';
import 'package:merchant_product_management/data/datasource/remote/product_remote_data_source.dart';
import 'package:merchant_product_management/data/mapper/product_mapper.dart';
import 'package:merchant_product_management/data/services/sync_service.dart';
import 'package:merchant_product_management/domain/entities/paginated_products.dart';
import 'package:merchant_product_management/domain/entities/product.dart';
import 'package:merchant_product_management/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;
  final ProductLocalDataSource local;
  final NetworkInfo networkInfo;
  final SyncService syncService;
  final ProductModelMapper modelMapper;

  ProductRepositoryImpl({
    required this.remote,
    required this.local,
    required this.networkInfo,
    required this.syncService,
    required this.modelMapper,
  });

  // -------------------------
  // GET PRODUCTS (offline-first)
  // -------------------------
  @override
  Future<Result<PaginatedProducts>> getProducts({
    required int page,
  }) async {
    try {
      final localProducts = await local.getProducts();

      // Always return cache first (offline-first UX)
      final cachedResult = PaginatedProducts(
        items: localProducts,
        currentPage: page,
        hasMore: true,
      );

      if (!await networkInfo.isConnected) {
        return Right(cachedResult);
      }

      final remoteProducts =
          await remote.getProducts(page: page);

      final entities = remoteProducts
          .map((e) => modelMapper.toEntity(e))
          .toList();

      await local.saveProducts(entities);

      final refreshed = await local.getProducts();

      return Right(
        PaginatedProducts(
          items: refreshed,
          currentPage: page,
          hasMore:
              remoteProducts.length ==
              20, // should match API limit
        ),
      );
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  // -------------------------
  // GET SINGLE PRODUCT
  // -------------------------
  @override
  Future<Result<Product>> getProduct(int id) async {
    try {
      final cached = await local.getProduct(id);

      if (cached != null) {
        return Right(cached);
      }

      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure());
      }

      final remoteProduct = await remote.getProduct(id);

      final entity = modelMapper.toEntity(remoteProduct);

      await local.saveProduct(entity);

      return Right(entity);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  // -------------------------
  // CREATE PRODUCT
  // -------------------------
  @override
  Future<Result<void>> createProduct(
    Product product,
  ) async {
    try {
      // always save locally first
      await local.saveProduct(product);

      // queue sync operation
      await local.enqueueCreate(modelMapper.toModel(product));

      // optional immediate sync if online
      if (await networkInfo.isConnected) {
        await syncService.synchronize();
      }

      return const Right(null);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }

  // -------------------------
  // UPDATE PRODUCT
  // -------------------------
  @override
  Future<Result<void>> updateProduct(
    Product product,
  ) async {
    try {
      await local.saveProduct(product);

      await local.enqueueUpdate(modelMapper.toModel(product));

      if (await networkInfo.isConnected) {
        await syncService.synchronize();
      }

      return const Right(null);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }

  // -------------------------
  // SYNC ENTRY POINT
  // -------------------------
  @override
  Future<Result<void>> syncPendingChanges() async {
    try {
      await syncService.synchronize();
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}