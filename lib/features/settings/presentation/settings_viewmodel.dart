import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:stacked/stacked.dart';

class SettingsViewmodel extends BaseViewModel {
  User? get user => appLocator<User>();

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
    // await appLocator<AuthManager>().clearUserSession();
    // context.router.replace(LoginRoute());
    // appLocator<AppRouter>().logOut();
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
