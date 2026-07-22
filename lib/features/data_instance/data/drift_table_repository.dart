import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/sync/sync_summary_model.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/features/data_instance/data/table_repository.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/src/iset/iset.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TableRepository)
class DriftTableRepository implements TableRepository {
  final AppDatabase _db = appLocator<AppDatabase>();
  late final dao = _db.dataInstancesDao;

  @override
  Future<int> delete(Iterable<String> ids) async {
    return dao.hardDeleteIds(ids);
  }

  @override
  Future<ImportSummaryModel> sync(Iterable<String> ids) async {
    return dao.upload(ids);
  }

  @override
  Future<List<DataInstance>> getInstances(Iterable<String> selectedIds) async {
    final items = await dao.attachedDatabase.managers.dataInstances
        .filter((f) => f.id.isIn(selectedIds))
        .get();

    return items;
  }

  @override
  Future<List<String>> getSyncableIds(ISet<String> selectedIds) async {
    final items = await dao.attachedDatabase.managers.dataInstances
        .filter((f) =>
            f.id.isIn(selectedIds) &
            f.syncState.isIn([
              InstanceSyncStatus.finalized,
              InstanceSyncStatus.syncFailed,
            ]))
        .get();
    return items.map((e) => e.id).toList();
  }
}
