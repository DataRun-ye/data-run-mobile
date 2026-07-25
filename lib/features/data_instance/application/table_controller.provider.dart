import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/data_instance/application/submission_table_service.dart';
import 'package:datarunmobile/features/data_instance/application/submission_upload_result.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'table_controller.provider.g.dart';

@riverpod
class TableController extends _$TableController {
  SubmissionTableService get _service => appLocator<SubmissionTableService>();

  @override
  ISet<String> build({required String formId, String? assignmentId}) => ISet();

  void toggleSelection(String id) {
    state = state.contains(id) ? state.remove(id) : state.add(id);
  }

  void retainOnly(Iterable<String> ids) {
    state = state.removeWhere((id) => !ids.contains(id));
  }

  void clearSelection() {
    state = state.clear();
  }

  Future<bool> canDeleteSelectedItems() => _service.canDeleteLocalOnly(state);

  Future<LocalSubmissionDeletionResult> deleteSelectedItems() async {
    final selectedIds = state;
    final result = await _service.deleteLocalOnly(selectedIds);
    if (ref.mounted && result == LocalSubmissionDeletionResult.deleted) {
      clearSelection();
    }
    return result;
  }

  Future<SubmissionUploadResult?> syncSelectedFinalizedItems() async {
    final selectedIds = state;
    if (selectedIds.isEmpty) return null;
    clearSelection();
    final syncSummary = await _service.sync(selectedIds);
    return syncSummary;
  }
}

@riverpod
Future<ISet<String>> selectedFinalizedItem(Ref ref,
    {required String formId, String? assignmentId}) async {
  final selectedIds = ref.watch(tableControllerProvider(
    formId: formId,
    assignmentId: assignmentId,
  ));
  if (selectedIds.isEmpty) return const ISet.empty();
  final syncableIds =
      await appLocator<SubmissionTableService>().getSyncableIds(selectedIds);
  return ISet(syncableIds);
}
