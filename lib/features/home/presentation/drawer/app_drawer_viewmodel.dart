import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/network/network_util.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:stacked/stacked.dart';

class AppDrawerViewModel extends BaseViewModel {
  bool _isOnline = false;

  bool get isOnline => _isOnline;

  UserSession? get user => appLocator<AuthManager>().activeUserSession;

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
    logDebug(' -> dispose()', source: this);

    networkUtil.cancelPing();
  }
}
