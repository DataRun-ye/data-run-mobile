import 'package:d_sdk/core/sync/d2_progress_status.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

/// data class
class SyncStatusData with EquatableMixin {
  SyncStatusData(
      {bool? running,
      bool? downloadingMedia,
      IMap<String, D2ProgressStatus>? programSyncStatusMap})
      : running = running ?? false,
        downloadingMedia = downloadingMedia ?? false,
        programSyncStatusMap =
            programSyncStatusMap ?? IMap<String, D2ProgressStatus>();
  final bool running;
  final bool downloadingMedia;
  final IMap<String, D2ProgressStatus> programSyncStatusMap; //:  = emptyMap()

  SyncStatusData copyWith(
      {bool? running,
      bool? downloadingMedia,
      Map<String, D2ProgressStatus>? programSyncStatusMap}) {
    return SyncStatusData(
        running: running ?? this.running,
        downloadingMedia: downloadingMedia ?? this.downloadingMedia,
        programSyncStatusMap:
            IMap.orNull(programSyncStatusMap) ?? this.programSyncStatusMap);
  }

  bool isProgramDownloading(String uid) {
    return programSyncStatusMap.isNotEmpty &&
        programSyncStatusMap[uid]?.isComplete == false;
  }

  bool hasDownloadError(String uid) {
    return programSyncStatusMap.isNotEmpty &&
        programSyncStatusMap[uid]?.syncStatus == D2ProgressSyncStatus.ERROR;
  }

  bool wasProgramDownloading(SyncStatusData? lastStatus, String uid) {
    return lastStatus?.programSyncStatusMap.get(uid)?.isComplete == false &&
        programSyncStatusMap[uid]?.isComplete == true;
  }

  @override
  List<Object?> get props => [running, downloadingMedia, programSyncStatusMap];
}
