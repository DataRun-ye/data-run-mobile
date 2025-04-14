// import 'dart:async';
//
// import 'package:d_sdk/core/utilities/date_helper.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:datarunmobile/commons/d_run_base_service.dart';
// import 'package:datarunmobile/core/models/d_run_identifiable.dart';
// import 'package:datarunmobile/commons/identifiable.repository.dart';
// import 'package:datarunmobile/data/assignment/model/assignment_model_new.dart';
// import 'package:injectable/injectable.dart';
//
// // @lazySingleton
// class AssignmentListService
//     extends DRunBaseService<Assignment, AssignmentModelNew> {
//   AssignmentListService(super.repository, this._activityRepository,
//       this._orgUnitRepository, this._teamRepository);
//
//   final DRunBaseRepository<Activity> _activityRepository;
//   final DRunBaseRepository<OrgUnit> _orgUnitRepository;
//   final DRunBaseRepository<Team> _teamRepository;
//
//   static DateTime? calculateAssignmentDate(
//       String activityStartDate, int? startDay) {
//     final DateTime? activityStart = DateTime.tryParse(
//         DateHelper.fromDbUtcToUiLocalFormat(activityStartDate));
//     return activityStart?.add(Duration(days: (startDay ?? 1) - 1));
//   }
//
//   @override
//   FutureOr<AssignmentModelNew> createModel(Assignment identifiable) async {
//     final activity = await _activityRepository.getById(identifiable.activity!);
//     final orgUnit = await _orgUnitRepository.getById(identifiable.orgUnit!);
//     final team = await _teamRepository.getById(identifiable.team!);
//     final entityModel = AssignmentModelNew.fromIdentifiable(
//       baseEntity: identifiable,
//       activity: DRunIdentifiable.fromIdentifiable(baseEntity: activity!),
//       orgUnit: DRunIdentifiable.fromIdentifiable(baseEntity: orgUnit!),
//       team: DRunIdentifiable.fromIdentifiable(baseEntity: team!),
//       dueDate: activity.startDate != null
//           ? calculateAssignmentDate(activity.startDate!, identifiable.startDay)
//           : null,
//     );
//     return entityModel;
//   }
// }
