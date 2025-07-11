import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/core/common/state.dart';

typedef SubmissionFilterPredicate = bool Function(DataInstance);

class SubmissionListUtil {
  /// returns entities by a specified State, and if not specified
  /// returns all entities
  static SyncStatus? getSyncStatus(DataInstance? submission) {
    return switch (submission) {
      var s? when s.syncState.isSynced && !s.isToUpdate => SyncStatus.SYNCED,
      var s? when s.syncState.isSyncFailed == true => SyncStatus.ERROR,
      var s? when s.syncState.isFinalized && !s.isToUpdate =>
        SyncStatus.TO_POST,
      var s? when !s.syncState.isFinalized && s.isToUpdate =>
        SyncStatus.TO_UPDATE,
      _ => null,
    };
  }
//
// static SubmissionFilterPredicate getFilterPredicate(SyncStatus? state) {
//   final predicate = switch (state) {
//     == SyncStatus.TO_UPDATE => (t) => !t.isFinal && t.synced == false,
//     == SyncStatus.TO_POST => (t) => !t.isFinal && t.synced == false,
//     == SyncStatus.ERROR => (t) =>
//         t.syncFailed == true && t.dirty == true && t.synced == false,
//     == SyncStatus.SYNCED => (t) => t.synced == true,
//     _ => (t) => true,
//   };
//   return predicate;
// }
//
// static Iterable<DataInstance> filterByState(
//     Iterable<DataInstance> submissions,
//     {SyncStatus? state,
//     String sortBy = 'name'}) {
//   final entities = switch (state) {
//     == SyncStatus.TO_UPDATE => filterToUpdate(submissions),
//     == SyncStatus.TO_POST => filterToPost(submissions),
//     == SyncStatus.ERROR => filterWithSyncErrorState(submissions),
//     == SyncStatus.SYNCED => filterWithSyncedState(submissions),
//     _ => submissions,
//   };
//   entities.toList().sort((a, b) => (b.finishedEntryTime ??
//           b.startEntryTime ??
//           b.name ??
//           '')
//       .compareTo(a.finishedEntryTime ?? a.startEntryTime ?? a.name ?? ''));
//   return entities;
// }
//
// static Iterable<DataInstance> filterToUpdate(
//     Iterable<DataInstance> submissions) {
//   return submissions.where((t) => !t.isFinal);
// }
//
// static Iterable<DataInstance> filterToPost(
//     Iterable<DataInstance> submissions) {
//   return submissions.where((t) => t.isFinal && t.synced == false);
// }
//
// static Iterable<DataInstance> filterWithSyncErrorState(
//     Iterable<DataInstance> submissions) {
//   return submissions.where((t) => t.syncFailed == true && t.dirty == true);
// }
//
// static Iterable<DataInstance> filterWithSyncedState(
//     Iterable<DataInstance> submissions) {
//   return submissions.where((t) => t.synced == true);
// }
}
