import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:d_sdk/core/util/date_helper.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/core/form/data/display_name_provider.dart';
import 'package:datarunmobile/core/form/data/metadata/option_set_configuration.dart';
import 'package:datarunmobile/core/form/data/metadata/org_unit_configuration.dart';
import 'package:intl/intl.dart';

// @Injectable(as: DisplayNameProvider)
class DisplayNameProviderImpl implements DisplayNameProvider {
  const DisplayNameProviderImpl(
      this.optionSetConfiguration, this.orgUnitConfiguration);

  final OptionSetConfigurations optionSetConfiguration;
  final OrgUnitConfiguration orgUnitConfiguration;

  @override
  Future<String?> provideDisplayValue(
      [ValueType? valueType, String? value, String? optionSet]) async {
    if (value != null) {
      if (optionSet != null) {
        final String? v = await _getOptionDisplaySetValue(value, optionSet);
        return v ?? await _getValueTypeDisplayValue(value, valueType);
      }
      return _getValueTypeDisplayValue(value, valueType);
    }

    return value;
  }

  Future<String?> _getOptionDisplaySetValue(
      String value, String optionSet) async {
    final DataOption? optionByName =
        await optionSetConfiguration.optionInDataSetByName(optionSet, value);

    if (optionByName != null) {
      return getItemLocalString(optionByName.label,
          defaultString: optionByName.name);
    }

    final DataOption? optionByCode =
        await optionSetConfiguration.optionInDataSetByCode(optionSet, value);
    if (optionByCode != null) {
      return getItemLocalString(optionByCode.label,
          defaultString: optionByCode.code);
    }

    return value;
  }

  Future<String?> _getValueTypeDisplayValue(
      String value, ValueType? valueType) async {
    switch (valueType) {
      case ValueType.OrganisationUnit:
        return orgUnitConfiguration
            .orgUnitByUid(value)
            .then((orgUnit) => orgUnit?.displayName ?? value);
      case ValueType.Date:
        return DateHelper.fromDbUtcToUiLocalFormat(value);
      case ValueType.DateTime:
        return DateFormat(DateHelper.DATE_TIME_FORMAT_EXPRESSION, 'en_US')
            .format(DateFormat(
                    DateHelper.DATABASE_FORMAT_EXPRESSION_NO_SECONDS, 'en_US')
                .parse(value));
      case ValueType.Time:
        return DateFormat(DateHelper.TIME_FORMAT, 'en_US')
            .format(DateFormat(DateHelper.TIME_FORMAT, 'en_US').parse(value));
      default:
    }
    return value;
  }
}
