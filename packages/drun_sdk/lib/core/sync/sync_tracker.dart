import 'package:d_sdk/database/app_database.dart';

class SyncTracker {
  final AppDatabase _db;

  SyncTracker(this._db);

  String activityPredicate(String? id) {
    if ((id ?? '').isEmpty) return '';
    return 'AND activity = $id ';
  }

  String assignmentPredicate(String? id) {
    if ((id ?? '').isEmpty) return '';
    return 'AND assignment = $id ';
  }

  String formTemplatePredicate(String? id) {
    if ((id ?? '').isEmpty) return '';
    return 'AND formTemplate = $id';
  }

  Future<bool> hasUnSyncedChanges(
      {String? assignment, String? formTemplate, String? activity}) async {
    return _db.customSelect('''
      SELECT EXISTS(SELECT 1 FROM data_form_submissions WHERE synced = 0 ${activityPredicate(activity)}${activityPredicate(activity)}${activityPredicate(activity)})
    ''').map((row) => row.read<bool>('exists')).getSingle();
  }
}
