import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/database/database.dart';
import 'package:datarunmobile/core/network/connectivy_service.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:stacked/stacked.dart';

class AppDrawerViewModel extends BaseViewModel {
  bool _isOnline = false;

  bool get isOnline => _isOnline;

  User? get user => appLocator<User>();

  NetworkUtil get networkUtil => appLocator<NetworkUtil>();

  Future<void> checkOnline() async {
    logDebug('checkOnline()', source: this);
    _isOnline = await runBusyFuture(networkUtil.isOnline());
  }

  void cancelToken() {
    logDebug('cancelToken()', source: this);
    networkUtil.cancelPing();
  }

  @override
  void dispose() {
    super.dispose();
    logDebug('dispose()', source: this);

    networkUtil.cancelPing();
  }
}
