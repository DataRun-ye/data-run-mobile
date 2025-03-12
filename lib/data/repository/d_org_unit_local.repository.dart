import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/metadatarun/org_unit/entities/org_unit.entity.dart';
import 'package:datarunmobile/core/d2_remote_extensions/base_query_extension.dart';
import 'package:datarunmobile/modular/d_data_api/identifiable.repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IdentifiableRepository<OrgUnit>)
class DOrgUnitLocalRepository implements IdentifiableRepository<OrgUnit> {
  @override
  Future<int> delete(String id) {
    return D2Remote.organisationUnitModuleD.orgUnit.byId(id).delete();
  }

  @override
  Future<OrgUnit?> getById(String id) {
    return D2Remote.organisationUnitModuleD.orgUnit.byId(id).getOne();
  }

  @override
  Future<List<OrgUnit>> getWhere(
      {String? attribute, value, int? limit, int? offset}) {
    if (attribute != null) {
      return D2Remote.organisationUnitModuleD.orgUnit
          .resetFilters()
          .where(attribute: attribute, value: value)
          .get(limit: limit, offset: offset);
    }
    return D2Remote.organisationUnitModuleD.orgUnit
        .resetFilters()
        .get(limit: limit, offset: offset);
  }

  @override
  Future<OrgUnit> save(OrgUnit identifiable) async {
    await D2Remote.organisationUnitModuleD.orgUnit.setData(identifiable).save();
    return D2Remote.organisationUnitModuleD.orgUnit.byId(identifiable.id!).getOne();
  }
}
