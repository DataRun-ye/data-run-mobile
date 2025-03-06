import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarun/core/form/data/display_name_provider.dart';
import 'package:datarun/core/form/data/metadata/option_set_configuration.dart';
import 'package:datarun/core/form/data/metadata/org_unit_configuration.dart';
import 'package:datarun/core/utils/get_item_local_string.dart';
import 'package:intl/intl.dart';

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
    final FormOption? optionByName =
        await optionSetConfiguration.optionInDataSetByName(optionSet, value);

    if (optionByName != null) {
      return getItemLocalString(optionByName.label.unlock,
          defaultString: optionByName.name);
    }

    final FormOption? optionByCode =
        await optionSetConfiguration.optionInDataSetByCode(optionSet, value);
    if (optionByCode != null) {
      return getItemLocalString(optionByCode.label.unlock,
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
        return DateFormat(DateHelper.DATE_TIME_FORMAT_EXPRESSION).format(
            DateFormat(DateHelper.DATABASE_FORMAT_EXPRESSION_NO_SECONDS)
                .parse(value));
      case ValueType.Time:
        return DateFormat(DateHelper.TIME_FORMAT)
            .format(DateFormat(DateHelper.TIME_FORMAT).parse(value));
      default:
    }
    return value;
  }
}
