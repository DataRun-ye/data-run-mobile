import 'package:datarunmobile/core/sync/sync_summary_model.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:fast_immutable_collections/src/iset/iset.dart';

abstract class TableRepository {
  Future<int> delete(Iterable<String> ids);

  Future<ImportSummaryModel> sync(Iterable<String> list);

  Future<List<DataInstance>> getInstances(Iterable<String> selectedIds);

  Future<List<String>> getSyncableIds(ISet<String> selectedIds);
}
