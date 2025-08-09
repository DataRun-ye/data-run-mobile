import 'package:d_sdk/core/sync/sync_summary_model.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/data_instance/application/models.dart';
import 'package:datarunmobile/features/data_instance/application/table.providers.dart';
import 'package:datarunmobile/features/data_instance/data/table_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'table_controller.provider.g.dart';

@riverpod
class TableController extends _$TableController {
  TableRepository get _repository => appLocator<TableRepository>();

  @override
  Future<TableState> build() async {
    // final filters = ref.watch(tableFilterProvider);
    // // final selectedIds = ref.watch(selectedItemsProvider);
    // final pagination = ref.watch(tablePaginationProvider);
    //
    // final (items, total) = await _repository.getItems(
    //   filters: filters,
    //   page: pagination.currentPage,
    //   pageSize: pagination.pageSize,
    //   sortColumn: pagination.sortColumn,
    //   sortAscending: pagination.sortAscending,
    // );

    return TableState();
  }

  Future<List<DataInstance>> deleteSelectedItems() async {
    final selectedIds = ref.read(selectedItemsProvider);
    if (selectedIds.isEmpty) return [];
    final toDeleteInstance = await _repository.getInstances(selectedIds);
    await _repository.delete(selectedIds);
    ref.read(selectedItemsProvider.notifier).clear();
    // ref.read(tablePaginationProvider.notifier).reset();
    // ref.invalidateSelf();
    await future;
    return toDeleteInstance;
  }

  Future<int> restoreItems(List<DataInstance> items) async {
    await _repository.bulkInsert(items);
    // ref.invalidateSelf();
    await future;
    return items.length;
  }

  void toggleSelection(String id) {
    ref.read(selectedItemsProvider.notifier).toggleSelection(id);
  }

  // Future<List<String>> syncableSelectedIds() async {
  //   final selectedIds = ref.read(selectedItemsProvider);
  //   if (selectedIds.isEmpty) return [];
  //   final syncableIds = await _repository.getSyncableIds(selectedIds);
  //   return selectedIds.toList();
  // }

  Future<ImportSummaryModel?> syncSelectedFinalizedItems() async {
    final selectedIds = [...ref.read(selectedItemsProvider)];
    ref.read(selectedItemsProvider.notifier).clear();
    if (selectedIds.isEmpty) return null;
    final syncSummary = await _repository.sync(selectedIds);
    // // ref.invalidateSelf();
    // await future;
    return syncSummary;
  }
}
