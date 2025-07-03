import 'package:d_sdk/database/database.dart';
import 'package:datarunmobile/app_router/app_router.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class UserSettingsTabViewModel extends BaseViewModel {
  User? get user => appLocator<User>();

  // Future<void> load() async {
  //   _user =
  //       (await runBusyFuture(_sessionDb.usersDao.getAllItems())).firstOrNull;
  // }

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

  Future<void> logout(BuildContext context) async {
    await appLocator<AuthManager>().clearUserSession();
    // context.router.replace(LoginRoute());
    appLocator<AppRouter>().logOut();
  }
}
