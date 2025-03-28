import 'package:d2_remote/modules/metadatarun/metadatarun.dart';
import 'package:datarunmobile/commons/identifiable.repository.dart';
import 'package:datarunmobile/data/activity/model/activity_detail_model.dart';
import 'package:datarunmobile/data/activity/repository/activity_query_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class ActivityListService {
  ActivityListService(this._repository, /*this._assignmentRepository,
      this._orgUnitRepository, this._teamRepository*/);

  final IdentifiableRepository<Activity> _repository;
  //
  // final IdentifiableRepository<Assignment> _assignmentRepository;
  // final IdentifiableRepository<OrgUnit> _orgUnitRepository;
  // final IdentifiableRepository<Team> _teamRepository;

  Future<Iterable<ActivityDetail>> get({ActivityQueryModel? query}) async {
    final List<Activity> entities = await _repository.get(query: query);

    List<ActivityDetail> entityModels = [];
    for (final a in entities) {
      entityModels.add(ActivityDetail.fromIdentifiable(identifiableEntity: a));
    }
    return entityModels;
  }
}
