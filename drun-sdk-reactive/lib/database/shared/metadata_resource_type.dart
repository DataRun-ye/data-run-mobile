enum MetadataResourceType {
  DataFormSubmission,
  Activity,
  Team,
  User,
  OrgUnit,
  Assignment;

  static MetadataResourceType getType(String? valueType) {
    switch (valueType?.toLowerCase()) {
      case 'dataformsubmission':
        return MetadataResourceType.DataFormSubmission;
      case 'activity':
        return MetadataResourceType.Activity;
      case 'team':
        return MetadataResourceType.Team;
      case 'orgunit':
        return MetadataResourceType.OrgUnit;
      case 'assignment':
        return MetadataResourceType.Assignment;
      case 'user':
        return MetadataResourceType.User;

      default:
        throw ArgumentError('Invalid value type: $valueType');
    }
  }
}
