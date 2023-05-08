import 'package:d2_remote/core/mp/enrollment/enrollment_status.dart';
import 'package:d2_remote/core/mp/period/period_type.dart';
import 'package:d2_remote/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_remote/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../../commons/constants.dart';
import '../../../../commons/period/period_extensions.dart';
import '../../bundle/bundle.dart';
import '../../general/view_base.dart';
import '../event_details/models/event_details.dart';
import 'di/event_initial_module.dart';
import 'event_initial_presenter.dart';
import 'event_initial_view.dart';

/// EventInitialActivity
class EventInitialScreen extends ConsumerStatefulWidget {
  const EventInitialScreen({super.key});

  static const String route = '/eventinitialscreen';

  @override
  ConsumerState<EventInitialScreen> createState() => _EventInitialScreenState();
}

class _EventInitialScreenState extends ConsumerState<EventInitialScreen>
    with EventInitialView, ViewBase {
  final EventDetails _eventDetails = const EventDetails();
  late final String? programUid;
  late final EventInitialPresenter presenter;
  late final String? eventUid;
  late final String? eventCreationType;
  late final String? teiUid;
  late final PeriodType? eventPeriodType;
  late final String? orgUnit;
  late final String? stageUid;
  late final String? enrollmentUid;
  late final String? enrollmentStatus;
  late final int? eventScheduleInterval;

  // late final bool accessData;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: FocusTraversalGroup(
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Text('programUid: $programUid'),
              Text('eventUid: $eventUid'),
              Text('eventCreationType: $eventCreationType'),
              Text('teiUid: $teiUid'),
              Text('eventPeriodType: $eventPeriodType'),
              Text('orgUnit: $orgUnit'),
              Text('stageUid: $stageUid'),
              Text('enrollmentUid: $enrollmentUid'),
              Text('enrollmentStatus: $enrollmentStatus'),
              Text('eventScheduleInterval: $eventScheduleInterval'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    presenter = ref.read(eventInitialPresenterProvider(this));
    final Bundle bundle = Get.arguments as Bundle;

    programUid = bundle.getString(PROGRAM_UID);
    eventUid = bundle.getString(EVENT_UID);
    eventCreationType = bundle.getString(EVENT_CREATION_TYPE);
    teiUid = bundle.getString(TRACKED_ENTITY_INSTANCE);
    enrollmentUid = bundle.getString(
      ENROLLMENT_UID,
    );
    orgUnit = bundle.getString(
      ORG_UNIT,
    );
    // bundle.getSerializable(EVENT_PERIOD_TYPE, eventPeriodType);
    eventPeriodType = bundle.getString(EVENT_PERIOD_TYPE)?.toPeriodType;
    stageUid = bundle.getString(
      PROGRAM_STAGE_UID,
    );
    eventScheduleInterval = bundle.getInt(
      EVENT_SCHEDULE_INTERVAL,
    );
    // bundle.getSerializable(ENROLLMENT_STATUS, enrollmentStatus);
    enrollmentStatus = bundle.getString(
      ENROLLMENT_STATUS,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    presenter.init(programUid, eventUid, orgUnit, stageUid);
    super.didChangeDependencies();
  }
  @override
  void onEventCreated(String eventUid) {
    // TODO: implement onEventCreated
  }

  @override
  void onEventUpdated(String eventUid) {
    // TODO: implement onEventUpdated
  }

  @override
  void renderError(String message) {
    // TODO: implement renderError
  }

  @override
  void setAccessDataWrite(bool canWrite) {
    // TODO: implement setAccessDataWrite
  }

  @override
  void setProgram(Program? program) {
    // TODO: implement setProgram
  }

  @override
  void setProgramStage(ProgramStage? programStage) {
    // TODO: implement setProgramStage
  }

  @override
  void showEventWasDeleted() {
    // TODO: implement showEventWasDeleted
  }

  @override
  void showProgramStageSelection() {
    // TODO: implement showProgramStageSelection
  }

  @override
  void showQR() {
    // TODO: implement showQR
  }

  @override
  void updatePercentage(double primaryValue) {
    // TODO: implement updatePercentage
  }
}
