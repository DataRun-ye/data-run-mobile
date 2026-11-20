import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/element_template/get_item_local_string.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class DisplayValueLookup {
  AppDatabase get db => appLocator<AppDatabase>();

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

  /// A Team field holds one of the managed teams, which are kept apart from
  /// the user's own teams.
  Future<String?> getTeamById(String teamUid) async {
    final own = await db.managers.teams
        .filter((f) => f.id(teamUid))
        .map((t) => t.code)
        .get();
    final managed = own.isNotEmpty
        ? own
        : await db.managers.managedTeams
            .filter((f) => f.id(teamUid))
            .map((t) => t.code)
            .get();
    if (managed.isEmpty) return null;
    return '${Intl.message('team')} ${managed.first ?? ''}'.trim();
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
