import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:d_sdk/datasource/metadata_datasource.dart';
import 'package:drift/drift.dart';

// @Order(DSOrder.repeatInstance)
// @Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
class RepeatInstanceDatasource
    extends BaseDataSource<$RepeatInstancesTable, RepeatInstance>
    implements MetaDataSource<RepeatInstance> {
  @override
  String get resourceName => 'repeatInstances';

  @override
  RepeatInstance fromApiJson(Map<String, dynamic> data,
      {ValueSerializer? serializer}) {
    final submission =
        data['submission']['uid'] ?? data['submission']['id']?.toString();
    final parent = data['parent']?['uid'] ?? data['parent']?['id']?.toString();
    return RepeatInstance.fromJson(
        {...data, 'submission': submission, 'parent': parent},
        serializer: serializer);
  }

  @override
  $RepeatInstancesTable get table =>
      db.repeatInstances;
}
