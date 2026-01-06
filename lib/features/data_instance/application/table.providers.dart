import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/user_session/preference.provider.dart';
import 'package:datarunmobile/features/data_instance/application/models.dart';
import 'package:datarunmobile/features/data_instance/data/table_repository.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance_service.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'table.providers.g.dart';

@riverpod
class DataInstanceFilter extends _$DataInstanceFilter {
  @override
  SubmissionsFilter build({required String formId, String? assignmentId}) {
    ref.onDispose(() {
      logDebug('DataInstanceFilter disposed');
    });
    return SubmissionsFilter(formId: formId, assignmentId: assignmentId);
  }

  void setAssignmentId(String assignmentId) {
    state = state.copyWith(assignmentId: assignmentId);
  }

  void toggleSyncStatus(InstanceSyncStatus? status) {
    if (status == null) {
      // clear all selected statuses
      state = state.copyWith(syncStates: {});
      return;
    }

    final newSet = {...state.syncStates};
    if (newSet.contains(status)) {
      newSet.remove(status);
    } else {
      newSet.add(status);
    }

    state = state.copyWith(syncStates: newSet);
  }

  void clearSyncStates() {
    state = state.copyWith(syncStates: {});
  }

  void toggleDateBand(DateFilterBand? band) {
    state = state.toggleDateBand(band);
  }

  void updateSearchTerm(String term) {
    state = state.copyWith(searchTerm: term);
  }

  void toggleIncludeDeleted(bool? value) {
    state = state.copyWith(includeDeleted: value ?? false);
  }

  void clear() {
    state = SubmissionsFilter(
        formId: state.formId, assignmentId: state.assignmentId);
  }
}

@riverpod
Stream<int> totalItemsStream(Ref ref,
    {required SubmissionsFilter templateFilter}) {
  final filter = ref.watch(dataInstanceFilterProvider(
      formId: templateFilter.formId,
      assignmentId: templateFilter.assignmentId));
  return appLocator<FormInstanceService>()
      .countByFilter(
        filter,
        // filters: filters,
      )
      .watchSingle();
}

@riverpod
Future<int> totalItems(Ref ref, {required SubmissionsFilter templateFilter}) {
  final filter = ref.watch(dataInstanceFilterProvider(
      formId: templateFilter.formId,
      assignmentId: templateFilter.assignmentId));
  return appLocator<FormInstanceService>().countByFilter(filter).getSingle();
}

@riverpod
class TablePagination extends _$TablePagination {
  @override
  Pagination build() {
    return Pagination();
  }

  // void _updateTotalCount(int newTotal) {
  //   final oldTotal = state.totalItems;
  //   state = state.copyWith(totalItems: newTotal);
  //
  //   // Handle page adjustment when count decreases
  //   if (newTotal < oldTotal) {
  //     final maxPage = (newTotal / state.pageSize).ceil() - 1;
  //     if (state.currentPage > maxPage && maxPage >= 0) {
  //       state = state.copyWith(currentPage: maxPage);
  //       loadPage();
  //     }
  //   }
  // }

  // void updateTotal(int newTotal) {
  //   final last = (newTotal / state.pageSize).ceil() - 1;
  //   final clampedPage = state.currentPage.clamp(0, last);
  //   state = state.copyWith(totalItems: newTotal, currentPage: clampedPage);
  //
  // }
  /// Called when we know totalItems changed (e.g. after deletes)
  void updateTotal(int newTotal) {
    final last = (newTotal / state.pageSize).ceil() - 1;
    // Only clamp if our current pageIndex is out of range
    final newPage = state.currentPage > last ? last : state.currentPage;
    state = state.copyWith(
      totalItems: newTotal,
      currentPage: newPage,
    );
  }

  void update({required int currentPage, required int pageSize}) {
    if (state.currentPage != currentPage || state.pageSize != pageSize) {
      state = state.copyWith(currentPage: currentPage, pageSize: pageSize);
    }
  }

  /// Called when filters change
  void reset() {
    state = state.copyWith(currentPage: 0);
  }

  void onPageSizeChanged(int newSize) {
    state = state.copyWith(
      pageSize: newSize,
      currentPage: 0,
    );
  }

  void onPageIndexChanged(int firstRowIndex) {
    // convert the incoming offset → 0-based pageIndex
    final newPageIndex = firstRowIndex ~/ state.pageSize;
    state = state.copyWith(currentPage: newPageIndex);
  }

  void sort(String column, int index, bool ascending) {
    state = state.copyWith(
        sortColumn: column, sortAscending: ascending, currentPage: 0);
  }
}

// @riverpod
// class TableFilter extends _$TableFilter {
//   @override
//   IList<FilterCondition> build() {
//     return IList();
//   }
//
//   void addFilter(FilterCondition filter) {
//     // ref.read(tablePaginationProvider.notifier).resetToFirstPage();
//     state = state.add(filter);
//   }
//
//   void removeFilter(FilterCondition<Object> filter) {
//     // ref.read(tablePaginationProvider.notifier).resetToFirstPage();
//     state = state.remove(filter);
//   }
// }

@riverpod
class SelectedItems extends _$SelectedItems {
  @override
  ISet<String> build() {
    return ISet();
  }

  void toggleSelection(String id) {
    if (state.contains(id)) {
      state = state.remove(id);
    } else {
      state = state.add(id);
    }
  }

  void setSelectedIds(Iterable<String> ids) {
    state = ISet(ids);
  }

  void removeIds(Iterable<String> ids) {
    state = state.removeAll(ids);
  }

  void validateSelections(Iterable<String> ids) {
    state = state.removeWhere((id) => !ids.contains(id));
  }

  void clear() {
    state = state.clear();
  }
}

@riverpod
Future<ISet<String>> selectedFinalizedItem(Ref ref) async {
  final selectedIds = ref.watch(selectedItemsProvider);
  if (selectedIds.isEmpty) return const ISet.empty();
  final syncableIds =
      await appLocator<TableRepository>().getSyncableIds(selectedIds);
  return ISet(syncableIds);
}

@riverpod
class TableAppearanceController extends _$TableAppearanceController {
  @override
  TableAppearance build() {
    final compactTableView =
        ref.watch(preferenceNotifierProvider(Preference.compactTableView)) ??
            false;
    final upwardDirectionOfSpeedDial = ref.watch(preferenceNotifierProvider(
            Preference.upwardDirectionOfSpeedDial)) ??
        false;
    final fixedActionColumns =
        ref.watch(preferenceNotifierProvider(Preference.fixedActionColumns))
            as bool;

    return TableAppearance(
        fixedActionColumns: fixedActionColumns,
        compact: compactTableView,
        upwardDirectionOfSpeedDial: upwardDirectionOfSpeedDial);
  }

  void toggleCompact(bool? value) {
    // it will invalidate and update this notifier
    ref
        .read(preferenceNotifierProvider(Preference.compactTableView).notifier)
        .update(value ?? false);
  }

  void toggleDirectionOfSpeedDial(bool? value) {
    // it will invalidate and update this notifier
    ref
        .read(preferenceNotifierProvider(Preference.upwardDirectionOfSpeedDial)
            .notifier)
        .update(value ?? false);
  }

  void toggleFixedActionColumns(bool? value) {
    // it will invalidate and update this notifier
    ref
        .read(preferenceNotifierProvider(Preference.upwardDirectionOfSpeedDial)
            .notifier)
        .update(value ?? false);
  }
}
