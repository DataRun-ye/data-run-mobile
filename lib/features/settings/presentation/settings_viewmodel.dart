import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewmodel extends BaseViewModel {
  // User? get user => appLocator<User>();

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

  Future<void> logout() async {
    // appLocator<NavigationService>().replaceWithLoginView();
    await appLocator<AuthManager>().logout();
    appLocator<NavigationService>().replaceWithLoginView();
    // context.router.replace(LoginRoute());
    // appLocator<AppRouter>().logOut();
  }

  @override
  void dispose() {
    super.dispose();
    logDebug('settings dispose()', source: this);
  }
// void toggleBrightness(bool value) {
//   _ref
//       .read(preferenceNotifierProvider(Preference.themeMode).notifier)
//       .update(value ? ThemeMode.light.index : ThemeMode.dark.index);
// }
//
// void toggleUseMaterial3(bool value) {
//   _ref
//       .read(preferenceNotifierProvider(Preference.useMaterial3).notifier)
//       .update(value);
// }
//
// void selectColorSeed(int value) {}
}
