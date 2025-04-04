import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun/form/models/geometry.dart';
import 'package:d2_remote/modules/metadatarun/metadatarun.dart';
import 'package:d2_remote/shared/utilities/dhis_uid_generator.util.dart';
import 'package:datarunmobile/commons/d_run_base_service.dart';
import 'package:datarunmobile/commons/query/query_model.dart';
import 'package:datarunmobile/core/models/d_run_identifiable.dart';
import 'package:datarunmobile/commons/identifiable.repository.dart';
import 'package:datarunmobile/data/form/form.dart';
import 'package:datarunmobile/data/form_submission/model/form_submission_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class FormSubmissionListService
    extends DRunBaseService<DataFormSubmission, FormSubmissionModel> {
  FormSubmissionListService(
    super.repository,
    DRunBaseRepository<Assignment> assignmentRepository,
    DRunBaseRepository<Activity> activityRepository,
    DRunBaseRepository<OrgUnit> orgUnitRepository,
    DRunBaseRepository<Team> teamRepository,
    DRunBaseRepository<FormVersion> formVersionRepository,
  )   : _assignmentRepository = assignmentRepository,
        _activityRepository = activityRepository,
        _orgUnitRepository = orgUnitRepository,
        _teamRepository = teamRepository,
        _formVersionRepository = formVersionRepository;

  // SubmissionListService();

  final DRunBaseRepository<Assignment> _assignmentRepository;
  final DRunBaseRepository<Activity> _activityRepository;
  final DRunBaseRepository<OrgUnit> _orgUnitRepository;
  final DRunBaseRepository<Team> _teamRepository;
  final DRunBaseRepository<FormVersion> _formVersionRepository;

  Future<FormSubmissionModel> createEntity(
      {required formVersion,
      required String assignmentId,
      required String team,
      required String form,
      required int version,
      Map<String, dynamic> formData = const {},
      Geometry? geometry}) async {
    final id = DhisUidGenerator.generate();
    final DataFormSubmission submission = DataFormSubmission(
        id: id,
        form: form,
        formVersion: formVersion,
        version: version,
        // activity: activityUid,
        team: team,
        assignment: assignmentId,
        formData: formData,
        dirty: true,
        synced: false,
        deleted: false,
        isFinal: false,
        lastModifiedDate: DateHelper.nowUtc(),
        startEntryTime: DateHelper.nowUtc());

    if (geometry != null) {
      submission.geometry = geometry;
    }

    return createModel(submission);
  }

  @override
  Future<FormSubmissionModel> createModel(
      DataFormSubmission identifiable) async {
    final assignmentId = identifiable.assignment;
    final formVersion =
        await _formVersionRepository.getById(identifiable.formVersion!);
    final assignment = await (assignmentId != null
        ? _assignmentRepository.getById(assignmentId)
        : null);

    final activity = await (assignment != null
        ? _activityRepository.getById(assignment.activity)
        : null);
    final orgUnit = await (assignment != null
        ? _orgUnitRepository.getById(assignment.orgUnit!)
        : null);
    final team = await _teamRepository.getById(identifiable.team!);

    return FormSubmissionModel.fromIdentifiable(
      baseEntity: identifiable,
      formVersion:
          FormVersionModel.fromIdentifiable(identifiableEntity: formVersion!),
      activity: DRunIdentifiable.fromIdentifiable(baseEntity: activity!),
      orgUnit: DRunIdentifiable.fromIdentifiable(baseEntity: orgUnit!),
      team: DRunIdentifiable.fromIdentifiable(baseEntity: team!),
    );
  }
}
