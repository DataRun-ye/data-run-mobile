import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/datasource/datasource.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Order(DSOrder.dataInstance)
@Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
class DataInstanceDatasource
    extends BaseDataSource<$DataInstancesTable, DataInstance>
    implements MetaDataSource<DataInstance> {
  @override
  String get resourceName => 'dataSubmission';

  @override
  String get resourcePath => '$resourceName/objects?paged=false';

  @override
  DataInstance fromApiJson(Map<String, dynamic> data,
      {ValueSerializer? serializer}) {
    final form = data['form'];
    final version = data['version'];
    final String formId = form != null && version != null
        ? '${form}_$version'
        : data['formVersion'];
    final assignment = data['assignment'];
    final orgUnit = data['orgUnit'];
    final team = data['team'];
    return DataInstance.fromJson({
      ...data,
      'status': InstanceSyncStatus.synced.name,
      'progressStatus': data['status'],
      'form': formId,
      'assignment': assignment,
      'orgUnit': orgUnit,
      'team': team,
    }, serializer: serializer);
  }

  // Future<List<DataInstance>> upload(List<String> uids) async {
  //   List<DataInstance> submissions = await db.managers.dataInstances
  //       .filter((f) => f.id.isIn(uids) & f.syncState.isIn(
  //           [InstanceSyncStatus.finalized, InstanceSyncStatus.syncFailed]))
  //       .get();
  //
  //   // List<String> syncableEntityIds = [];
  //   // List<String> syncableTeamIds = [];
  //   // List<String> syncableAssignments = [];
  //
  //   // submissions.forEach((submission) {
  //   //   syncableEntityIds.add(submission.id);
  //   //
  //   //   syncableAssignments.removeWhere((id) => id == submission.assignment);
  //   //   if (submission.assignment != null) {
  //   //     syncableAssignments.add(submission.assignment!);
  //   //   }
  //   //
  //   //   syncableTeamIds.removeWhere((id) => id == submission.team);
  //   //   if (submission.team != null) {
  //   //     syncableTeamIds.add(submission.team!);
  //   //   }
  //   // });
  //
  //   final uploadPayload = submissions.map((submission) {
  //     return submission.toUpload();
  //   }).toList();
  //
  //   final resource = '$resourceName/bulk';
  //
  //   final response = await apiClient.request(
  //       resourceName: resource, data: uploadPayload, method: 'post');
  //
  //   SyncSummaryModel summary = SyncSummaryModel.fromJson(response.data);
  //   logDebug(jsonEncode(uploadPayload.first), data: {"data": uploadPayload});
  //
  //   final List<DataInstance> queue = [];
  //
  //   for (var submission in submissions) {
  //     final syncFailed = summary.failed.containsKey(submission.id);
  //     final syncCreated = summary.created.contains(submission.id);
  //     final syncUpdated = summary.updated.contains(submission.id);
  //     DataInstance newEntity = submission;
  //     if (syncCreated || syncUpdated) {
  //       newEntity = submission.copyWith(
  //           syncState: InstanceSyncStatus.synced,
  //           isToUpdate: true,
  //           lastSyncMessage: Value(null),
  //           lastSyncDate: Value(DateTime.now().toUtc()));
  //       // availableItemCount++;
  //     } else if (syncFailed) {
  //       newEntity = submission.copyWith(
  //           syncState: InstanceSyncStatus.syncFailed,
  //           lastSyncMessage: Value(summary.failed[submission.id]));
  //
  //       // availableItemCount++;
  //     }
  //
  //     queue.add(newEntity);
  //   }
  //
  //   if (queue.isNotEmpty) {
  //     db.transaction(() async {
  //       await db.batch((b) {
  //         b.insertAllOnConflictUpdate(table, queue);
  //       });
  //     });
  //   }
  //
  //   return queue;
  // }

  @override
  $DataInstancesTable get table => db.dataInstances;
}
