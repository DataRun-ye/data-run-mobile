import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
import 'package:d2_remote/shared/queries/base.query.dart';
import 'package:datarunmobile/core/d2_remote_extensions/base_query_extension.dart';
import 'package:datarunmobile/commons/identifiable.repository.dart';
import 'package:datarunmobile/commons/query_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IdentifiableRepository<Activity>)
class DActivityLocalRepository extends IdentifiableRepository<Activity> {
  BaseQuery<Activity> get entityQuery => D2Remote.activityModuleD.activity;

  @override
  Future<int> delete(String id) {
    return entityQuery.byId(id).delete();
  }

  @override
  Future<Activity?> getById(String id) {
    return entityQuery.byId(id).getOne();
  }

  @override
  Future<List<Activity>> get({QueryModel? query}) {
    entityQuery.resetFilters();

    if (query != null) {
      for (final attribute in query.toMap().keys) {
        entityQuery.where(
            attribute: attribute, value: query.toMap()[attribute]);
      }
    }

    return entityQuery.get(limit: query?.limit, offset: query?.offset);
  }

  @override
  Future<Activity> save(Activity identifiable) async {
    await entityQuery.setData(identifiable).save();
    return entityQuery.byId(identifiable.id!).getOne();
  }
}
