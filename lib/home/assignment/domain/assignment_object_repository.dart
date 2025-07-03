// import 'package:d_sdk/database/app_database.dart';
// import 'package:d_sdk/database/dbManager.dart';
// import 'package:d_sdk/database/shared/shared.dart';
// import 'package:datarunmobile/di/injection.dart';
// import 'package:drift/drift.dart';
//
// /// Repository for managing Enrollment objects with read/write operations.
// class AssignmentObjectRepository {
//   AssignmentObjectRepository(
//     String? uid,
//   ) : this.assignmentUid = uid;
//
//   // final TrackerDataManager _trackerDataManager;
//   final String? assignmentUid;
//   final AppDatabase _db = appLocator<DbManager>().db;
//
//   Future<void> updateObject(Assignment assignment) async {
//     await _db.assignmentsDao.updateObject(assignment);
//   }
//
//   Future<Assignment> getObject() async {
//     return _db.managers.assignments
//         .filter((f) => f.id(assignmentUid))
//         .getSingle();
//   }
//
//   Future<void> updateIfChanged<V>(
//       V? newValue,
//       V? Function(Assignment) propertyGetter,
//       Assignment Function(Assignment, V?) updater) async {
//     final obj = await getObject();
//     final currentValue = propertyGetter(obj);
//
//     if (currentValue != newValue) {
//       await updateObject(updater(obj, newValue));
//     }
//   }
//
//   /// Sets the organisation unit UID if changed.
//   Future<void> setOrganisationUnitUid(String? organisationUnitUid) async {
//     await updateIfChanged<String?>(
//       organisationUnitUid,
//       (e) => e.orgUnit,
//       (e, value) => _updateBuilder(e).copyWith(orgUnit: value),
//     );
//   }
//
//   Future<void> setEnrollmentDate(DateTime? enrollmentDate) async {
//     await updateIfChanged<DateTime?>(
//       enrollmentDate,
//       (e) => e.enrollmentDate,
//       (e, value) => _updateBuilder(e).enrollmentDate(value).build(),
//     );
//   }
//
//   Future<void> setIncidentDate(DateTime? incidentDate) async {
//     await updateIfChanged<DateTime?>(
//       incidentDate,
//       (e) => e.incidentDate,
//       (e, value) => _updateBuilder(e).incidentDate(value).build(),
//     );
//   }
//
//   Future<void> setCompletedDate(DateTime? completedDate) async {
//     await updateIfChanged<DateTime?>(
//       completedDate,
//       (e) => e.completedDate,
//       (e, value) => _updateBuilder(e).completedDate(value).build(),
//     );
//   }
//
//   Future<void> setStatus(AssignmentStatus status) async {
//     await updateIfChanged<AssignmentStatus>(
//       status,
//       (e) => e.progressStatus,
//       (enrollment, value) {
//         final completedDate =
//             value == AssignmentStatus.DONE ? DateTime.now() : null;
//         return _updateBuilder(enrollment).copyWith(
//             progressStatus: Value(value), completedDate: Value(completedDate));
//       },
//     );
//   }
//
//   // Future<void> setGeometry(Geometry? geometry) async {
//   //   GeometryHelper.validateGeometry(geometry);
//   //   await updateIfChanged<Geometry?>(
//   //     geometry,
//   //     (e) => e.geometry,
//   //     (e, value) => _updateBuilder(e).geometry(value).build(),
//   //   );
//   // }
//
//   /// Prepares an Enrollment.Builder with updated sync state and timestamps.
//   Assignment _updateBuilder(Assignment enrollment) {
//     final now = DateTime.now();
//     var state = enrollment.aggregatedSyncState;
//     state = state == SyncState.toPost ? state : SyncState.toUpdate;
//     return enrollment.toBuilder()
//       ..syncState = state
//       ..aggregatedSyncState = state
//       ..lastUpdated = now
//       ..lastUpdatedAtClient = now;
//   }
//
//   // @override
//   // void propagateState(Assignment assignment, HandleAction action) {
//   //   _trackerDataManager.propagateEnrollmentUpdate(assignment, action);
//   // }
//
//   // @override
//   Future<void> deleteObject(Assignment assignment) async {
//     await _db.assignmentsDao.deleteObject(assignment);
//     // await _trackerDataManager.deleteEnrollment(assignment);
//   }
// }
