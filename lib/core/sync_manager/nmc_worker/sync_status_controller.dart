import 'package:d2_remote/modules/datarun_shared/sync/call/d2_progress_status.dart';
import 'package:datarunmobile/core/sync_manager/nmc_worker/sync_status_data.dart';
import 'package:datarunmobile/utils/mass_utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_status_controller.g.dart';

@Riverpod(keepAlive: true)
class SyncStatusControllerInstance extends _$SyncStatusControllerInstance {
  @override
  SyncStatusController build() {
    return SyncStatusController();
  }

  void initDownloadProcess(IMap<String, D2ProgressStatus> programDownload) {
    state = state.copyWith(
        progressStatusMap: programDownload,
        syncStatusData: SyncStatusData(
            running: true,
            downloadingMedia: false,
            programSyncStatusMap: programDownload));
  }

  void updateDownloadProcess(IMap<String, D2ProgressStatus> programDownload) {
    final progressStatusMap = state.progressStatusMap.addAll(programDownload);
    state = state.copyWith(
        progressStatusMap: progressStatusMap,
        syncStatusData: SyncStatusData(
            running: true,
            downloadingMedia: false,
            programSyncStatusMap: progressStatusMap));
  }

  void finishSync() {
    state = state.copyWith(
        syncStatusData: state.syncStatusData
            .copyWith(running: false, downloadingMedia: false));
  }

  void onNetworkUnavailable() {
    final progressStatusMap =
        IMap.fromEntries(state.progressStatusMap.entries.map((entry) {
      if (entry.value.isComplete) {
        return MapEntry(entry.key, entry.value);
      } else {
        return MapEntry(
            entry.key,
            entry.value.copyWith(
                message: L('networkUnavailable'),
                isComplete: true,
                syncStatus: D2ProgressSyncStatus.ERROR));
      }
    }));
    state = state.copyWith(
        progressStatusMap: progressStatusMap,
        syncStatusData: SyncStatusData(
            running: true,
            downloadingMedia: false,
            programSyncStatusMap: progressStatusMap));
  }

  void finishDownloadingEvents(List<String> eventProgramUids) {
    final progressStatusMap =
        IMap.fromEntries(state.progressStatusMap.entries.map((entry) {
      if (!eventProgramUids.contains(entry.key) || entry.value.isComplete) {
        return MapEntry(entry.key, entry.value);
      } else {
        return MapEntry(
            entry.key,
            entry.value.copyWith(
                isComplete: true, syncStatus: D2ProgressSyncStatus.ERROR));
      }
    }));
    state = state.copyWith(
        progressStatusMap: progressStatusMap,
        syncStatusData: SyncStatusData(
            running: true,
            downloadingMedia: false,
            programSyncStatusMap: progressStatusMap));
  }

  void finishDownloadingTracker(List<String> trackerProgramUids) {
    final progressStatusMap =
        IMap.fromEntries(state.progressStatusMap.entries.map((entry) {
      if (!trackerProgramUids.contains(entry.key) || entry.value.isComplete) {
        return MapEntry(entry.key, entry.value);
      } else {
        return MapEntry(
            entry.key,
            entry.value.copyWith(
                isComplete: true, syncStatus: D2ProgressSyncStatus.ERROR));
      }
    }));

    state = state.copyWith(
        progressStatusMap: progressStatusMap,
        syncStatusData: SyncStatusData(
            running: true,
            downloadingMedia: false,
            programSyncStatusMap: progressStatusMap));
  }

  void updateSingleProgramToSuccess(String programUid) {
    final progressStatusMap =
        IMap.fromEntries(state.progressStatusMap.entries.map((entry) {
      if (programUid != entry.key) {
        return entry;
      } else {
        return MapEntry(
            entry.key,
            entry.value.copyWith(
                isComplete: true, syncStatus: D2ProgressSyncStatus.SUCCESS));
      }
    }));

    state = state.copyWith(
        progressStatusMap: progressStatusMap,
        syncStatusData: SyncStatusData(
            running: false,
            downloadingMedia: false,
            programSyncStatusMap: progressStatusMap));
  }

  void initDownloadMedia() {
    state = state.copyWith(
        syncStatusData: state.syncStatusData
            .copyWith(running: true, downloadingMedia: true));
  }
}

class SyncStatusController with EquatableMixin {
  SyncStatusController(
      {IMap<String, D2ProgressStatus>? progressStatusMap,
      SyncStatusData? syncStatusData})
      : progressStatusMap = IMap<String, D2ProgressStatus>(),
        syncStatusData = syncStatusData ??
            SyncStatusData(
                running: false,
                downloadingMedia: false,
                programSyncStatusMap:
                    IMap.orNull(progressStatusMap?.unlock) ?? IMap());

  final IMap<String, D2ProgressStatus> progressStatusMap;

  final SyncStatusData syncStatusData;

  SyncStatusController copyWith(
      {IMap<String, D2ProgressStatus>? progressStatusMap,
      SyncStatusData? syncStatusData}) {
    return SyncStatusController(
        progressStatusMap:
            IMap.orNull(progressStatusMap?.unlock) ?? this.progressStatusMap,
        syncStatusData: syncStatusData ?? this.syncStatusData);
  }

  @override
  List<Object?> get props => [syncStatusData];
}
