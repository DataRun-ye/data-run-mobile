import 'package:d_sdk/database/shared/form_permission.dart';

extension FormPermissionChecks on List<FormPermission> {
  bool containsAny(Iterable<FormPermission> perms) =>
      this.toSet().intersection(perms.toSet()).isNotEmpty;

  bool get canViewSubmission => containsAny({
        FormPermission.VIEW_SUBMISSIONS,
        FormPermission.VIEW_SUBMISSIONS_FROM_USERS,
        FormPermission.EDIT_SUBMISSIONS,
        FormPermission.EDIT_SUBMISSIONS_FROM_USERS,
        FormPermission.APPROVE_SUBMISSIONS,
        FormPermission.DELETE_SUBMISSIONS,
        FormPermission.DELETE_SUBMISSIONS_FROM_USERS,
      });

  bool get canAdd => contains(FormPermission.ADD_SUBMISSIONS);

  bool get canApprove => contains(FormPermission.APPROVE_SUBMISSIONS);

  bool get canView => contains(FormPermission.VIEW_SUBMISSIONS_FROM_USERS);

  bool get canEdit => contains(FormPermission.EDIT_SUBMISSIONS);

  bool get canEditFromUsers =>
      contains(FormPermission.EDIT_SUBMISSIONS_FROM_USERS);

  bool get canDelete => contains(FormPermission.DELETE_SUBMISSIONS);

  bool get canDeleteFromUsers =>
      contains(FormPermission.DELETE_SUBMISSIONS_FROM_USERS);

  // bool get isCurrentlyValid {
  //   final now = DateTime.now();
  //   return (validFrom == null || validFrom!.isBefore(now)) &&
  //       (validTo   == null || validTo!.isAfter(now));
  // }
}
