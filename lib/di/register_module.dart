import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../core/network/dio_client.dart';
import '../data/datasource/local/app_database.dart';

@module
abstract class RegisterModule {

  @lazySingleton
  Connectivity get connectivity =>
      Connectivity();

  @lazySingleton
  Dio get dio =>
      DioClient().dio;

  @lazySingleton
  AppDatabase get database =>
      AppDatabase();
}