import 'package:mass_pro/data_run/form/org_unit_d_configuration.dart';
import 'package:mass_pro/sdk/core/common/value_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'display_name_provider.g.dart';

@riverpod
DisplayNameProvider displayNameProvider(DisplayNameProviderRef ref) {
  return const DisplayNameProvider(OrgUnitDConfiguration());
}

class DisplayNameProvider {
  const DisplayNameProvider(this.orgUnitConfiguration);

  final OrgUnitDConfiguration orgUnitConfiguration;

  Future<String?> provideDisplayName(
      [ValueType? valueType, String? value]) async {
    if (value != null) {
      return _getValueTypeValue(value, valueType);
    }
    return value;
  }

  Future<String?> _getValueTypeValue(String value, ValueType? valueType) async {
    switch (valueType) {
      case ValueType.OrganisationUnit:
        return orgUnitConfiguration
            .orgUnitByUid(value)
            .then((orgUnit) => orgUnit?.displayName ?? orgUnit?.name ?? value);
      default:
        return value;
    }
  }
}
