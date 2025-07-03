import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:d_sdk/database/shared/assignment_status.dart';
import 'package:d_sdk/database/shared/d_identifiable_model.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/home/assignment/domain/assignment_type_service.dart';
import 'package:datarunmobile/home/assignment/domain/model/assignment_access.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class AssignmentServiceImpl implements AssignmentTypeService {
  final AppDatabase _db = appLocator<DbManager>().db;

  @override
  Future<AssignmentType> fetchAssignmentType(String assignmentUid) {
    return _db.managers.assignmentTypes
        .filter((f) => f.typeInstances((f) => f.id(assignmentUid)))
        .getSingle();
  }

  @override
  Future<AssignmentModel> fetchById(String assignmentUid) {
    return _db.managers.assignments
        .filter((f) => f.id(assignmentUid))
        .withReferences((prefetch) => prefetch(
              orgUnit: true,
              team: true,
              activity: true,
            ))
        .map((assignmentWithRefs) {
      final (assignment, ref) = assignmentWithRefs;
      final orgUnit = ref.orgUnit.prefetchedData!.first;
      final team = ref.team.prefetchedData!.first;
      final activity = ref.activity.prefetchedData!.first;
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
          status: assignment.flowStatus ?? AssignmentStatus.PLANNED);
    }).getSingle();
  }

  @override
  Future<bool> isOpen(String assignmentUid) async {
    final enrollment = await _db.managers.assignments
        .filter((f) => f.id(assignmentUid))
        .getSingleOrNull();
    if (enrollment == null || enrollment.flowStatus == null) return true;
    return enrollment.flowStatus!.isActive();
  }

  @override
  Future<AssignmentAccess> getAssignmentAccess(
      String assignmentUid, String formTemplateUid) async {
    final formTemplate = await await _db.managers.assignmentForms
        .filter(
            (f) => f.assignment.id(assignmentUid) & f.form.id(formTemplateUid))
        .getSingleOrNull();
    if (formTemplate == null) return AssignmentAccess.noAccess;

    final hasWrite = formTemplate.canAddSubmissions == true;
    final dataAccess =
        hasWrite ? AssignmentAccess.writeAccess : AssignmentAccess.readAccess;

    return dataAccess;
  }

  @override
  Future<bool> allowInstanceCreation(
      String assignmentUid, String formTemplateUid) async {
    final formTemplate = await await _db.managers.assignmentForms
        .filter(
            (f) => f.assignment.id(assignmentUid) & f.form.id(formTemplateUid))
        .getSingleOrNull();

    return formTemplate?.canAddSubmissions == true;
  }

  @override
  Future<bool> allowInstanceEdit(
      String assignmentUid, String formInstanceUid) async {
    final formInstance = await _db.managers.dataSubmissions
        .filter((f) => f.id(formInstanceUid))
        .getSingleOrNull();
    if (formInstance == null) return false;

    final formTemplateAccess = await await _db.managers.assignmentForms
        .filter((f) =>
            f.assignment.id(assignmentUid) & f.form.id(formInstance.dataTemplate))
        .getSingleOrNull();
    if (formTemplateAccess == null) return false;

    // if is not already synced with server instance
    if (!formInstance.isToUpdate) return true;

    return formTemplateAccess.canEditSubmissions == true;
  }

  @override
  Future<bool> allowInstanceDelete(
      String assignmentUid, String formInstanceUid) async {
    final formInstance = await _db.managers.dataSubmissions
        .filter((f) => f.id(formInstanceUid))
        .getSingleOrNull();
    if (formInstance == null) return false;

    final formTemplate = await await _db.managers.assignmentForms
        .filter((f) =>
            f.assignment.id(assignmentUid) & f.form.id(formInstance.dataTemplate))
        .getSingleOrNull();

    if (formTemplate == null) return false;

    // if is not already synced with server instance
    if (!formInstance.isToUpdate) return true;

    return formTemplate.canDeleteSubmissions == true;
  }
}
