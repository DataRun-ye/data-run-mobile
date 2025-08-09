enum AssignmentStatus {
  PLANNED,
  // @Deprecated("use planned instead")
  NOT_STARTED,
  IN_PROGRESS, // Active
  DONE, // Completed
  RESCHEDULED,
  MERGED,
  REASSIGNED,
  CANCELLED;

  bool isDone() {
    return this == AssignmentStatus.DONE;
  }

  bool isInProgress() {
    return this == AssignmentStatus.IN_PROGRESS;
  }

  bool isPlanned() {
    return this == AssignmentStatus.PLANNED ||
        this == AssignmentStatus.NOT_STARTED;
  }

  // @Deprecated("use isPlanned instead")
  bool isNotStarted() {
    return isPlanned();
  }

  bool isRescheduled() {
    return this == AssignmentStatus.RESCHEDULED;
  }

  bool isMerged() {
    return this == AssignmentStatus.MERGED;
  }

  bool isReassigned() {
    return this == AssignmentStatus.REASSIGNED;
  }

  bool isCancelled() {
    return this == AssignmentStatus.CANCELLED;
  }

  bool isActive() => isActiveStatuses().contains(this);

  bool isCompleted() => isCompletedStatuses().contains(this);

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

  static List<AssignmentStatus> isCompletedStatuses() {
    return [
      DONE, // Completed
      CANCELLED
    ];
  }

  // static AssignmentStatus? fromString(String? status) {
  //   return AssignmentStatus.values
  //       .firstOrNullWhere((e) => e.toString().split('.').last == status);
  // }

  static AssignmentStatus? getType(String? value) {
    switch (value?.toLowerCase()) {
      case 'planned':
        return AssignmentStatus.PLANNED;
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
