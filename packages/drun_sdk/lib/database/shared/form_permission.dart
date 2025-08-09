// @JsonEnum(fieldRename: FieldRename.none)
enum FormPermission {
  /**
   * the User can view his submissions
   */
  VIEW_SUBMISSIONS,
  /**
   * the User can view other users' submissions
   */
  VIEW_SUBMISSIONS_FROM_USERS,
  /**
   * the User can add new submissions
   */
  ADD_SUBMISSIONS,
  /**
   * the User edit his submission after submitting
   */
  EDIT_SUBMISSIONS,
  /**
   * The user can edit other users submissions
   */
  EDIT_SUBMISSIONS_FROM_USERS,
  /**
   * The user can approve other users submissions
   */
  APPROVE_SUBMISSIONS,
  /**
   * The user can delete his submissions after submitting
   */
  DELETE_SUBMISSIONS,
  /**
   * The user can Delete other users submissions
   */
  DELETE_SUBMISSIONS_FROM_USERS;

  static List<FormPermission> canViewPermissions() => [
        VIEW_SUBMISSIONS,
        VIEW_SUBMISSIONS_FROM_USERS,
        EDIT_SUBMISSIONS,
        EDIT_SUBMISSIONS_FROM_USERS,
        APPROVE_SUBMISSIONS,
        DELETE_SUBMISSIONS,
        DELETE_SUBMISSIONS_FROM_USERS
      ];

  bool canViewSubmission() {
    return canViewPermissions().contains(this);
  }

  static FormPermission? getType(String? value) {
    switch (value) {
      case 'VIEW_SUBMISSIONS':
        return VIEW_SUBMISSIONS;
      case 'VIEW_SUBMISSIONS_FROM_USERS':
        return VIEW_SUBMISSIONS_FROM_USERS;
      case 'ADD_SUBMISSIONS':
        return ADD_SUBMISSIONS;
      case 'EDIT_SUBMISSIONS':
        return EDIT_SUBMISSIONS;
      case 'EDIT_SUBMISSIONS_FROM_USERS':
        return EDIT_SUBMISSIONS_FROM_USERS;
      case 'APPROVE_SUBMISSIONS':
        return APPROVE_SUBMISSIONS;
      case 'DELETE_SUBMISSIONS':
        return DELETE_SUBMISSIONS;
      case 'DELETE_SUBMISSIONS_FROM_USERS':
        return DELETE_SUBMISSIONS_FROM_USERS;
      default:
        return null;
    }
  }
}
