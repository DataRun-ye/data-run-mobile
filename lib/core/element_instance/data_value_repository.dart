import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_value.entity.dart';
import 'package:d2_remote/modules/metadatarun/metadatarun.dart';
import 'package:d2_remote/shared/utilities/merge_mode.util.dart';
import 'package:datarunmobile/core/utils/get_item_local_string.dart';
import 'package:injectable/injectable.dart';

@injectable
class DataValueRepository {
  static Future<DataValue?> get(
      {required String submissionId,
      required String path,
      String? parent}) async {
    return D2Remote.formSubmissionModule.dataValue.byId(_makeCompositeKey(
        submission: submissionId, parent: parent, path: path));
  }

  static Future<DataValue> create(
      {required String submissionId,
      required String path,
      dynamic value,
      String? parent}) async {
    final elementPath = path.split('.');
    D2Remote.formSubmissionModule.dataValue.setData(DataValue(
        id: _makeCompositeKey(
            submission: submissionId, parent: parent, path: path),
        parent: parent,
        value: value,
        submission: submissionId,
        templatePath: path,
        dataElement: elementPath[elementPath.length - 1],
        dirty: true));

    await D2Remote.formSubmissionModule.dataValue.save();

    return D2Remote.formSubmissionModule.dataValue.data;
  }

  static Future<DataValue> save(
      {required String submissionId,
      required String path,
      dynamic value,
      String? parent}) async {
    final elementPath = path.split('.');
    D2Remote.formSubmissionModule.dataValue.setData(DataValue(
        id: _makeCompositeKey(
            submission: submissionId, parent: parent, path: path),
        parent: parent,
        value: value,
        submission: submissionId,
        templatePath: path,
        dataElement: elementPath[elementPath.length - 1],
        lastModifiedDate: DateHelper.nowUtc(),
        dirty: true));

    await D2Remote.formSubmissionModule.dataValue
      ..mergeMode = MergeMode.Merge
      ..save();

    return D2Remote.formSubmissionModule.dataValue.data;
  }

  static String _makeCompositeKey(
      {required String submission, String? parent, required String path}) {
    final elementIdentifier = path.split('.');
    return '$submission${parent != null ? '.$parent' : ''}.${elementIdentifier[elementIdentifier.length - 1]}';
  }

  Future<String?> getOrgUnitById(String orgUnitUid) async {
    final OrgUnit? orgUnit = await D2Remote.organisationUnitModuleD.orgUnit
        .byId(orgUnitUid)
        .getOne();
    return orgUnit != null
        ? getItemLocalString(orgUnit.label, defaultString: orgUnit.name)
        : null;
  }

  Future<DataElement?> getDataElement(String dataElementUid) {
    return D2Remote.dataElementModule.dataElement.byId(dataElementUid).getOne();
  }

  Future<String?> getTeamById(String teamUid) async {
    final Team? team = await D2Remote.teamModuleD.team.byId(teamUid).getOne();
    return team?.code;
  }
}
