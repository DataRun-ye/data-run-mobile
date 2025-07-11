// import 'package:d_sdk/database/app_database.dart';
// import 'package:d_sdk/database/database.dart';
// import 'package:d_sdk/database/shared/assignment_status.dart';
// import 'package:d_sdk/database/shared/validation_strategy.dart';
// import 'package:datarunmobile/di/injection.dart';
// import 'package:datarunmobile/home/repeat_instance/domain/repositories/submission_capture_repository.dart';
//
// /// Implementation of [EventCaptureRepository] using D2 SDK.
// class SubmissionCaptureRepositoryImpl implements SubmissionCaptureRepository {
//   SubmissionCaptureRepositoryImpl(this._instanceUid);
//
//   late final String _instanceUid;
//   final _db = appLocator<DbManager>().db;
//
//   Future<DataInstance> _getCurrentSubmission() async {
//     return _db.managers.dataInstances
//         .filter((f) => f.id(_instanceUid))
//         .getSingle();
//   }
//
//   @override
//   Future<bool> isAssignmentOpen() async {
//     final event = await _getCurrentSubmission();
//     final enrollmentUid = event.assignment;
//     if (enrollmentUid == null) return true;
//     return await _db.assignmentsDao.isOpen(enrollmentUid);
//   }
//
//   @override
//   Future<bool> isAssignmentCancelled() async {
//     final event = await _getCurrentSubmission();
//     final enrollmentUid = event.enrollment;
//     if (enrollmentUid == null) return false;
//     final enrollment =
//         await _db.enrollmentModule.enrollments().byUid(enrollmentUid).get();
//     return enrollment?.status == EnrollmentStatus.cancelled;
//   }
//
//   @override
//   Future<bool> isSubmissionEditable(String eventUid) {
//     return _db.eventModule.eventService().isEditable(eventUid);
//   }
//
//   @override
//   Stream<String> programStageName() => Stream.fromFuture(_getCurrentSubmission()
//       .then(
//           (e) => _db.programModule.programStages().byUid(e.programStage).get())
//       .then((stage) => stage.displayName));
//
//   @override
//   Stream<OrganisationUnit> orgUnit() => Stream.fromFuture(_getCurrentSubmission()
//       .then((e) => _db.organisationUnitModule
//           .organisationUnits()
//           .byUid(e.organisationUnit)
//           .get()));
//
//   @override
//   Future<bool> completeEvent() async {
//     try {
//       await _db.eventModule
//           .events()
//           .byUid(_instanceUid)
//           .setStatus(EventStatus.completed);
//       return true;
//     } catch (_) {
//       return false;
//     }
//   }
//
//   @override
//   Future<bool> deleteEvent() async {
//     await _db.eventModule.events().byUid(_instanceUid).delete();
//     return true;
//   }
//
//   @override
//   Future<bool> updateEventStatus(EventStatus status) async {
//     await _db.eventModule.events().byUid(_instanceUid).setStatus(status);
//     return true;
//   }
//
//   @override
//   Future<bool> rescheduleEvent(DateTime newDate) async {
//     await _db.eventModule.events().byUid(_instanceUid).setDueDate(newDate);
//     await _db.eventModule
//         .events()
//         .byUid(_instanceUid)
//         .setStatus(EventStatus.scheduled);
//     return true;
//   }
//
//   @override
//   Stream<String> programStage() => Stream.value(_instanceUid)
//       .asyncMap((_) => _getCurrentSubmission().then((e) => e.programStage));
//
//   @override
//   Future<bool> getAccessDataWrite() async {
//     return await _db.eventModule
//         .eventService()
//         .hasDataWriteAccess(_instanceUid);
//   }
//
//   @override
//   Stream<EventStatus> eventStatus() =>
//       Stream.fromFuture(_getCurrentSubmission().then((e) => e.status));
//
//   @override
//   Future<bool> canReOpenEvent() async {
//     return await _db.userModule
//         .authorities()
//         .byName(Authority.uncompleteEvent, Authority.all)
//         .exists();
//   }
//
//   @override
//   Stream<bool> isCompletedEventExpired(String eventUid) {
//     return _db.eventModule.eventService().getEditableStatus(eventUid).map(
//         (status) =>
//             status is NonEditable &&
//             status.reason == EventNonEditableReason.expired);
//   }
//
//   @override
//   Stream<bool> eventIntegrityCheck() async* {
//     final e = await _getCurrentSubmission();
//     final now = DateTime.now();
//     yield (e.status == EventStatus.completed ||
//             e.status == EventStatus.active ||
//             e.status == EventStatus.skipped) &&
//         (e.eventDate == null || !e.eventDate!.isAfter(now));
//   }
//
//   @override
//   Future<int> getNoteCount() async {
//     return await _db.noteModule.notes().byEventUid().eq(_instanceUid).count();
//   }
//
//   @override
//   Future<bool> showCompletionPercentage() async {
//     final exists = await _db.settingModule.appearanceSettings().exists();
//     if (exists) {
//       final config = await _db.settingModule
//           .appearanceSettings()
//           .getProgramConfigurationByUid((await _getCurrentSubmission()).program);
//       return config?.completionSpinner ?? true;
//     }
//     return true;
//   }
//
//   @override
//   Future<bool> hasAnalytics() async {
//     final event = await _getCurrentSubmission();
//     final hasIndicators = !(await _db.programModule
//         .programIndicators()
//         .byProgramUid()
//         .eq(event.program)
//         .get()
//         .then((list) => list.isEmpty));
//
//     final rules = await _db.programModule
//         .programRules()
//         .withProgramRuleActions()
//         .byProgramUid()
//         .eq(event.program)
//         .get();
//     final hasRules = rules.any((rule) =>
//         rule.programRuleActions?.any((action) =>
//             action.flowType == ProgramRuleActionType.displayKeyValuePair ||
//             action.flowType == ProgramRuleActionType.displayText) ??
//         false);
//
//     return hasIndicators || hasRules;
//   }
//
//   @override
//   Future<bool> hasRelationships() async {
//     return !(await _db.relationshipModule
//         .relationshipTypes()
//         .byAvailableForEvent(_instanceUid)
//         .get()
//         .then((list) => list.isEmpty));
//   }
//
//   @override
//   Future<ValidationStrategy> validationStrategy() async {
//     final stageUid = await programStage().first;
//     final strategy = await SdkExtensions.programStage(_db, stageUid)
//         .then((cfg) => cfg.validationStrategy);
//     return strategy ?? ValidationStrategy.onComplete;
//   }
//
//   @override
//   Future<String?> getEnrollmentUid() async {
//     return (await _getCurrentSubmission()).enrollment;
//   }
//
//   @override
//   Future<String?> getTeiUid() async {
//     final enrollUid = await getEnrollmentUid();
//     if (enrollUid == null) return null;
//     final enrollment =
//         await _db.enrollmentModule.enrollments().byUid(enrollUid).get();
//     return enrollment?.trackedEntityInstance;
//   }
// }
