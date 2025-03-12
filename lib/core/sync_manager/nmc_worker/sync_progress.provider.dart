import 'package:d2_remote/modules/datarun_shared/sync/call/d2_progress.dart';
import 'package:datarunmobile/core/sync_manager/nmc_worker/work_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_progress.provider.g.dart';

@riverpod
class SyncProgress extends _$SyncProgress {
  @override
  WorkInfo build() {
    return WorkInfo();
  }

  void update(WorkInfo Function(WorkInfo state) progress) {
    state = progress.call(state);
  }

  void updateWorkInfoState(WorkInfoState workInfoState) {
    state = state.copyWith(state: workInfoState);
  }

  void updateMessage(String message) {
    state = state.copyWith(message: message);
  }

  void updateProgress(int progress) {
    state = state.copyWith(progress: progress);
  }

  void updateFinalResult(WorkInfoState state, String message) {
    this.state = this.state.copyWith(state: state, message: message);
  }
}
