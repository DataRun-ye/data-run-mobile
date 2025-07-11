import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/di/app_environment.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class NetworkUtil {
  NetworkUtil({required Dio dio}) : _dio = dio;
  final Dio _dio;
  CancelToken? _currentPingToken;

  final StreamController<bool> _connectivityStatusController =
      StreamController<bool>.broadcast();

  Stream<bool> get connectivityStatusStream =>
      _connectivityStatusController.stream;

  Future<bool> noAvailableNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }

    final result = connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile);
    return !result;
  }

  Future<bool> isOffline() async {
    return !(await isOnline());
  }

  Future<bool> isOnline() async {
    _currentPingToken = CancelToken();
    try {
      if (await noAvailableNetwork()) return false;
      logDebug('checkInternetConnection: ping ${AppEnvironment.apiPingUrl} ...',
          data: {'runtimeType': this.runtimeType});
      final response = await _dio.get(
        AppEnvironment.apiPingUrl,
        cancelToken: _currentPingToken,
        options: Options(
            extra: {'skipAuth': true},
            sendTimeout: Duration(seconds: 6),
            receiveTimeout: Duration(seconds: 6)),
        // cancelToken: cancelToken
      );
      if (response.statusCode == 200) {
        logDebug('Device is online!', data: {'runtimeType': this.runtimeType});
        return true;
      } else {
        logDebug('Device is offline!', data: {'runtimeType': this.runtimeType});
        return false;
      }
    } on DioException catch (e) {
      logDebug(
          ' Error checking internet Access, setting the status to offline!',
          source: this,
          data: {'error': e.error, 'message': e.message});
      return false;
    } finally {
      _currentPingToken = null;
    }
  }

  void cancelPing() {
    _currentPingToken?.cancel();
  }

  @disposeMethod
  void dispose() {
    _currentPingToken?.cancel();
    _connectivityStatusController.close();
  }
}
