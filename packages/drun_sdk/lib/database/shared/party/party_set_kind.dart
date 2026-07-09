enum PartySetKind {
  STATIC,
  ORG_TREE,
  TAG_FILTER,
  QUERY,
  ASSIGNMENT_SCOPE,
  EXTERNAL;

  static PartySetKind getType(String? valueType) {
    switch (valueType?.toLowerCase()) {
      case 'static':
        return PartySetKind.STATIC;
      case 'org_tree':
        return PartySetKind.ORG_TREE;
      case 'tag_filter':
        return PartySetKind.TAG_FILTER;
      case 'query':
        return PartySetKind.QUERY;
      case 'assignment_scope':
        return PartySetKind.ASSIGNMENT_SCOPE;
      case 'external':
        return PartySetKind.EXTERNAL;

      default:
        throw ArgumentError('Invalid value type: $valueType');
    }
  }
}
