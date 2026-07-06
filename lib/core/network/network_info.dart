import 'package:injectable/injectable.dart';
import 'connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectionChanged;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final ConnectivityService connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected => connectivity.isConnected;

  @override
  Stream<bool> get onConnectionChanged {
    return connectivity.onConnectivityChanged.map(
      (result) => result != ConnectivityResult.none,
    );
  }
}