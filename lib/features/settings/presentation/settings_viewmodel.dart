import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stacked/stacked.dart';

class SettingsViewmodel extends BaseViewModel {
  void logout() async {
    appLocator<AuthManager>().logout();
    Sentry.configureScope((scope) => scope.setUser(null));
  }

  @override
  void dispose() {
    super.dispose();
    logDebug('settings dispose()', source: this);
  }
}
