import 'package:d2_remote/core/datarun/utilities/date_utils.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/file_resource/entities/file_resource.entity.dart';
import 'package:d2_remote/modules/metadata/option_set/entities/option.entity.dart';
import 'package:d2_remote/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:mass_pro/commons/extensions/string_extension.dart';
import 'package:mass_pro/sdk/core/common/value_type.dart';

extension CheckValueDynamicExtension on dynamic {
  Future<bool> check(
      ValueType? valueType, String? optionSetUid, String value) async {
    if (optionSetUid != null) {
      final Option? optionByCode = await D2Remote.optionModule.option
          .byOptionSet(optionSetUid)
          .where(attribute: 'code', value: value).getOne();

      final Option? optionByName = await D2Remote.optionModule.option
          .byOptionSet(optionSetUid)
          .where(attribute: 'name', value: value).getOne();
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
          case ValueType.FileResource:
          case ValueType.Image:
            final FileResource? fileResource = await D2Remote
                .fileResourceModule.fileResource
                .byId(value)
                .getOne();
            return fileResource != null;
          case ValueType.OrganisationUnit:
            final OrganisationUnit? orgUnit = await D2Remote
                .organisationUnitModule.organisationUnit
                .byId(value)
                .getOne();
            return orgUnit != null;
          default:
            break;
        }
        return true;
      }
    }
    return false;
  }
}

extension CheckOptionSetValueDynamicExtension on dynamic {
  Future<String?> checkOptionSetValue(String optionSetUid, String code) async {
    return (await D2Remote.optionModule.option
        .byOptionSet(optionSetUid)
        .where(attribute: 'code', value: code)
        .getOne())?.displayName;
  }
}

extension CheckValueTypeValueDynamicExtension on dynamic {
  Future<String?> checkValueTypeValue(
      ValueType? valueType, String value) async {
    switch (valueType) {
      case ValueType.OrganisationUnit:
        return await D2Remote.organisationUnitModule.organisationUnit
            .byId(value)
            .getOne()
            .displayName;
      case ValueType.Image:
      case ValueType.FileResource:
        final FileResource? fileResource =
            await D2Remote.fileResourceModule.fileResource.byId(value).getOne();
        if (fileResource != null) {
          return fileResource.localFilePath;
        } else {
          return '';
        }
      case ValueType.Date:
        try {
          return DateUtils.uiDateFormat()
              .format(DateUtils.databaseDateFormat().parse(value));
        } catch (e) {
          return '';
        }
      case ValueType.DateTime:
        try {
          return DateUtils.dateTimeFormat()
              .format(DateUtils.databaseDateFormat().parse(value));
        } catch (e) {
          return '';
        }
      case ValueType.Time:
        try {
          return DateUtils.timeFormat()
              .format(DateUtils.timeFormat().parse(value));
        } catch (e) {
          return '';
        }
      default:
        break;
    }

    return value;
  }
}
