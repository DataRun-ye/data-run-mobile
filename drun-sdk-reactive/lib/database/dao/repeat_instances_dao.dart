import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/tables/repeat_instances.table.dart';
import 'package:drift/drift.dart';

part 'repeat_instances_dao.g.dart';

@DriftAccessor(tables: [RepeatInstances])
class RepeatInstancesDao extends DatabaseAccessor<AppDatabase>
    with _$RepeatInstancesDaoMixin, BaseDaoMixin<RepeatInstance> {
  RepeatInstancesDao(AppDatabase db) : super(db);

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
      repeatInstances;
}
