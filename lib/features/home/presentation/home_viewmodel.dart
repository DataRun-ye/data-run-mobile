import 'package:d_sdk/database/database.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/features/home/home.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(); /*{
    _load();
  }*/

  final List<Activity> activities = [];

  LoadHomeItems get loadHomeItems => appLocator<LoadHomeItems>();

  User? _user;

  User? get user => _user;

  final _sessionDb = appLocator<DbManager>().db;

  // Future<void> _loadActivities() async {
  //   setBusyForObject(activities, true);
  //   activities.addAll(await loadHomeItems.getActivities());
  //   setBusyForObject(activities, false);
  // }

  Future<void> _load() async {
    setBusyForObject(_user, true);
    _user =
        (await runBusyFuture(_sessionDb.usersDao.getAllItems()))?.firstOrNull;
    setBusyForObject(_user, false);
  }
}
