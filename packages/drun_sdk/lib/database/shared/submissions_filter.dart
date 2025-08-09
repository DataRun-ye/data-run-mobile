import 'package:d_sdk/database/shared/submission_status.dart';
import 'package:equatable/equatable.dart';

enum DateFilterBand {
  today,
  lastThreeDays,
  thisWeek,
  thisMonth,
  lastThreeMonths,
  thisYear
}

class SubmissionsFilter with EquatableMixin {
  /// current sort column
  final String formId;
  final String? assignmentId;

  //
  final String? searchTerm;
  final InstanceSyncStatus? syncState;
  final bool includeDeleted;
  final DateFilterBand? dateFilterBand;

  const SubmissionsFilter({
    required this.formId,
    this.assignmentId,
    this.searchTerm,
    this.includeDeleted = false,
    this.dateFilterBand,
    this.syncState,
  });

  SubmissionsFilter toggleSyncStatus(InstanceSyncStatus? status) {
    return SubmissionsFilter(
      formId: formId,
      assignmentId: assignmentId,
      searchTerm: searchTerm,
      dateFilterBand: dateFilterBand,
      includeDeleted: includeDeleted,
      syncState: status,
    );
  }

  SubmissionsFilter toggleDateBand(DateFilterBand? band) {
    return SubmissionsFilter(
      formId: formId,
      assignmentId: assignmentId,
      searchTerm: searchTerm,
      syncState: syncState,
      dateFilterBand: band,
      includeDeleted: includeDeleted,
    );
  }

  int get filterCount {
    final filters = [
      syncState != null ? 1 : 0,
      dateFilterBand != null ? 1 : 0,
      includeDeleted ? 1 : 0,
    ];
    return filters.where((f) => f != 0).length;
  }

  SubmissionsFilter copyWith({
    String? formId,
    String? assignmentId,
    String? searchTerm,
    InstanceSyncStatus? syncState,
    DateFilterBand? dateFilterBand,
    bool? includeDeleted,
  }) {
    return SubmissionsFilter(
      formId: formId ?? this.formId,
      assignmentId: assignmentId ?? this.assignmentId,
      searchTerm: searchTerm ?? this.searchTerm,
      syncState: syncState ?? this.syncState,
      includeDeleted: includeDeleted ?? this.includeDeleted,
      dateFilterBand: dateFilterBand ?? this.dateFilterBand,
    );
  }

  @override
  List<Object?> get props => [
        formId,
        assignmentId,
        searchTerm,
        syncState,
        dateFilterBand,
        includeDeleted,
      ];
}
