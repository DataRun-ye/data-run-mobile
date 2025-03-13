import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:datarunmobile/core/d2_remote_extensions/base_query_extension.dart';
import 'package:datarunmobile/data/repository/identifiable.repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IdentifiableRepository<Assignment>)
class DAssignmentListLocalRepository
    implements IdentifiableRepository<Assignment> {
  @override
  Future<int> delete(String id) {
    return D2Remote.assignmentModuleD.assignment.byId(id).delete();
  }

  @override
  Future<Assignment?> getById(String id) {
    return D2Remote.assignmentModuleD.assignment.byId(id).getOne();
  }

  @override
  Future<List<Assignment>> getWhere(
      {String? attribute, value, int? limit, int? offset}) {
    if (attribute != null) {
      return D2Remote.assignmentModuleD.assignment
          .resetFilters()
          .where(attribute: attribute, value: value)
          .get(limit: limit, offset: offset);
    }
    return D2Remote.assignmentModuleD.assignment
        .resetFilters()
        .get(limit: limit, offset: offset);
  }

  @override
  Future<Assignment> save(Assignment identifiable) async {
    await D2Remote.assignmentModuleD.assignment.setData(identifiable).save();
    return D2Remote.assignmentModuleD.assignment
        .byId(identifiable.id!)
        .getOne();
  }
}
