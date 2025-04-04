import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/metadatarun/metadatarun.dart';
import 'package:datarunmobile/commons/identifiable.repository.dart';
import 'package:datarunmobile/core/models/d_run_identifiable.dart';
import 'package:datarunmobile/data/activity/model/activity_model.dart';
import 'package:datarunmobile/data/activity/repository/activity_query_model.dart';
import 'package:datarunmobile/data/assignment/assignment.dart';
import 'package:datarunmobile/data/team/repository/team_query_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ActivityDetailService {
  ActivityDetailService(
      this._repository, this._assignmentRepository, this._teamRepository);

  final DRunBaseRepository<Activity> _repository;

  final DRunBaseRepository<Assignment> _assignmentRepository;
  final DRunBaseRepository<Team> _teamRepository;

  Future<List<ActivityModel>> get({ActivityQueryModel? query}) async {
    final List<Activity> entities = await _repository.get(query: query);

    List<ActivityModel> entityModels = [];
    for (final a in entities) {
      entityModels.add(ActivityModel.fromIdentifiable(
          baseEntity: a,
          assignmentCount: await _getAssignmentCount(a.id!),
          assignedTeam:
              (await _getTeams(a.id!, EntityScope.Assigned)).firstOrNull?.code,
          managedTeamCount:
              (await _getTeams(a.id!, EntityScope.Managed)).length));
    }
    return entityModels;
  }

  Future<int> _getAssignmentCount(String activity) {
    return _assignmentRepository.getCount(
        query: AssignmentQueryModel(activity: activity));
  }

  Future<List<DRunIdentifiable>> _getTeams(
      String activity, EntityScope scope) async {
    final teams = await _teamRepository.get(
        query: TeamQueryModel(activity: activity, scope: scope));

    return teams
        .map((t) => DRunIdentifiable.fromIdentifiable(baseEntity: t))
        .toList();
  }
}
