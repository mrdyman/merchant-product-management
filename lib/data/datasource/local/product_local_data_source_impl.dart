import 'package:merchant_product_management/data/datasource/local/dao/pending_operation_dao.dart';
import 'package:merchant_product_management/data/datasource/local/dao/product_dao.dart';
import 'package:merchant_product_management/data/datasource/local/product_local_data_source.dart';
import 'package:merchant_product_management/data/mapper/drift_product_mapper.dart';
import 'package:merchant_product_management/data/models/product_model.dart';
import 'package:merchant_product_management/domain/entities/product.dart';

class ProductLocalDataSourceImpl
    implements ProductLocalDataSource {
  final ProductDao productDao;
  final PendingOperationDao pendingDao;
  final DriftProductMapper mapper;

  ProductLocalDataSourceImpl({
    required this.productDao,
    required this.pendingDao,
    required this.mapper,
  });

  // -------------------------
  // READ OPERATIONS
  // -------------------------

  @override
  Future<List<Product>> getProducts() async {
    final result = await productDao.getAllProducts();
    return result.map(mapper.toEntity).toList();
  }

  @override
  Future<Product?> getProduct(int id) async {
    final result = await productDao.getProduct(id);

    if (result == null) return null;

    return mapper.toEntity(result);
  }

  // -------------------------
  // WRITE OPERATIONS
  // -------------------------

  @override
  Future<void> saveProduct(Product product) async {
    await productDao.insertProduct(
      mapper.toCompanion(product),
    );
  }

  @override
  Future<void> saveProducts(List<Product> products) async {
    await productDao.insertProducts(
      products.map(mapper.toCompanion).toList(),
    );
  }

  // -------------------------
  // SYNC QUEUE
  // -------------------------

  @override
  Future<void> enqueueCreate(ProductModel model) async {
    await pendingDao.insertOperation(
      model.id == null
          ? throw Exception('Cannot enqueue create without ID')
          : model.toCompanionForCreate(),
    );
  }

  @override
  Future<void> enqueueUpdate(ProductModel model) async {
    await pendingDao.insertOperation(
      model.id == null
          ? throw Exception('Cannot enqueue update without ID')
          : model.toCompanionForUpdate(),
    );
  }

  @override
  Future<void> removePendingOperation(int id) async {
    await pendingDao.deleteOperation(id);
  }

  @override
  Future<void> markClean(int productId) async {
    await productDao.updateDirtyStatus(productId, false);
  }
}