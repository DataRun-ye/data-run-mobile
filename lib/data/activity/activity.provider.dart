import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/activity_model.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity.provider.g.dart';

@riverpod
ActivityModel activityModel(Ref ref) {
  throw UnimplementedError();
}

@riverpod
Future<List<ActivityModel>> activities(Ref ref) async {
  final db = appLocator<DbManager>().db;
  final userActivities = appLocator<User>().activityUIDs;
  final activities =
      await db.activitiesDao.selectActivities(ids: userActivities).get();

  return activities;
}
