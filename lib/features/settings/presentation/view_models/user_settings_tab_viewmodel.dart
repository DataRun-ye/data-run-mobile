import 'package:d_sdk/database/database.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:stacked/stacked.dart';

class UserSettingsTabViewModel extends BaseViewModel {
  User? _user;

  User? get user => _user;

  final _sessionDb = appLocator<DbManager>().db;

  Future<void> load() async {
    _user =
        (await runBusyFuture(_sessionDb.usersDao.getAllItems())).firstOrNull;
  }

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

  Future<void> logout() async {}
}
