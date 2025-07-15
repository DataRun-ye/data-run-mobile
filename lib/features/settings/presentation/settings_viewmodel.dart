import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:stacked/stacked.dart';

class SettingsViewmodel extends BaseViewModel {
  Future<void> changePassword(String password) async {
    // setBusy(true);
    // user = (await _sessionDb.usersDao.getAllItems()).firstOrNull;
    // setBusy(false);
  }

  Future<void> changeMobile(String mobile) async {
    // setBusy(true);
    // user = (await _sessionDb.usersDao.getAllItems()).firstOrNull;
    // setBusy(false);
  }

  void logout() async {
    appLocator<AuthManager>().logout();
  }

  @override
  void dispose() {
    super.dispose();
    logDebug('settings dispose()', source: this);
  }
}
