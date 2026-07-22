import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/database/shared/submissions_filter.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/user_session/preference.provider.dart';
import 'package:datarunmobile/features/data_instance/application/models.dart';
import 'package:datarunmobile/features/data_instance/data/table_repository.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance_service.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
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

  void toggleDateBand(DateFilterBand? band) {
    state = state.toggleDateBand(band);
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
        ref.watch(preferenceProvider(Preference.compactTableView));
    final upwardDirectionOfSpeedDial =
        ref.watch(preferenceProvider(Preference.upwardDirectionOfSpeedDial)) ??
            false;
    final fixedActionColumns =
        ref.watch(preferenceProvider(Preference.fixedActionColumns));

    return TableAppearance(
        fixedActionColumns: fixedActionColumns,
        compact: compactTableView,
        upwardDirectionOfSpeedDial: upwardDirectionOfSpeedDial);
  }

  void toggleCompact(bool? value) {
    // it will invalidate and update this notifier
    ref
        .read(preferenceProvider(Preference.compactTableView).notifier)
        .update(value ?? false);
  }

  void toggleDirectionOfSpeedDial(bool? value) {
    // it will invalidate and update this notifier
    ref
        .read(
            preferenceProvider(Preference.upwardDirectionOfSpeedDial).notifier)
        .update(value);
  }

  void toggleFixedActionColumns(bool? value) {
    // it will invalidate and update this notifier
    ref
        .read(preferenceProvider(Preference.fixedActionColumns).notifier)
        .update(value);
  }
}
