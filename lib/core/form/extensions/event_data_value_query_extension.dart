import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_value.entity.dart';
import 'package:d2_remote/modules/datarun/data_value/queries/data_value.query.dart';
import 'package:d2_remote/modules/metadatarun/data_element/entities/data_element.entity.dart';
import 'package:d2_remote/modules/metadatarun/option_set/entities/option.entity.dart';
import 'package:d2_remote/shared/utilities/merge_mode.util.dart';
import 'package:d2_remote/shared/utilities/save_option.util.dart';
import 'package:datarunmobile/commons/extensions/string_extension.dart';
import 'package:datarunmobile/core/d2_remote_extensions/base_query_extension.dart';
import 'package:datarunmobile/core/form/extensions/dynamic_value_extensions.dart';

/// BlockingSetCheckTrackedEntityAttributeValueExtension
extension SetCheckTrackedEntityAttributeValueExtension on DataValueQuery {
  Future<bool> exists() async {
    if (submission.isNullOrEmpty || dataElement.isNullOrEmpty) return false;
    final DataValue? value = await getOne();
    return value == null ? false : value.deleted != true;
  }

  Future<void> deleteIfExist() async {
    final toDelete = await getOne();
    if (toDelete != null) {
      await setData(toDelete.delete())
          .save(saveOptions: SaveOptions(skipLocalSyncStatus: true));
    }
  }

  Future<bool> setCheck(String deUid, String value) async {
    final DataElement de =
        (await D2Remote.dataElementModule.dataElement.byId(deUid).getOne())!;
    // if (de != null) {
    final checkResult =
        await CheckWhatValueExtension.check(de.type, de.optionSet, value);
    if (checkResult) {
      final finalValue = await _assureCodeForOptionSet(de.optionSet, value);
      await SetValue(finalValue);
      return true;
    } else {
      await deleteIfExist();
      return false;
    }
    // }
  }

  Future<void> SetValue(String value) async {
    final String date = DateHelper.nowUtc();
    final toUpdate = await getOne();
    // updateOrInsert
    if (toUpdate != null) {
      mergeMode = MergeMode.Merge;

      await setData(DataValue.fromJson({
        ...toUpdate.toJson(),
        'value': value,
        'synced': false,
        'dirty': true,
        'lastModifiedDate': date
      })).save(saveOptions: SaveOptions(skipLocalSyncStatus: true));
      mergeMode = MergeMode.Replace;
    }

    await setData(DataValue(
            dirty: true,
            dataElement: dataElement!,
            submission: submission,
            value: value,
            parent: parent,
            createdDate: date,
            lastModifiedDate: date,
            templatePath: templatePath!))
        .save(saveOptions: SaveOptions(skipLocalSyncStatus: true));
  }

  Future<String> _assureCodeForOptionSet(
      String? optionSetUid, String value) async {
    if (optionSetUid != null) {
      final Option? option = await D2Remote.optionSetModule.option
          .resetFilters()
          .byOptionSet(optionSetUid)
          .where(attribute: 'name', value: value)
          .getOne();
      return option != null ? option.code! : value;
    }
    return value;
  }
}
