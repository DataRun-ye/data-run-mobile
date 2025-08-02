import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:d_sdk/database/shared/assignment_status.dart';
import 'package:d_sdk/database/shared/collections.dart';
import 'package:d_sdk/database/shared/d_identifiable_model.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/data/form_template_list_service.dart';
import 'package:datarunmobile/features/assignment/application/assignment_service.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

/// Implementation
/// assignment, registration, enrollment, planned or not planned
/// tracked entity type (orgUnit), team is an attribute of the tracked entity
/// activity is an attribute of the tracked entity
/// An Enrollment is the association of a Tracked Entity Instance (TEI)
/// with a Program (i.e., a form or process), optionally within a time frame
/// and at a location.
/// It’s not the data — it’s the linkage between the person (or entity)
/// and the form template/program they are participating in.
/// ```
/// Tracked Entity Instance (TEI)
///         ⬇
///     Enrollment (in a Program)
///         ⬇
///       Event(s) (i.e., form submissions / stages)
/// ```
///
/// Assignment: [activity, team, location/orgUnit, time, entity (e.g.,
/// patient, beneficiary...)]
/// entity can be enrolled in the same program multiple times — e.g.,
/// a woman may enroll in "ANC Program" for each pregnancy.
@Injectable(as: AssignmentService)
class AssignmentServiceImpl implements AssignmentService {
  final AppDatabase _db = appLocator<DbManager>().db;

  FormTemplateListService get formTemplateService =>
      appLocator<FormTemplateListService>();

  @override
  Future<AssignmentModel> fetchById(String assignmentUid) async {
    final List<Pair<AssignmentForm, bool>> userForms =
        await formTemplateService.userAvailableForms(assignment: assignmentUid);
    final assignmentForms =
        userForms.where((uf) => uf.first.assignment == assignmentUid).toList();

    final assignmentModel = await _db.managers.assignments
        .filter((f) => f.id(assignmentUid) & f.disabled.not(true))
        .withReferences((prefetch) => prefetch(
              orgUnit: true,
              team: true,
              activity: true,
              forms: true,
            ))
        .map((assignmentWithRefs) {
      final (assignment, ref) = assignmentWithRefs;
      final orgUnit = ref.orgUnit.prefetchedData!.first;
      final team = ref.team.prefetchedData!.first;
      final activity = ref.activity.prefetchedData!.first;
      final forms = ref.forms.prefetchedData ?? [];
      return AssignmentModel(
          id: assignment.id,
          activity: IdentifiableModel(
              id: activity.id,
              name: activity.name,
              description: activity.description,
              code: activity.code ?? '',
              label: activity.label),
          orgUnit: IdentifiableModel(
              id: orgUnit.id,
              name: orgUnit.name,
              code: orgUnit.code ?? '',
              label: orgUnit.label),
          team: IdentifiableModel(
              id: team.id,
              name: '${Intl.message('team')} ${team.code}',
              code: team.code ?? ''),
          formCount: forms.length,
          userForms: assignmentForms,
          status: assignment.status ?? AssignmentStatus.PLANNED);
    }).getSingle();

    return assignmentModel;
  }

  @override
  Future<bool> isOpen(String assignmentUid) async {
    final assignment = await _db.managers.assignments
        .filter((f) => f.id(assignmentUid) & f.disabled.not(true))
        .getSingleOrNull();
    if (assignment == null || assignment.status == null) return true;
    return assignment.status!.isActive();
  }

  @override
  Future<AssignmentForm?> getAssignmentAccessForForm(
      String assignmentUid, String formTemplateUid) async {
    final assignmentFormAccess = await await _db.managers.assignmentForms
        .filter((f) =>
            f.assignment.id(assignmentUid) &
            f.form.id(formTemplateUid) &
            f.assignment.disabled.not(true))
        .getSingleOrNull();

    return assignmentFormAccess;
  }

  @override
  Future<bool> allowInstanceCreation(
      String assignmentUid, String formTemplateUid) async {
    final formTemplate = await await _db.managers.assignmentForms
        .filter((f) =>
            f.assignment.id(assignmentUid) &
            f.form.id(formTemplateUid) &
            f.assignment.disabled.not(true))
        .getSingleOrNull();

    return formTemplate?.canAddSubmissions == true;
  }

  @override
  Future<bool> allowInstanceEdit(
      String assignmentUid, String formInstanceUid) async {
    final formInstance = await _db.managers.dataInstances
        .filter((f) => f.id(formInstanceUid))
        .getSingleOrNull();
    if (formInstance == null) return false;

    final formTemplateAccess = await await _db.managers.assignmentForms
        .filter((f) =>
            f.assignment.id(assignmentUid) &
            f.form.id(formInstance.formTemplate) &
            f.assignment.disabled.not(true))
        .getSingleOrNull();
    if (formTemplateAccess == null) return false;

    // if is not already synced with server instance
    if (!formInstance.isToUpdate) return true;

    return formTemplateAccess.canEditSubmissions == true;
  }

  @override
  Future<bool> allowInstanceDelete(
      String assignmentUid, String formInstanceUid) async {
    final dataSubmission = await _db.managers.dataInstances
        .filter((f) => f.id(formInstanceUid))
        .getSingleOrNull();
    if (dataSubmission == null) return false;

    final formTemplate = await await _db.managers.assignmentForms
        .filter((f) =>
            f.assignment.id(assignmentUid) &
            f.form.id(dataSubmission.formTemplate) &
            f.assignment.disabled.not(true))
        .getSingleOrNull();

    if (formTemplate == null) return false;

    // if is not already synced with server instance
    if (!dataSubmission.isToUpdate) return true;

    return formTemplate.canDeleteSubmissions == true;
  }

  @override
  Future<void> updateAssignmentStatus(
      AssignmentStatus? progressStatus, String assignmentId) async {
    await DSdk.db.managers.assignments
        .filter((f) => f.id(assignmentId))
        .update((o) => o.call(
              status: Value.absentIfNull(progressStatus),
            ));
  }
}
