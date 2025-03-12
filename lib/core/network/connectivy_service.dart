import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:datarunmobile/commons/constants.dart';
import 'package:http/http.dart' as http;

class ConnectivityService {
  ConnectivityService._internal();

  static final ConnectivityService _instance = ConnectivityService._internal();

  static ConnectivityService get instance => _instance;

  final StreamController<bool> _connectivityStatusController =
      StreamController<bool>.broadcast();

  Stream<bool> get connectivityStatusStream =>
      _connectivityStatusController.stream;

  // bool _isOnline = false;

  // List<ConnectivityResult> _lastConnectivityCheckResult = [];

  // bool get isOnline =>
  //     _lastConnectivityCheckResult != ConnectivityResult.none && _isOnline;

  // Future<void> initialize() {
  //   // logDebug('initializing: ', data: {'runtimeType': this.runtimeType});
  //   StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
  //       .onConnectivityChanged
  //       .listen((List<ConnectivityResult> result) {
  //     // Received changes in available connectivity types!
  //   });
  //
  //   Connectivity().onConnectivityChanged.listen((result) {
  //     if (result != _lastConnectivityCheckResult) {
  //       // _checkInternetConnection();
  //       _lastConnectivityCheckResult = result;
  //     }
  //   });
  //   return checkInternetConnection();
  // }

  Future<bool> isNetworkAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }

    final result = connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile);
    return result;
  }

  Future<bool> checkInternetConnection() async {
    try {
      logDebug('checkInternetConnection: ping $kApiPingUrl ...',
          data: {'runtimeType': this.runtimeType});
      final response =
          await http.get(Uri.parse(kApiPingUrl)).timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) {
        logDebug('Device is online!', data: {'runtimeType': this.runtimeType});
        return true;
        // _isOnline = true;
        // _connectivityStatusController.add(true);
      } else {
        logDebug('Device is offline!', data: {'runtimeType': this.runtimeType});
        return false;
        // _isOnline = false;
        // _connectivityStatusController.add(false);
      }
    } catch (_) {
      logDebug('Error checking internet Access, setting the status to offline!',
          data: {'runtimeType': this.runtimeType});
      return false;
      // _isOnline = false;
      // _connectivityStatusController.add(false);
    }

    // return _isOnline;
  }

  void dispose() {
    _connectivityStatusController.close();
  }
}
