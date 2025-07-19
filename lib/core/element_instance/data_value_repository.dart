import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@injectable
class DataValueRepository {
  static AppDatabase get db => DSdk.db;

  static Future<DataValue?> get(
      {required String submissionId, required String dataElementId}) async {
    await db.select(db.dataValues)
      ..where((row) => row.dataInstance.equals(submissionId));
    return (db.select(db.dataValues)
          ..where((tbl) =>
              tbl.dataInstance.equals(submissionId) &
              tbl.dataElement.equals(dataElementId)))
        .getSingleOrNull();
  }

  static Future<DataValue> create(
      {required String submissionId,
      required String path,
      dynamic value,
      String? parent}) async {
    final elementPath = path.split('.');
    final dv = DataValue(
        id: _makeCompositeKey(
            submission: submissionId, parent: parent, path: path),
        value: value,
        dataInstance: submissionId,
        dataElement: elementPath[elementPath.length - 1],
        lastModifiedDate: DateTime.now().toUtc(),
        createdDate: DateTime.now().toUtc());

    await db.into(db.dataValues).insert(dv);

    return dv;
  }

  static Future<DataValue> update(
      {required String submissionId,
      required String dataElementId,
      dynamic value,
      String? parent}) async {
    final dv =
        await get(submissionId: submissionId, dataElementId: dataElementId);
    dv!.copyWith(
        value: Value(value),
        dataInstance: submissionId,
        dataElement: dataElementId,
        lastModifiedDate: Value(DateTime.now().toUtc()));
    await db.update(db.dataValues).replace(dv);

    // DataValue(
    //     id: _makeCompositeKey(
    //         submission: submissionId, parent: parent, path: path),
    //     parent: parent,
    //     value: value,
    //     submission: submissionId,
    //     templatePath: path,
    //     dataElement: elementPath[elementPath.length - 1],
    //     lastModifiedDate: DateHelper.nowUtc(),
    //     dirty: true);

    return dv;
  }

  static String _makeCompositeKey(
      {required String submission, String? parent, required String path}) {
    final elementIdentifier = path.split('.');
    return '$submission${parent != null ? '.$parent' : ''}.${elementIdentifier[elementIdentifier.length - 1]}';
  }

  Future<String?> getOrgUnitById(String orgUnitUid) async {
    final OrgUnit? orgUnit = await db.managers.orgUnits
        .filter((f) => f.id(orgUnitUid))
        .getSingleOrNull();
    return orgUnit != null
        ? getItemLocalString(orgUnit.label, defaultString: orgUnit.name)
        : null;
  }

  Future<DataElement?> getDataElement(String dataElementUid) async {
    final DataElement? orgUnit = await db.managers.dataElements
        .filter((f) => f.id(dataElementUid))
        .getSingleOrNull();
    return orgUnit;
  }

  Future<String?> getTeamById(String teamUid) async {
    final Team? team =
        await db.managers.teams.filter((f) => f.id(teamUid)).getSingleOrNull();
    return team?.code;
  }

  Future<String?> getOptionById(String optionUid) async {
    final DataOption? dataOption = await db.managers.dataOptions
        .filter((f) => f.id(optionUid))
        .getSingleOrNull();
    return getItemLocalString(dataOption?.label,
        defaultString: dataOption?.code ?? dataOption?.name);
  }
}
