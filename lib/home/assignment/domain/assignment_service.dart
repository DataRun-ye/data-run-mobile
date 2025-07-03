import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:datarunmobile/home/assignment/domain/model/assignment_access.dart';

abstract class AssignmentService {
  Future<AssignmentModel> fetchById(String id);

  Future<bool> isOpen(String assignmentUid);

  Future<AssignmentAccess> getAssignmentAccess(
      String assignmentUid, String formTemplateUid);

  Future<bool> allowInstanceCreation(
      String assignmentUid, String formTemplateUid);

  Future<bool> allowInstanceEdit(String assignmentUid, String formTemplateUid);

  Future<bool> allowInstanceDelete(
      String assignmentUid, String formTemplateUid);
}
