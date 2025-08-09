import 'package:d_sdk/core/common/standard_extensions.dart';
import 'package:equatable/equatable.dart';

/// Data class
class D2ProgressStatus with EquatableMixin {
  const D2ProgressStatus(
      {this.isComplete = false, this.syncStatus, this.message});

  final bool isComplete;
  final D2ProgressSyncStatus? syncStatus;

  // NMC
  final String? message;

  D2ProgressStatus addSyncStatus(D2ProgressSyncStatus syncStatus,
      {String? message}) {
    final D2ProgressSyncStatus newStatus =
        when<bool, D2ProgressSyncStatus>(true, {
      this.syncStatus == null: () => syncStatus,
      this.syncStatus == D2ProgressSyncStatus.SUCCESS &&
              syncStatus == D2ProgressSyncStatus.SUCCESS:
          () => D2ProgressSyncStatus.SUCCESS,
      this.syncStatus == D2ProgressSyncStatus.ERROR: () =>
          D2ProgressSyncStatus.ERROR,
    }).orElse(() => D2ProgressSyncStatus.PARTIAL_ERROR);

    return copyWith(syncStatus: newStatus);
  }

  D2ProgressStatus copyWith(
      {bool? isComplete, D2ProgressSyncStatus? syncStatus, String? message}) {
    return D2ProgressStatus(
      isComplete: isComplete ?? this.isComplete,
      syncStatus: syncStatus ?? this.syncStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [isComplete, syncStatus, message];
}

enum D2ProgressSyncStatus { SUCCESS, ERROR, PARTIAL_ERROR }

extension ToD2ProgressSyncStatusExtension on String? {
  D2ProgressSyncStatus? get toD2ProgressSyncStatus {
    try {
      return D2ProgressSyncStatus.values.byName(this ?? '');
      // return D2ProgressSyncStatus.values.firstWhere(
      //     (status) => status.name == this,
      //     orElse: throw ArgumentError(
      //         'The D2ProgressSyncStatus $this does not match any D2ProgressSyncStatus'));
    } catch (e) {
      return null;
    }
  }
}
