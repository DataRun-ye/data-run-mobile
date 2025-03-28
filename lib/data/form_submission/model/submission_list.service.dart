import 'package:d2_remote/modules/metadatarun/metadatarun.dart';
import 'package:datarunmobile/core/models/d_run_identifiable.dart';
import 'package:datarunmobile/commons/identifiable.repository.dart';
import 'package:datarunmobile/data/assignment/model/assignment_detail_model.dart';
import 'package:datarunmobile/data/assignment/repository/assignment_query_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubmissionListService {
  SubmissionListService(this._repository, this._activityRepository,
      this._orgUnitRepository, this._teamRepository);

  final IdentifiableRepository<Assignment> _repository;
  final IdentifiableRepository<Activity> _activityRepository;
  final IdentifiableRepository<OrgUnit> _orgUnitRepository;
  final IdentifiableRepository<Team> _teamRepository;

  Future<Iterable<AssignmentDetail>> get({AssignmentQueryModel? query}) async {
    final List<Assignment> entities = await _repository.get(query: query);

    List<AssignmentDetail> entityModels = [];
    for (final a in entities) {
      final activity = await _activityRepository.getById(a.activity!);
      final orgUnit = await _orgUnitRepository.getById(a.orgUnit!);
      final team = await _teamRepository.getById(a.team!);
      entityModels.add(AssignmentDetail.fromIdentifiable(
        identifiableEntity: a,
        activity:
            DRunIdentifiable.fromIdentifiable(identifiableEntity: activity!),
        orgUnit:
            DRunIdentifiable.fromIdentifiable(identifiableEntity: orgUnit!),
        team: DRunIdentifiable.fromIdentifiable(identifiableEntity: team!),
      ));
    }
    return entityModels;
  }
}
