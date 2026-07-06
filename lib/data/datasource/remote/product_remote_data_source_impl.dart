import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/dio_client.dart';
import '../../models/product_model.dart';
import 'product_remote_data_source.dart';

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl
    implements ProductRemoteDataSource {
  final DioClient dioClient;

  ProductRemoteDataSourceImpl(this.dioClient);

  Dio get _dio => dioClient.dio;

  @override
  Future<List<ProductModel>> getProducts({
    required int page,
  }) async {
    try {
      final response = await _dio.get(
        '/products',
        queryParameters: {
          '_page': page,
          '_limit': ApiConstants.pageSize,
        },
      );

      final data = response.data as List;

      return data
          .map(
            (e) => ProductModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      final response = await _dio.get('/products/$id');

      return ProductModel.fromJson(response.data);
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<void> createProduct(ProductModel product) async {
    try {
      await _dio.post(
        '/products',
        data: product.toJson(),
      );
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      await _dio.put(
        '/products/${product.id}',
        data: product.toJson(),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw ConflictException();
      }

      throw ServerException();
    }
  }
}