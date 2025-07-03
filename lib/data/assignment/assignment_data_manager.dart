import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/tables/tables.dart';

abstract class AssignmentDataManager {
  Future<void> propagateEntityUpdate(EntityInstance? ei, HandleAction action);

  Future<void> propagateAssignmentUpdate(
      Assignment? assignment, HandleAction action);

  Future<void> propagateSubmissionUpdate(
      DataSubmissions? submission, HandleAction action);

  Future<void> deleteEntity(EntityInstance? tei);

  Future<void> deleteAssignment(Assignment? assignment);

  Future<void> deleteEvent(DataSubmissions? submission);
}

enum HandleAction { Insert, Update, Delete, NoAction }
