import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/domain/filter.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance_service.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Injectable(as: FormInstanceService)
class FormInstanceServiceImpl extends FormInstanceService {
  final AppDatabase _db = appLocator<DbManager>().db;

  @override
  Future<PaginatedResult<SubmissionSummary>> fetchByFilter(
    SubmissionsFilter templateFilter, {
    required int page,
    required int pageSize,
    Iterable<FilterCondition> filters = const [],
    String? sortColumn,
    bool sortAscending = true,
  }) async {
    final totalCount =
        await countByFilter(templateFilter, filters: filters).getSingle();
    //
    // final result = await _db.dataInstancesDao
    //     .selectSubmissions(templateFilter,
    //         filters: filters,
    //         page: page,
    //         pageSize: pageSize,
    //         sortAscending: sortAscending,
    //         sortColumn: sortColumn)
    //     .get();
    final result = await _db.dataInstancesDao
        .selectable(templateFilter,
            filters: filters,
            page: page,
            pageSize: pageSize,
            sortAscending: sortAscending,
            sortColumn: sortColumn)
        .get();
    final len = result.length;
    return PaginatedResult(items: result, totalCount: totalCount);
  }

  @override
  Selectable<int> countByFilter(
    SubmissionsFilter templateFilter, {
    Iterable<FilterCondition> filters = const [],
  }) {
    return _db.dataInstancesDao.countSubmissions(
      templateFilter,
    );
  }

  Stream<PaginatedResult<SubmissionSummary>> watchByFilterWithCount(
    SubmissionsFilter templateFilter, {
    required int page,
    required int pageSize,
    Iterable<FilterCondition> filters = const [],
    String? sortColumn,
    bool sortAscending = true,
  }) {
    final totalCountFuture =
        _db.dataInstancesDao.countSubmissions(templateFilter).watchSingle();

    final pagedDataStream = _db.dataInstancesDao
        .selectSubmissions(
          templateFilter,
          filters: filters,
          page: page,
          pageSize: pageSize,
          sortAscending: sortAscending,
          sortColumn: sortColumn,
        )
        .watch();

    return Rx.forkJoin2(
      pagedDataStream,
      totalCountFuture,
      (List<SubmissionSummary> submissions, int totalCount) {
        return PaginatedResult(items: submissions, totalCount: totalCount);
      },
    ).distinct();
  }

  @override
  Future<bool> isSoftDelete(String instanceUid) async {
    final instance = await _db.managers.dataInstances
        .filter((f) => f.id(instanceUid))
        .getSingleOrNull();
    if (instance == null) return false;
    return instance.isToUpdate;
  }

// @override
// Future<int> delete(Iterable<String> instanceUid) async {
//  return _db.dataInstancesDao.deleteIds(instanceUid);
// }
//
// @override
// Future<List<DataInstance>> sync(Iterable<String> instanceUid  ) async {
//   return _db.dataInstancesDao.upload(instanceUid);
// }
}
