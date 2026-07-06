import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity;

  ConnectivityService(this._connectivity);

  /// Normalize to single value stream
  Stream<ConnectivityResult> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged.map((results) {
        // take strongest signal
        return results.isNotEmpty
            ? results.first
            : ConnectivityResult.none;
      });

  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();

    return result.isNotEmpty &&
        !result.contains(ConnectivityResult.none);
  }
}