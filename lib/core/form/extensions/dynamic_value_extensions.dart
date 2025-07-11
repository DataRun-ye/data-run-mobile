import 'package:d_sdk/core/utilities/date_helper.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/commons/extensions/string_extension.dart';
import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

extension CheckWhatValueExtension on DataValue {
  static Future<bool> check(
      ValueType? valueType, String? optionSetUid, String value) async {
    if (optionSetUid != null && valueType != ValueType.SelectMulti) {
      final DataOption? optionByCode = await DSdk.db.managers.dataOptions
          .filter((f) => f.optionSet.id(optionSetUid) & f.code(value))
          .getSingleOrNull();

      final DataOption? optionByName = await DSdk.db.managers.dataOptions
          .filter((f) => f.optionSet.id(optionSetUid) & f.name(value))
          .getSingleOrNull();

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
            final OrgUnit? orgUnit = await DSdk.db.managers.orgUnits
                .filter((f) => f.id(value))
                .getSingleOrNull();
            return orgUnit != null;
          case ValueType.Team:
            final Team? team = await DSdk.db.managers.teams
                .filter((f) => f.id(value))
                .getSingleOrNull();
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
    DataOption? option = await DSdk.db.managers.dataOptions
        .filter((f) => f.optionSet.id(optionSetUid) & f.code(value))
        .getSingleOrNull();

    if (option == null) {
      option = await DSdk.db.managers.dataOptions
          .filter((f) => f.optionSet.id(optionSetUid) & f.name(value))
          .getSingleOrNull();
    }

    return option != null
        ? getItemLocalString(option.label, defaultString: option.name)
        : null;
  }

  static Future<String?> checkValueTypeValue(
      ValueType? valueType, String value) async {
    switch (valueType) {
      case ValueType.OrganisationUnit:
        return (await DSdk.db.managers.orgUnits
                .filter((f) => f.id(value))
                .getSingleOrNull())
            ?.displayName;
      case ValueType.Team:
        final Team? team = await DSdk.db.managers.teams
            .filter((f) => f.id(value))
            .getSingleOrNull();

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
