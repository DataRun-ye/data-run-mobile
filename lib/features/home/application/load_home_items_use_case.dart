import 'package:d_sdk/database/database.dart';

class LoadHomeItems {
  LoadHomeItems({required DbManager dbManager}) : _dbManager = dbManager;
  final DbManager _dbManager;

  Future<List<Activity>> getActivities() {
    return _dbManager.db.select(_dbManager.db.activities).get();
  }
}
