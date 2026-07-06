import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant_product_management/data/datasource/local/app_database.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    int? id,
    required String name,
    required String description,
    required double price,
    required DateTime updatedAt,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

extension ProductModelSyncMapper on ProductModel {
  PendingOperationsCompanion toCompanionForCreate() {
    return PendingOperationsCompanion.insert(
      productId: id!,
      operation: 'create',
      payload: jsonEncode(_toJson()),
    );
  }

  PendingOperationsCompanion toCompanionForUpdate() {
    return PendingOperationsCompanion.insert(
      productId: id!,
      operation: 'update',
      payload: jsonEncode(_toJson()),
    );
  }

  Map<String, dynamic> _toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}