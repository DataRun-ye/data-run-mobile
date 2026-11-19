enum AssignmentStatus {
  PLANNED,
  // @Deprecated("use planned instead")
  NOT_STARTED,
  IN_PROGRESS, // Active
  DONE, // Completed
  RESCHEDULED,
  Expired,
  MERGED,
  REASSIGNED,
  CANCELLED;

  bool isPlanned() {
    return this == AssignmentStatus.PLANNED ||
        this == AssignmentStatus.NOT_STARTED;
  }

  // @Deprecated("use isPlanned instead")
  bool isNotStarted() {
    return isPlanned();
  }

  /// The statuses a form's Progress field offers: the server's statuses
  /// (FlowStatus) except PLANNED, the state before any work. Forms show their
  /// detail sections by these names, e.g. the ITN form's `completion_details`
  /// for DONE. EXPIRED is not a server status, so a form cannot set it.
  static const List<AssignmentStatus> formProgressStatuses = [
    IN_PROGRESS,
    DONE,
    RESCHEDULED,
    MERGED,
    REASSIGNED,
    CANCELLED,
  ];

  static AssignmentStatus? getType(String? value) {
    switch (value?.toLowerCase()) {
      case 'planned':
        return AssignmentStatus.PLANNED;
      case 'expired':
        return AssignmentStatus.Expired;
      case 'not_started':
        return AssignmentStatus.PLANNED;
      case 'in_progress':
        return AssignmentStatus.IN_PROGRESS;
      case 'done':
        return AssignmentStatus.DONE;
      case 'rescheduled':
        return AssignmentStatus.RESCHEDULED;
      case 'merged':
        return AssignmentStatus.MERGED;
      case 'reassigned':
        return AssignmentStatus.REASSIGNED;
      case 'cancelled':
        return AssignmentStatus.CANCELLED;
      default:
        return null;
    }
  }
}
