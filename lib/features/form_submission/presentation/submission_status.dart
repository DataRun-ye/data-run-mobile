enum EntryStatus {
  ACTIVE,
  COMPLETED;

  static EntryStatus getEnumValue(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
        return ACTIVE;
      case 'completed':
        return COMPLETED;
      default:
        return ACTIVE;
    }
  }
}
