import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';

class OrgUnitConfiguration {
  const OrgUnitConfiguration();

  Future<OrgUnit?> orgUnitByUid(String uid) async {
    return DSdk.db.managers.orgUnits
        .filter((f) => f.id.equals(uid))
        .getSingleOrNull();
  }
}
