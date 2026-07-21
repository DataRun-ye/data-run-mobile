import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/datasource/abstract_datasource.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:d_sdk/datasource/metadata_datasource.dart';
import 'package:d_sdk/datasource/remote_datasource_order_map.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Order(DSOrder.activity)
@Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
class ActivityDatasource extends BaseDataSource<$ActivitiesTable, Activity>
    implements MetaDataSource<Activity> {
  @override
  String get resourceName => 'activities';

  @override
  Future<void> disableStale(List<Object> liveIds) async {
    await (db.update(table)
          ..where((t) => t.columnsByName['id']!.isNotIn(liveIds)))
        .write(RawValuesInsertable({
      'disabled': Variable<bool>(true),
    }));
  }

  @override
  Activity fromApiJson(Map<String, dynamic> data,
      {ValueSerializer? serializer}) {
    final project =
        data['project']?['uid'] ?? data['project']?['id']?.toString();
    return Activity.fromJson({...data, 'project': project as String},
        serializer: serializer);
  }

  @override
  $ActivitiesTable get table => db.activities;
}
