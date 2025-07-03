import 'package:built_collection/built_collection.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:equatable/equatable.dart';

abstract class DataStatePropagator {
  Future<void> propagateTrackedEntityInstanceUpdate(EntityInstance? ei);

  Future<void> propagateEnrollmentUpdate(Assignment? enrollment);

  Future<void> propagateEventUpdate(DataSubmissions? event);

  Future<void> propagateTrackedEntityDataValueUpdate(DataValue? dataValue);

  // Future<void> propagateTrackedEntityAttributeUpdate(
  //     TrackedEntityAttributeValue? trackedEntityAttributeValue);

  // Future<void> propagateNoteCreation(Note? note);

  // Future<void> propagateRelationshipUpdate(Relationship? relationship);

  // Future<void> propagateOwnershipUpdate(ProgramOwner programOwner);

  Future<void> resetUploadingEnrollmentAndEventStates(
      String? trackedEntityInstanceUid);

  Future<void> resetUploadingEventStates(String? enrollmentUid);

  Future<void> refreshTrackedEntityInstanceAggregatedSyncState(
      String trackedEntityInstanceUid);

  Future<void> refreshEnrollmentAggregatedSyncState(String enrollmentUid);

  Future<void> refreshEventAggregatedSyncState(String eventUid);

  Future<void> refreshAggregatedSyncStates(DataStateUidHolder uidHolder);

  DataStateUidHolder getRelatedUids(
    List<String> trackedEntityInstanceUids,
    List<String> enrollmentUids,
    List<String> eventUids,
    List<String> relationshipUids,
  );
}

class DataStateUidHolder with EquatableMixin {
  DataStateUidHolder(
      {Iterable<String> entities = const [],
      Iterable<String> assignments = const [],
      Iterable<String> submissions = const []})
      : this.entities = entities.toBuiltList(),
        this.assignments = assignments.toBuiltList(),
        this.submissions = submissions.toBuiltList();

  final BuiltList<String> entities;
  final BuiltList<String> assignments;
  final BuiltList<String> submissions;

  @override
  List<Object?> get props => [entities, assignments, submissions];
}
