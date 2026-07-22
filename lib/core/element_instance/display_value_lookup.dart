import 'package:datarunmobile/core/form/element_template/get_item_local_string.dart';
import 'package:datarunmobile/d_sdk.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class DisplayValueLookup {
  static AppDatabase get db => DSdk.db;

  Future<String?> getOrgUnitById(String orgUnitUid) async {
    final List<OrgUnit> orgUnit = await db.managers.orgUnits
        .filter((f) => f.id.isIn(orgUnitUid.split(',')))
        .get();
    return orgUnit.isNotEmpty
        ? orgUnit
            .map((ou) => getItemLocalString(ou.label, defaultString: ou.name))
            .join(', ')
        : null;
  }

  Future<String?> getTeamById(String teamUid) async {
    final String? team = await db.managers.teams
        .filter((f) => f.id(teamUid))
        .map((t) => '${Intl.message('team')} ${t.code}')
        .getSingleOrNull();

    return team;
  }

  Future<String> getOptionsByIds(List<String> optionUids) async {
    final List<DataOption> dataOption = await db.managers.dataOptions
        .filter((f) =>
            f.id.isIn(optionUids) |
            f.code.isIn(optionUids) |
            f.name.isIn(optionUids))
        .get();
    return dataOption
        .map((o) => getItemLocalString(o.label, defaultString: o.name))
        .join(', ');
  }
}
