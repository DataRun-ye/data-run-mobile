enum EntityScope {
  Assigned,
  Managed;

  bool isAssigned() => this == EntityScope.Assigned;

  bool isManaged() => this == EntityScope.Managed;

  static EntityScope? getType(String? value) {
    switch (value?.toLowerCase()) {
      case 'assigned':
        return EntityScope.Assigned;
      case 'managed':
        return EntityScope.Managed;
      default:
        return null;
    }
  }
}
