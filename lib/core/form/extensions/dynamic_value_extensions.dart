import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_value.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:d2_remote/modules/metadatarun/metadatarun.dart';
import 'package:d2_remote/modules/metadatarun/option_set/entities/option.entity.dart';
import 'package:datarunmobile/commons/extensions/string_extension.dart';
import 'package:datarunmobile/core/utils/get_item_local_string.dart';
import 'package:intl/intl.dart';

extension CheckWhatValueExtension on DataValue {
  static Future<bool> check(
      ValueType? valueType, String? optionSetUid, String value) async {
    if (optionSetUid != null) {
      final Option? optionByCode = await D2Remote.optionSetModule.option
          .byOptionSet(optionSetUid)
          .where(attribute: 'code', value: value)
          .getOne();

      final Option? optionByName = await D2Remote.optionSetModule.option
          .byOptionSet(optionSetUid)
          .where(attribute: 'name', value: value)
          .getOne();
      return optionByCode != null || optionByName != null;
    }

    if (valueType != null) {
      if (valueType.isNumeric) {
        try {
          value.toDouble();
          return true;
        } catch (e) {
          return false;
        }
      } else {
        switch (valueType) {
        // case ValueType.FileResource:
        // case ValueType.Image:
        //   final FileResource? fileResource = await D2Remote
        //       .fileResourceModule.fileResource
        //       .byId(value)
        //       .getOne();
        //   return fileResource != null;
          case ValueType.OrganisationUnit:
            final OrgUnit? orgUnit = await D2Remote
                .organisationUnitModuleD.orgUnit
                .byId(value)
                .getOne();
            return orgUnit != null;
          case ValueType.Team:
            final Team? team =
            await D2Remote.teamModuleD.team.byId(value).getOne();
            return team != null;
          default:
            break;
        }
        return true;
      }
    }
    return false;
  }
  static Future<String?> checkOptionSetValue(
      String optionSetUid, String value) async {
    Option? option = await D2Remote.optionSetModule.option
        .byOptionSet(optionSetUid)
        .where(attribute: 'code', value: value)
        .getOne();
    if (option == null) {
      option = await D2Remote.optionSetModule.option
          .byOptionSet(optionSetUid)
          .where(attribute: 'name', value: value)
          .getOne();
    }

    return option != null
        ? getItemLocalString(option.label, defaultString: option.name)
        : null;
  }

  static Future<String?> checkValueTypeValue(
      ValueType? valueType, String value) async {
    switch (valueType) {
      case ValueType.OrganisationUnit:
        return (await D2Remote.organisationUnitModuleD.orgUnit
            .byId(value)
            .getOne())
            .displayName;
      case ValueType.Team:
        final Team? team = await D2Remote.teamModuleD.team.byId(value).getOne();

        return team != null ? '${Intl.message('team')} ${team.code}' : null;

    // case ValueType.Image:
    // case ValueType.FileResource:
    //   final FileResource? fileResource =
    //       await D2Remote.fileResourceModule.fileResource.byId(value).getOne();
    //   if (fileResource != null) {
    //     return fileResource.localFilePath;
    //   } else {
    //     return '';
    //   }
      case ValueType.Date:
        try {
          return DateHelper.fromDbUtcToUiLocalFormat(value);
        } catch (e) {
          return '';
        }
      case ValueType.DateTime:
        try {
          return DateHelper.fromDbUtcToUiLocalFormat(value, includeTime: true);
        } catch (e) {
          return '';
        }
      case ValueType.Time:
        try {
          return DateHelper.fromDbUtcToUiLocalFormat(value,
              includeTime: true, onlyTime: true);
        } catch (e) {
          return '';
        }
      default:
        break;
    }

    return value;
  }
}
