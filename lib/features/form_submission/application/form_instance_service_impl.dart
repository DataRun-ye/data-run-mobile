import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance_service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Injectable(as: FormInstanceService)
class FormInstanceServiceImpl extends FormInstanceService {
  final AppDatabase _db = appLocator<DbManager>().db;

  @override
  Future<List<SubmissionSummary>> fetchByAssignment(String assignmentId) async {
    final result = _db.dataInstancesDao
        .selectSubmissions(
            SubmissionsFilter(formId: '', assignmentId: assignmentId))
        .get();
    return result;
  }

  @override
  Stream<List<SubmissionSummary>> watchByAssignment(String assignmentId) {
    final result = _db.dataInstancesDao
        .selectSubmissions(
            SubmissionsFilter(assignmentId: assignmentId, formId: 'formId'))
        .watch()
        .distinct();
    return result;
  }

  @override
  Future<PagedItems<SubmissionSummary>> fetchByFilter(
      SubmissionsFilter filter) async {
    final totalCount =
        await _db.dataInstancesDao.countSubmissions(filter).getSingle();
    final result = await _db.dataInstancesDao.selectSubmissions(filter).get();
    final len = result.length;

    return PagedItems(
        items: result,
        totalCount: totalCount,
        page: filter.page,
        paged: filter.paged,
        pageSize: filter.pageSize);
  }

  Stream<PagedItems<SubmissionSummary>> watchByFilterWithCount(
      SubmissionsFilter filter) {
    final totalCountFuture =
        _db.dataInstancesDao.countSubmissions(filter).watchSingle();

    final pagedDataStream =
        _db.dataInstancesDao.selectSubmissions(filter).watch();

    return Rx.forkJoin2(
      pagedDataStream,
      totalCountFuture,
      (List<SubmissionSummary> submissions, int? totalCount) {
        return PagedItems(
            items: submissions,
            totalCount: totalCount ?? submissions.length,
            page: filter.page,
            paged: filter.paged,
            pageSize: filter.pageSize);
      },
    ).distinct();
  }

  @override
  Stream<List<SubmissionSummary>> watchByFilter(SubmissionsFilter? filter) {
    final Stream<List<SubmissionSummary>> result = _db.dataInstancesDao
        .selectSubmissions(filter?.copyWith(formId: 'formId') ??
            SubmissionsFilter(formId: 'formId'))
        .watch()
        .distinct();

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
