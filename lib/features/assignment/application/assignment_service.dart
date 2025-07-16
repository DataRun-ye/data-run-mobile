import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:d_sdk/database/shared/assignment_status.dart';

abstract class AssignmentService {
  Future<AssignmentModel> fetchById(String id);

  Future<bool> isOpen(String assignmentUid);

  Future<AssignmentForm?> getAssignmentAccessForForm(
      String assignmentUid, String formTemplateUid);

  Future<bool> allowInstanceCreation(
      String assignmentUid, String formTemplateUid);

  Future<bool> allowInstanceEdit(String assignmentUid, String formTemplateUid);

  Future<bool> allowInstanceDelete(
      String assignmentUid, String formTemplateUid);

  // nmc
  Future<void> updateAssignmentStatus(
      AssignmentStatus? progressStatus, String assignmentId);
}
