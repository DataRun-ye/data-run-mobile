import 'package:d_sdk/di/app_environment.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

@lazySingleton
class ConnectivityService {
  ConnectivityService()
      : _connection = InternetConnection.createInstance(
          customCheckOptions: [
            InternetCheckOption(uri: Uri.parse(AppEnvironment.apiPingUrl)),
          ],
        );

  final InternetConnection _connection;

  /// one‑time check
  Future<bool> get isOnline => _connection.hasInternetAccess;

  /// continuous updates
  Stream<InternetStatus> get onStatusChange => _connection.onStatusChange;
}
