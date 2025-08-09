import 'package:d_sdk/core/sync/sync_summary_model.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/domain/filter.dart';
import 'package:d_sdk/database/shared/submission_status.dart';
import 'package:d_sdk/database/shared/submission_summary.dart';
import 'package:datarunmobile/features/data_instance/data/table_repository.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/src/iset/iset.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TableRepository)
class DriftTableRepository implements TableRepository {
  final dao = DSdk.db.dataInstancesDao;

  @override
  Future<(Iterable<SubmissionSummary>, int)> getItems({
    required int page,
    required int pageSize,
    Iterable<FilterCondition> filters = const [],
    String? sortColumn,
    bool sortAscending = true,
  }) async {
    // data
    final items = await (dao.getFilterQuery(filters: filters)
          ..limit(pageSize, offset: page * pageSize))
        .get();

    // Count
    var countQuery = dao.getFilterQuery(filters: filters)
      ..addColumns([countAll()]);

    final totalCount =
        await countQuery.map((row) => row.read(countAll()) ?? 0).getSingle();

    return (items.map(SubmissionSummary.fromDrift).toList(), totalCount);
  }

  @override
  Selectable<int> getTotalCount(
      {Iterable<FilterCondition> filters = const []}) {
    var countQuery = dao.getFilterQuery(filters: filters)
      ..addColumns([countAll()]);

    return countQuery.map((row) => row.read(countAll()) ?? 0);
  }

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
  Future<void> bulkInsert(List<DataInstance> items) {
    // TODO: implement bulkInsert
    throw UnimplementedError();
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
