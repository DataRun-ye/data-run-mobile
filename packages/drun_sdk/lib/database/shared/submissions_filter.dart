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
  final Set<InstanceSyncStatus> syncStates;
  final bool includeDeleted;
  final DateFilterBand? dateFilterBand;

  const SubmissionsFilter({
    required this.formId,
    this.assignmentId,
    this.searchTerm,
    this.includeDeleted = false,
    this.dateFilterBand,
    this.syncStates = const {},
  });

  SubmissionsFilter toggleDateBand(DateFilterBand? band) {
    return SubmissionsFilter(
      formId: formId,
      assignmentId: assignmentId,
      searchTerm: searchTerm,
      syncStates: syncStates,
      dateFilterBand: band,
      includeDeleted: includeDeleted,
    );
  }

  int get filterCount {
    final filters = [
      syncStates.isNotEmpty ? 1 : 0,
      dateFilterBand != null ? 1 : 0,
      includeDeleted ? 1 : 0,
    ];
    return filters.where((f) => f != 0).length;
  }

  SubmissionsFilter copyWith({
    String? formId,
    String? assignmentId,
    String? searchTerm,
    Set<InstanceSyncStatus>? syncStates,
    DateFilterBand? dateFilterBand,
    bool? includeDeleted,
  }) {
    return SubmissionsFilter(
      formId: formId ?? this.formId,
      assignmentId: assignmentId ?? this.assignmentId,
      searchTerm: searchTerm ?? this.searchTerm,
      syncStates: syncStates ?? this.syncStates,
      includeDeleted: includeDeleted ?? this.includeDeleted,
      dateFilterBand: dateFilterBand ?? this.dateFilterBand,
    );
  }

  @override
  List<Object?> get props => [
        formId,
        assignmentId,
        searchTerm,
        syncStates,
        dateFilterBand,
        includeDeleted,
      ];
}
