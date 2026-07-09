import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/datasource/datasource.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Order(DSOrder.dataInstance)
@Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
class DataInstanceDatasource
    extends BaseDataSource<$DataInstancesTable, DataInstance>
    implements MetaDataSource<DataInstance> {
  @override
  String get resourceName => 'dataSubmission';

  @override
  String get resourcePath => '$resourceName?paged=false';

  @override
  DataInstance fromApiJson(Map<String, dynamic> data,
      {ValueSerializer? serializer}) {
    final form = data['form'];
    final version = data['version'];
    final String formId = form != null && version != null
        ? '${form}_$version'
        : data['formVersion'];
    final assignment = data['assignment'];
    final orgUnit = data['orgUnit'];
    final team = data['team'];
    return DataInstance.fromJson({
      ...data,
      'status': InstanceSyncStatus.synced.name,
      'progressStatus': data['status'],
      'form': formId,
      'assignment': assignment,
      'orgUnit': orgUnit,
      'team': team,
    }, serializer: serializer);
  }

  @override
  $DataInstancesTable get table => db.dataInstances;
}
