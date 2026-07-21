import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class DataValueRepository {
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

  Future<DataElement?> getDataElement(String dataElementUid) async {
    final DataElement? orgUnit = await db.managers.dataElements
        .filter((f) => f.id(dataElementUid))
        .getSingleOrNull();
    return orgUnit;
  }

  Future<String?> getTeamById(String teamUid) async {
    final String? team = await db.managers.teams
        .filter((f) => f.id(teamUid))
        .map((t) => '${Intl.message('team')} ${t.code}')
        .getSingleOrNull();

    return team;
  }

  Future<String?> getOptionById(String optionUid) async {
    final DataOption? dataOption = await db.managers.dataOptions
        .filter((f) => f.id(optionUid) | f.code(optionUid) | f.name(optionUid))
        .getSingleOrNull();
    return getItemLocalString(dataOption?.label,
        defaultString: dataOption?.code ?? dataOption?.name);
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
