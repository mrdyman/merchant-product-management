import 'dart:convert';

import 'package:merchant_product_management/data/datasource/local/dao/pending_operation_dao.dart';
import 'package:merchant_product_management/data/datasource/local/dao/product_dao.dart';
import 'package:merchant_product_management/data/mapper/drift_product_mapper.dart';
// import 'package:merchant_product_management/data/datasource/local/mapper/drift_product_mapper.dart';
import 'package:merchant_product_management/data/models/product_model.dart';
import 'package:merchant_product_management/domain/entities/product.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getProducts();

  Future<Product?> getProduct(int id);

  Future<void> saveProduct(Product product);

  Future<void> saveProducts(List<Product> products);

  Future<void> enqueueCreate(ProductModel model);

  Future<void> enqueueUpdate(ProductModel model);

  Future<void> removePendingOperation(int id);

  Future<void> markClean(int productId);
}