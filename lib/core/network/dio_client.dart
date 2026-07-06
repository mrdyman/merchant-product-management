import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../logger/app_logger.dart';

class DioClient {
  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        contentType: Headers.jsonContentType,
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (message) {
          AppLogger.instance.d(message);
        },
      ),
    );
  }

  late final Dio dio;
}