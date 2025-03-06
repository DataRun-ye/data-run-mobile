import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/metadatarun/org_unit/entities/org_unit.entity.dart';

class OrgUnitConfiguration {
  const OrgUnitConfiguration();

  Future<OrgUnit?> orgUnitByUid(String uid) async {
    return D2Remote.organisationUnitModuleD.orgUnit.byId(uid).getOne();
  }
}
