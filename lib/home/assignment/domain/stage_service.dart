import 'package:d_sdk/database/tables/tables.dart';

abstract class StageService {
  Future<List<StageDefinitions>> fetchAssignmentType(String assignmentUid);

// Future<bool> isOpen(String assignmentUid);
//
// Future<AssignmentAccess> getAssignmentAccess(
//     String assignmentUid, String formTemplateUid);
//
// Future<bool> allowInstanceCreation(
//     String assignmentUid, String formTemplateUid);
//
// Future<bool> allowInstanceEdit(String assignmentUid, String formTemplateUid);
//
// Future<bool> allowInstanceDelete(
//     String assignmentUid, String formTemplateUid);
}