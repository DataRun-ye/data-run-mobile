import 'package:datarunmobile/core/sync/sync_summary_model.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/data_instance/application/table.providers.dart';
import 'package:datarunmobile/features/data_instance/data/table_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'table_controller.provider.g.dart';

@riverpod
class TableController extends _$TableController {
  TableRepository get _repository => appLocator<TableRepository>();

  @override
  Future<void> build() async {}

  Future<List<DataInstance>> deleteSelectedItems() async {
    final selectedIds = ref.read(selectedItemsProvider);
    if (selectedIds.isEmpty) return [];
    final toDeleteInstance = await _repository.getInstances(selectedIds);
    await _repository.delete(selectedIds);
    ref.read(selectedItemsProvider.notifier).clear();
    await future;
    return toDeleteInstance;
  }

  Future<ImportSummaryModel?> syncSelectedFinalizedItems() async {
    final selectedIds = [...ref.read(selectedItemsProvider)];
    ref.read(selectedItemsProvider.notifier).clear();
    if (selectedIds.isEmpty) return null;
    final syncSummary = await _repository.sync(selectedIds);
    return syncSummary;
  }
}
