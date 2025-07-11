import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/assignment_status.dart';
import 'package:d_sdk/database/shared/validation_strategy.dart';

abstract class SubmissionCaptureRepository {
  Future<bool> isAssignmentOpen();

  Future<bool> isAssignmentCancelled();

  Future<bool> isSubmissionEditable(String eventUid);

  Stream<String> programStageName();

  Stream<OrgUnit> orgUnit();

  Future<bool> completeEvent();

  Future<bool> deleteEvent();

  Future<bool> updateEventStatus(AssignmentStatus status);

  Future<bool> rescheduleEvent(DateTime newDate);

  Stream<String> programStage();

  Future<bool> getAccessDataWrite();

  Stream<AssignmentStatus> eventStatus();

  Future<bool> canReOpenEvent();

  Stream<bool> isCompletedEventExpired(String eventUid);

  Stream<bool> eventIntegrityCheck();

  Future<int> getNoteCount();

  Future<bool> showCompletionPercentage();

  Future<bool> hasAnalytics();

  Future<bool> hasRelationships();

  Future<ValidationStrategy> validationStrategy();

  Future<String?> getEnrollmentUid();

  Future<String?> getTeiUid();
}
