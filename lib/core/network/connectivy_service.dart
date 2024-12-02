import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:datarun/commons/logging/new_app_logging.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();

  ConnectivityService._internal();

  static ConnectivityService get instance => _instance;

  final StreamController<bool> _connectivityStatusController =
      StreamController<bool>.broadcast();

  Stream<bool> get connectivityStatusStream =>
      _connectivityStatusController.stream;

  List<ConnectivityResult> _lastConnectivityCheckResult = [ConnectivityResult.none];

  // bool _isOnline = false;

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
  //   return _checkInternetConnection();
  // }

  Future<bool> isNetworkAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }

    return connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;
  }

  // Future<bool> _checkInternetConnection() async {
  //   try {
  //     logDebug('checkInternetConnection: ping https://google.com ...',
  //         data: {'runtimeType': this.runtimeType});
  //     final response = await http
  //         .get(Uri.parse('https://google.com'))
  //         .timeout(Duration(seconds: 5));
  //     if (response.statusCode == 200) {
  //       logDebug('Device is online!', data: {'runtimeType': this.runtimeType});
  //       _isOnline = true;
  //       _connectivityStatusController.add(true);
  //     } else {
  //       logDebug('Device is offline!', data: {'runtimeType': this.runtimeType});
  //       _isOnline = false;
  //       _connectivityStatusController.add(false);
  //     }
  //   } catch (_) {
  //     logDebug('Error checking internet Access, setting the status to offline!',
  //         data: {'runtimeType': this.runtimeType});
  //     _isOnline = false;
  //     _connectivityStatusController.add(false);
  //   }
  //
  //   return _isOnline;
  // }

  void dispose() {
    _connectivityStatusController.close();
  }
}
