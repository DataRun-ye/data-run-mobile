// import 'package:d_sdk/database/app_database.dart';
// import 'package:d_sdk/database/database.dart';
// import 'package:d_sdk/database/shared/shared.dart';
// import 'package:datarunmobile/data/assignment/data_state_propagator.dart';
// import 'package:datarunmobile/di/injection.dart';
//
// /// Propagates sync-state changes across entities, assignments, submissions, and relationships.
// class DataStatePropagatorImpl implements DataStatePropagator {
//   // final TrackedEntityInstanceStore _teiStore;
//   // final EnrollmentStore _enrollmentStore;
//   // final EventStore _eventStore;
//   // final RelationshipStore _relationshipStore;
//   // final RelationshipItemStore _relationshipItemStore;
//   // final RelationshipTypeStore _relationshipTypeStore;
//   // final ProgramOwnerStore _programOwnerStore;
//   final AppDatabase _db;
//
//   DataStatePropagatorImpl() : this._db = appLocator<DbManager>().db;
//
//   @override
//   Future<void> propagateTrackedEntityInstanceUpdate(EntityInstance? tei) async {
//     if (tei != null) {
//       await refreshTrackedEntityInstanceAggregatedSyncState(tei.id);
//       await _refreshTeiLastUpdated(tei.id);
//     }
//   }
//
//   @override
//   Future<void> propagateEnrollmentUpdate(Assignment? assignment) async {
//     if (assignment == null) return;
//     await refreshEnrollmentAggregatedSyncState(assignment.id);
//     await _refreshEnrollmentLastUpdated(assignment.id);
//
//     if (assignment.entityInstanceId == null) return;
//
//     final tei =
//     await _db.entityInstancesDao.getById(assignment.entityInstanceId!);
//     propagateTrackedEntityInstanceUpdate(tei);
//   }
//
//   @override
//   Future<void> propagateEventUpdate(StageSubmission? submission) async {
//     if (submission == null) return;
//     await refreshEventAggregatedSyncState(submission.id);
//     await _refreshEventLastUpdated(submission.id);
//
//     final assignmentUid = submission.assignment;
//     if (assignmentUid != null) {
//       final assignment = await _db.assignmentsDao.getById(assignmentUid);
//       propagateEnrollmentUpdate(assignment);
//     }
//   }
//
//   @override
//   Future<void> propagateTrackedEntityDataValueUpdate(
//       DataValue? dataValue) async {
//     if (dataValue == null) return;
//     _setEventSyncState(dataValue.submission, _getStateForUpdate);
//   }
//
//   //
//   // @override
//   // Future<void> propagateTrackedEntityAttributeUpdate(
//   //     TrackedEntityAttributeValue? attributeValue) {
//   //   if (attributeValue == null) return;
//   //   final teiUid = attributeValue.trackedEntityInstance;
//   //   if (teiUid == null) return;
//   //
//   //   final enrollments =
//   //       _enrollmentStore.selectByTrackedEntityInstanceAndAttribute(
//   //     teiUid,
//   //     attributeValue.trackedEntityAttribute,
//   //   );
//   //   for (var enr in enrollments) {
//   //     _enrollmentStore.setSyncState(enr.uid, _getStateForUpdate(enr.syncState));
//   //     _refreshEnrollmentAggregatedSyncState(enr.uid);
//   //     _refreshEnrollmentLastUpdated(enr.uid);
//   //   }
//   //   _setTeiSyncState(teiUid, _getStateForUpdate);
//   // }
//   //
//   // @override
//   // Future<void> propagateNoteCreation(Note? note) {
//   //   if (note == null) return;
//   //   if (note.noteType == NoteType.enrollment) {
//   //     _setEnrollmentSyncState(note.enrollmentUid, _getStateForUpdate);
//   //   } else if (note.noteType == NoteType.event) {
//   //     _setEventSyncState(note.eventUid, _getStateForUpdate);
//   //   }
//   // }
//   //
//   // @override
//   // Future<void> propagateRelationshipUpdate(Relationship? relationship) {
//   //   if (relationship == null) return;
//   //   final type = relationship.relationshipType;
//   //   final bidirectional = type != null &&
//   //       (_relationshipTypeStore.selectByUid(type)?.bidirectional ?? false);
//   //
//   //   _propagateRelationshipItem(relationship.from);
//   //   if (bidirectional) {
//   //     _propagateRelationshipItem(relationship.to);
//   //   }
//   // }
//   //
//   // @override
//   // Future<void> propagateOwnershipUpdate(ProgramOwner programOwner) {
//   //   final teiUid = programOwner.trackedEntityInstanceUid;
//   //   if (teiUid != null) {
//   //     _setTeiSyncState(teiUid, _getStateForUpdate);
//   //   }
//   // }
//   //
//   // Future<void> _propagateRelationshipItem(RelationshipItem? item) {
//   //   if (item == null) return;
//   //   if (item.hasTrackedEntityInstance) {
//   //     final tei = _teiStore.selectByUid(item.elementUid);
//   //     propagateTrackedEntityInstanceUpdate(tei);
//   //   } else if (item.hasEnrollment) {
//   //     final enr = _enrollmentStore.selectByUid(item.elementUid);
//   //     propagateEnrollmentUpdate(enr);
//   //   } else if (item.hasEvent) {
//   //     final evt = _eventStore.selectByUid(item.elementUid);
//   //     propagateEventUpdate(evt);
//   //   }
//   // }
//   //
//   // Future<void> _setTeiSyncState(
//   //     String teiUid, SubmissionStatus Function(SubmissionStatus?) getState) async {
//   //   final instance = _teiStore.selectByUid(teiUid);
//   //   if (instance == null) return;
//   //   final newState = getState(instance.syncState);
//   //   _teiStore.setSyncState(teiUid, newState);
//   //   propagateTrackedEntityInstanceUpdate(instance);
//   // }
//   //
//   // Future<void> _setEnrollmentSyncState(
//   //     String enrollmentUid, SubmissionStatus Function(SubmissionStatus?) getState) async {
//   //   final enrollment = _enrollmentStore.selectByUid(enrollmentUid);
//   //   if (enrollment == null) return;
//   //   final newState = getState(enrollment.syncState);
//   //   _enrollmentStore.setSyncState(enrollmentUid, newState);
//   //   propagateEnrollmentUpdate(enrollment);
//   // }
//
//   Future<void> _setEventSyncState(
//       String eventUid, SubmissionStatus Function(SubmissionStatus?) getState) async {
//     final event = _eventStore.selectByUid(eventUid);
//     if (event == null) return;
//     final newState = getState(event.syncState);
//     _eventStore.setSyncState(eventUid, newState);
//     propagateEventUpdate(event);
//   }
//
//   Future<void> _refreshEventLastUpdated(String eventUid) async {
//     final event = _eventStore.selectByUid(eventUid);
//     if (event == null) return;
//     final now = DateTime.now();
//     final updated = event.toBuilder()
//       ..lastUpdated = _maxDate(event.lastUpdated, now)
//       ..lastUpdatedAtClient = _maxDate(event.lastUpdatedAtClient, now);
//     _eventStore.update(updated.build());
//   }
//
//   Future<void> _refreshEnrollmentLastUpdated(String enrollmentUid) async {
//     final enrollment = _enrollmentStore.selectByUid(enrollmentUid);
//     if (enrollment == null) return;
//     final now = DateTime.now();
//     final updated = enrollment.toBuilder()
//       ..lastUpdated = _maxDate(enrollment.lastUpdated, now)
//       ..lastUpdatedAtClient = _maxDate(enrollment.lastUpdatedAtClient, now);
//     _enrollmentStore.update(updated.build());
//   }
//
//   Future<void> _refreshTeiLastUpdated(String teiUid) async {
//     final instance = _teiStore.selectByUid(teiUid);
//     if (instance == null) return;
//     final now = DateTime.now();
//     final updated = instance.toBuilder()
//       ..lastUpdated = _maxDate(instance.lastUpdated, now)
//       ..lastUpdatedAtClient = _maxDate(instance.lastUpdatedAtClient, now);
//     _teiStore.update(updated.build());
//   }
//
//   @override
//   Future<void> resetUploadingEnrollmentAndEventStates(String? teiUid) async {
//     if (teiUid == null) return;
//     final enrollments =
//     _enrollmentStore.selectWhere({'trackedEntityInstance': teiUid});
//     for (var enr in enrollments) {
//       if (enr.syncState == State.uploading) {
//         _enrollmentStore.setSyncState(enr.uid, State.toUpdate);
//         resetUploadingEventStates(enr.uid);
//       }
//     }
//   }
//
//   @override
//   Future<void> resetUploadingEventStates(String? enrollmentUid) async {
//     if (enrollmentUid == null) return;
//     final events = _eventStore.selectWhere({'enrollment': enrollmentUid});
//     for (var evt in events) {
//       if (evt.syncState == State.uploading) {
//         _eventStore.setSyncState(evt.uid, State.toUpdate);
//       }
//     }
//   }
//
//   DateTime? _maxDate(DateTime? existing, DateTime? today) {
//     if (existing == null) return today;
//     if (today == null || existing.isAfter(today)) return existing;
//     return today;
//   }
//
//   final SubmissionStatus Function(SubmissionStatus?) _getStateForUpdate =
//       (SubmissionStatus? existing) {
//     if (existing == State.toPost || existing == State.relationship) {
//       return existing;
//     }
//     return State.toUpdate;
//   };
//
//   @override
//   Future<void> refreshTrackedEntityInstanceAggregatedSyncState(
//       String teiUid) async {
//     final instance = _teiStore.selectByUid(teiUid);
//     if (instance == null) return;
//
//     final enrollmentStates = _enrollmentStore
//         .selectAggregatedSyncStateWhere({'trackedEntityInstance': teiUid});
//     final relStates =
//     _getRelationshipStates(RelationshipHelper.teiItem(teiUid));
//     final ownerStates = _programOwnerStore
//         .selectWhere({'trackedEntityInstance': teiUid})
//         .map((o) => o.syncState!)
//         .toList();
//
//     final agg = _computeAggregatedSyncState([
//       ...enrollmentStates,
//       ...relStates,
//       ...ownerStates,
//       instance.syncState!
//     ]);
//     _teiStore.setAggregatedSyncState(teiUid, agg);
//   }
//
//   @override
//   Future<void> refreshEnrollmentAggregatedSyncState(
//       String assignmentUid) async {
//     final assignment = await _db.assignmentsDao.getById(assignmentUid);
//     if (assignment == null) return;
//
//     final eventStates = (await _db.dataSubmissionsDao
//         .selectStatusByLevel(
//         assignmentUid, StatusAggregationLevel.assignment)
//         .get())
//         .where((s) => s.count > 0)
//         .map((s) => s.syncState);
//
//     final agg =
//     _computeAggregatedSyncState([...eventStates, assignment.syncState]);
//     await _db.assignmentsDao.updateObject(assignment.copyWith(syncState: agg));
//   }
//
//   @override
//   Future<void> refreshEventAggregatedSyncState(String eventUid) async {
//     final submission = await _db.stageSubmissionsDao.getById(eventUid);
//     if (submission == null) return;
//     // final relStates =
//     //     _getRelationshipStates(RelationshipHelper.eventItem(eventUid));
//     final agg = _computeAggregatedSyncState([submission.syncState]);
//     await _db.stageSubmissionsDao
//         .updateObject(submission.copyWith(syncState: agg));
//   }
//
//   @override
//   Future<void> refreshAggregatedSyncStates(DataStateUidHolder uidHolder) async {
//     await Future.wait(uidHolder.submissions.map((uid) {
//       return refreshEventAggregatedSyncState(uid);
//     }));
//     await Future.wait(uidHolder.assignments.map((uid) {
//       return refreshEnrollmentAggregatedSyncState(uid);
//     }));
//     await Future.wait(uidHolder.entities.map((uid) {
//       return refreshTrackedEntityInstanceAggregatedSyncState(uid);
//     }));
//   }
//
//   // List<State> _getRelationshipStates(RelationshipItem item) async {
//   //   final rels = _relationshipStore.getByItem(item);
//   //   return rels
//   //       .where((rel) {
//   //         final typeUid = rel.relationshipType;
//   //         final bidir = typeUid != null &&
//   //             (_relationshipTypeStore.selectByUid(typeUid)?.bidirectional ??
//   //                 false);
//   //         if (bidir) return true;
//   //         final fromItem = _relationshipItemStore.getForRelationshipAndType(
//   //             rel.uid!, RelationshipConstraintType.from);
//   //         return fromItem?.elementUid == item.elementUid;
//   //       })
//   //       .map((r) => r.syncState!)
//   //       .toList();
//   // }
//
//   @override
//   DataStateUidHolder getRelatedUids(
//       List<String> teiUids,
//       List<String> enrollmentUids,
//       List<String> eventUids,
//       List<String> relationshipUids,
//       ) {
//     final enrollmentsFromEvents = _eventStore
//         .selectByUids(eventUids)
//         .mapNotNull((e) => e.enrollment)
//         .toList();
//
//     final enrollments = _enrollmentStore
//         .selectByUids([...enrollmentUids, ...enrollmentsFromEvents]);
//     final teIsFromEnrollments =
//     enrollments.mapNotNull((e) => e.trackedEntityInstance).toList();
//
//     final relationshipItems = relationshipUids
//         .expand((uid) => _relationshipItemStore.getForRelationshipUid(uid))
//         .toList();
//
//     return DataStateUidHolder(
//       submissions: [
//         ...eventUids,
//         ...relationshipItems
//             .where((it) => it.hasEvent)
//             .map((it) => it.elementUid),
//       ],
//       assignments: [
//         ...enrollmentUids,
//         ...enrollmentsFromEvents,
//         ...relationshipItems
//             .where((it) => it.hasEnrollment)
//             .map((it) => it.elementUid),
//       ],
//       entities: [
//         ...teiUids,
//         ...teIsFromEnrollments,
//         ...relationshipItems
//             .where((it) => it.hasTrackedEntityInstance)
//             .map((it) => it.elementUid),
//       ],
//     );
//   }
//
//   SubmissionStatus _computeAggregatedSyncState(List<SubmissionStatus> states) {
//     if (states.contains(SubmissionStatus.syncFailed))
//       return SubmissionStatus.syncFailed;
//     if (states.contains(SubmissionStatus.draft)) return SubmissionStatus.draft;
//     if (states.contains(SubmissionStatus.finalized))
//       return SubmissionStatus.finalized;
//     return SubmissionStatus.synced;
//   }
// }
