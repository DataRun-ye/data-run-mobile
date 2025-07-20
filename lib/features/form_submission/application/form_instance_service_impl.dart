import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/submission_card_summary.dart';
import 'package:d_sdk/database/shared/submissions_filter.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class FormInstanceServiceImpl extends FormInstanceService {
  FormInstanceServiceImpl({@factoryParam required this.formId});

  final String formId;

  final AppDatabase _db = appLocator<DbManager>().db;

  Future<List<SubmissionSummary>> fetchByAssignment(String assignmentId) async {
    final result = _db.dataInstancesDao
        .selectSubmissions(formId,
            filter: SubmissionsFilter(assignment: assignmentId))
        .get();
    return result;
  }

  Future<List<SubmissionSummary>> fetchByFilter(
      SubmissionsFilter? filter) async {
    final result =
        _db.dataInstancesDao.selectSubmissions(formId, filter: filter).get();

    return result;
  }

  @override
  Future<bool> isSoftDelete(String instanceUid) async {
    final instance = await _db.managers.dataInstances
        .filter((f) => f.id(instanceUid))
        .getSingleOrNull();
    if (instance == null) return false;
    return instance.isToUpdate;
  }
}
