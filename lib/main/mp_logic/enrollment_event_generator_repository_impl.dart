import 'package:d2_remote/core/mp/period/period_type.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/data/tracker/entities/enrollment.entity.dart';
import 'package:d2_remote/modules/data/tracker/entities/event.entity.dart';
import 'package:d2_remote/modules/data/tracker/queries/event.query.dart';
import 'package:d2_remote/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_remote/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:d2_remote/shared/utilities/save_option.util.dart';
import 'package:d2_remote/shared/utilities/sort_order.util.dart';
import '../../commons/extensions/base_query_extension.dart';
import '../../core/event/event_projection.dart';
import '../../core/event/event_status.dart';
import 'enrollment_event_generator_repository.dart';

class EnrollmentEventGeneratorRepositoryImpl
    implements EnrollmentEventGeneratorRepository {
  const EnrollmentEventGeneratorRepositoryImpl();

  @override
  Future<Enrollment> enrollment(String enrollmentUid) async {
    return (await D2Remote.trackerModule.enrollment
        .byId(enrollmentUid)
        .getOne())!;
  }

  @override
  Future<List<ProgramStage>> enrollmentAutogeneratedEvents(
      String enrollmentUid, String programUid) async {
    return await D2Remote.programModule.programStage
        .resetFilters()
        .byProgram(programUid)
        .where(attribute: 'autoGenerateEvent', value: true)
        .orderBy(attribute: 'sortOrder', order: SortOrder.ASC)
        .get();
  }

  @override
  Future<Program> enrollmentProgram(String programUid) async {
    return (await D2Remote.programModule.program.byId(programUid).getOne())!;
  }

  @override
  Future<ProgramStage?> firstStagesInProgram(String programUid) async {
    return await D2Remote.programModule.programStage
        .resetFilters()
        .byProgram(programUid)
        .orderBy(attribute: 'sortOrder', order: SortOrder.ASC)
        .getOne();
  }

  @override
  Future<ProgramStage?> firstOpenAfterEnrollmentStage(String programUid) async {
    return await D2Remote.programModule.programStage
        .resetFilters()
        .byProgram(programUid)
        .where(attribute: 'openAfterEnrollment', value: true)
        .orderBy(attribute: 'sortOrder', order: SortOrder.ASC)
        .getOne();
  }

  @override
  Future<bool> eventExistInEnrollment(
      String enrollmentUid, String stageUid) async {
    return await D2Remote.trackerModule.event
        .resetFilters()
        .byEnrollment(enrollmentUid)
        .byProgramStage(stageUid)
        // "Order By (CASE WHEN status IN (Active, completed, visited) THEN EVENT_DATE ELSE DUE_DATE END)"
        // .orderByTimeline(RepositoryScope.OrderByDirection.ASC)
        .orderBy(attribute: 'eventDate', order: SortOrder.ASC)
        .getOne();
  }

  @override
  Future<String> eventUidInEnrollment(
      String enrollmentUid, String stageUid) async {
    return (await D2Remote.trackerModule.event
            .resetFilters()
            .byEnrollment(enrollmentUid)
            .byProgramStage(stageUid)
            // "Order By (CASE WHEN status IN (Active, completed, visited) THEN EVENT_DATE ELSE DUE_DATE END)"
            // .orderByTimeline(RepositoryScope.OrderByDirection.ASC)
            .orderBy(attribute: 'eventDate', order: SortOrder.ASC)
            .getOne())!
        .id!;
  }

  @override
  Future<String> addEvent(String enrollmentUid, String programUid,
      String stageUid, String orgUnitUid, String activityUid) async {
    // var catComboUid = d2.programModule().programs()
    //     .uid(programUid)
    //     .blockingGet()
    //     .categoryComboUid()
    // var catCombo = d2.categoryModule().categoryCombos().uid(catComboUid).blockingGet()
    // val catOptionCombo = if (catCombo.isDefault == true) {
    //   d2.categoryModule().categoryOptionCombos()
    //       .byCategoryComboUid().eq(catComboUid)
    //       .blockingGet()
    //       .firstOrNull()?.uid()
    // } else {
    //   null
    // }

    final Event eventToAdd = (EventCreateProjection.builder()
          ..enrollment = enrollmentUid
          ..programStage = stageUid
          // ..program = programUid
          ..activity = activityUid
          ..organisationUnit = orgUnitUid)
        .build();

    await D2Remote.trackerModule.event.setData(eventToAdd).save();
    return eventToAdd.id!;
  }

  @override
  Future<DateTime> periodStartingDate(
      PeriodType periodType, DateTime date) async {
    // TODO(NMC): kk
    // return d2.periodModule().periodHelper()
    //     .blockingGetPeriodForPeriodTypeAndDate(periodType, date)
    //     .startDate()!!;
    return DateTime.now();
  }

  @override
  Future<void> setEventDate(String eventUid, isScheduled, DateTime date) async {
    final EventQuery eventRepository = D2Remote.trackerModule.event;
    final Event event = (await eventRepository.getOne())!;

    if (isScheduled) {
      event.dueDate = date.toIso8601String().split('.')[0];
      event.status = EventStatus.SCHEDULE.name;
    } else {
      event.eventDate = date.toIso8601String().split('.')[0];
    }

    event.synced = false;
    event.dirty = true;
    await eventRepository
        .setData(event)
        .save(saveOptions: SaveOptions(skipLocalSyncStatus: true));
  }
}
