import 'package:d_sdk/core/sync/sync_summary_model.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/domain/filter.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/src/iset/iset.dart';

abstract class TableRepository {
  Future<(Iterable<SubmissionSummary>, int)> getItems({
    required int page,
    required int pageSize,
    Iterable<FilterCondition> filters,
    String? sortColumn,
    bool sortAscending = true,
  });

  Future<int> delete(Iterable<String> ids);

  Future<ImportSummaryModel> sync(Iterable<String> list);

  Selectable<int> getTotalCount({Iterable<FilterCondition> filters = const []});

  Future<List<DataInstance>> getInstances(Iterable<String> selectedIds);

  Future<void> bulkInsert(List<DataInstance> items);

  Future<List<String>> getSyncableIds(ISet<String> selectedIds);
}
