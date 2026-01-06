import 'package:d_sdk/di/app_environment.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final options = InternetCheckOption(
  // uri: Uri.parse('https://example.com'),
  uri: Uri.parse(AppEnvironment.apiPingUrl),
  timeout: Duration(seconds: 5),
  responseStatusFn: (response) {
    return response.statusCode >= 200 && response.statusCode < 402;
  },
);

@lazySingleton
class ConnectivityService {
  ConnectivityService()
      : _connection = InternetConnection.createInstance(
      // useDefaultOptions: false,
      checkInterval: Duration(seconds: 3),
      customCheckOptions: [options])
    ..hasInternetAccess;

  final InternetConnection _connection;

  /// one‑time check
  Future<bool> get isOnline => _connection.hasInternetAccess;

  /// continuous updates
  Stream<InternetStatus> get onStatusChange => _connection.onStatusChange;
}
