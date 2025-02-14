import 'package:datarun/core/common/state.dart';
import 'package:equatable/equatable.dart';

class HomeItemModel with EquatableMixin {
  HomeItemModel(
      {this.uid = '',
      this.title = '',
      this.type,
      // this.programType = '',

      /// Count of activities
      this.count = 0,
      this.description,
      this.state = SyncStatus.SYNCED,
      this.accessDataWrite = true,
      this.dirty = false,
      this.hasOverdueEvent = false,
      this.filtersAreActive = false,
      this.downloadState = ProjectDownloadState.NONE,
      this.downloadActive = false});

  final String uid;
  final String title;

  /// Count of sub items, here it's a count for activities inside
  /// an item
  final int count;
  final String? type;

  // final String programType;
  final String? description;
  final bool accessDataWrite;

  final SyncStatus state;
  final bool dirty;
  final bool hasOverdueEvent;
  final bool filtersAreActive;

  /// Syncing Status, is it dirty and needs syncing...
  final ProjectDownloadState downloadState;

  /// the Item is currently downloading or syncing.
  final bool downloadActive; //: Boolean = false

  bool translucent() {
    return (filtersAreActive && count == 0) ||
        downloadState == ProjectDownloadState.DOWNLOADING;
  }

  String countDescription() => '$count $type';

  bool isDownloading() =>
      downloadActive || downloadState == ProjectDownloadState.DOWNLOADING;

  double getAlphaValue() => isDownloading() ? 0.5 : 1;

  HomeItemModel copyWith(
          {final String? uid,
          String? title,
          int? count,
          String? type,
          String? typeName,
          // String? programType,
          String? description,
          bool? onlyEnrollOnce,
          bool? accessDataWrite,
          SyncStatus? state,
          bool? dirty,
          bool? hasOverdueEvent,
          bool? filtersAreActive,
          ProjectDownloadState? downloadState,
          bool? downloadActive,
          bool? hasShownCompleteSyncAnimation}) =>
      HomeItemModel(
          uid: uid ?? this.uid,
          title: title ?? this.title,
          count: count ?? this.count,
          type: type ?? this.type,
          // programType: programType ?? this.programType,
          description: description ?? this.description,
          accessDataWrite: accessDataWrite ?? this.accessDataWrite,
          dirty: dirty ?? this.dirty,
          state: state ?? this.state,
          hasOverdueEvent: hasOverdueEvent ?? this.hasOverdueEvent,
          filtersAreActive: filtersAreActive ?? this.filtersAreActive,
          downloadState: downloadState ?? this.downloadState,
          downloadActive: downloadActive ?? this.downloadActive);

  @override
  List<Object?> get props => [
        uid,
        title,
        count,
        type,
        // programType,
        description,
        accessDataWrite,
        dirty,
        state,
        hasOverdueEvent,
        filtersAreActive,
        downloadState,
        downloadActive
      ];
}

enum ProjectDownloadState { DOWNLOADING, DOWNLOADED, ERROR, NONE }
