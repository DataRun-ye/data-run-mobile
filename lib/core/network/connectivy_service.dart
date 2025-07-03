import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/di/app_environment.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class NetworkUtil {
  NetworkUtil({required Dio dio, required this.cancelToken}) : _dio = dio;
  final Dio _dio;
  final CancelToken cancelToken;

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
    try {
      if(await noAvailableNetwork()) return false;
      logDebug('checkInternetConnection: ping ${AppEnvironment.apiPingUrl} ...',
          data: {'runtimeType': this.runtimeType});
      final response = await _dio.get(AppEnvironment.apiPingUrl,
          options: Options(extra: {'skipAuth': true}),
          cancelToken: cancelToken);
      if (response.statusCode == 200) {
        logDebug('Device is online!', data: {'runtimeType': this.runtimeType});
        return true;
      } else {
        logDebug('Device is offline!', data: {'runtimeType': this.runtimeType});
        return false;
      }
    } catch (_) {
      logDebug('Error checking internet Access, setting the status to offline!',
          data: {'runtimeType': this.runtimeType});
      return false;
    }
  }

  @disposeMethod
  void dispose() {
    _connectivityStatusController.close();
  }
}
