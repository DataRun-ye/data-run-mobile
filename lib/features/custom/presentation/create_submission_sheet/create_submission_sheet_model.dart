import 'package:d_sdk/core/common/geometry.entity.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/data_run/screens/form_module/form/code_generator.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/features/bottom_sheet/application/bottom_sheet_service.dart';
import 'package:drift/drift.dart';
import 'package:stacked/stacked.dart';

class CreateSubmissionSheetModel extends BaseViewModel {
  final _bottomSheetService = appLocator<BottomSheetService>();

  final String id;

  CreateSubmissionSheetModel({required this.id});

  // final _navigationSheetService = appLocator<NavigationService>();
  final _db = appLocator<DbManager>().db;
  List<FormTemplate> assignedForms = [];
  Assignment? assignment;

  Future<void> showBasicBottomSheet() async {
    setBusy(true);
    final assignmentWithRefs = await _db.managers.assignments
        .filter((f) => f.id(id))
        .withReferences((prefetch) => prefetch(assignmentForms: true))
        .getSingle();

    final (a, refs) = assignmentWithRefs;
    assignment = a;
    final assignmentForms =
        (refs.assignmentForms.prefetchedData ?? []).map((t) => t.form);

    assignedForms = await _db.managers.formTemplates
        .filter((f) => f.id.isIn(assignmentForms))
        .get();

    setBusy(false);
    // final selectedFormVersionId = await _bottomSheetService.showCustomSheet<
    //         FormTemplate, String>(
    //     variant: BottomSheetType.createSubmission,
    //     title: '(${S.current.form(assignedForms.length)})',
    //     description:
    //         'Use this bottom sheet function to show something to the user. It\'s better than the standard alert dialog in terms of UI quality.',
    //     data: assignment);
    // if (selectedFormVersionId?.data != null) {
    //   final submission = await createNewSubmission(
    //       formVersion: selectedFormVersionId!.data!.formVersion,
    //       assignmentId: assignmentId,
    //       team: assignment!.team,
    //       form: selectedFormVersionId.data!.id,
    //       version: selectedFormVersionId.data!.versionNumber);
    // }
    // TODO navigate to submission view
    // _navigationSheetService.rep
  }

  /// injecting the arguments from the context
  Future<DataSubmission> createNewSubmission(
      {required String assignmentId,
      required String team,
      required String form,
      required String formVersion,
      required int version,
      Map<String, dynamic> formData = const {},
      Geometry? geometry}) async {
    final submission = await _db.managers.dataSubmissions.createReturning(
        (o) => o(
            id: CodeGenerator.generateUid(),
            dataTemplate: form,
            dataTemplateVer: formVersion,
            assignmentType: assignmentId,
            assignment: Value(assignmentId),
            syncState: InstanceSyncStatus.draft,
            team: Value(team),
            isToUpdate: false,
            formData: Value(formData)),
        mode: InsertMode.replace);
    return submission;
  }
}
