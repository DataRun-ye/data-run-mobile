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

  bool isActive() => isActiveStatuses().contains(this);

  static List<AssignmentStatus> isActiveStatuses() {
    return [
      PLANNED,
      NOT_STARTED,
      IN_PROGRESS, // Active
      RESCHEDULED,
      MERGED,
      REASSIGNED,
    ];
  }

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
