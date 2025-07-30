import 'dart:async';

import 'package:d_sdk/core/utilities/date_helper.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/commons/extensions/string_extension.dart';
import 'package:datarunmobile/core/element_instance/data_value_repository.dart';
import 'package:datarunmobile/core/resources/resource_manager.provider.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/age/age_value.dart';
import 'package:injectable/injectable.dart';

@injectable
class MapValueToDisplay {
  MapValueToDisplay({required this.resources, required this.repository});

  final ResourceManager resources;
  final DataValueRepository repository;

  FutureOr<String?> map(ValueType type, dynamic value) {
    return switch (type) {
      ValueType.YesNo => !value.isNullOrEmpty
          ? resources.getString(value.toString())
          : value.toString(),
      ValueType.Boolean || ValueType.TrueOnly => !value.isNullOrEmpty
          ? value.toBoolean()
              ? resources.getString('yes')
              : resources.getString('no')
          : value.toString(),
      ValueType.OrganisationUnit => value is String && !value.isNullOrEmpty
          ? repository.getOrgUnitById(value)
          : value.toString(),
      ValueType.Team => value is String && !value.isNullOrEmpty
          ? repository.getTeamById(value)
          : value.toString(),
      ValueType.SelectOne => value is String && !value.isNullOrEmpty
          ? repository.getOptionById(value)
          : value.toString(),
      ValueType.SelectMulti => value is List && !value.isNotEmpty
          ? repository.getOptionsByIds(value.cast<String>())
          : value.toString(),
      _ => value,
    };
  }

  /// reference date e.g date submission created, or entry started...
  String getAgeValue(String? value, DateTime referenceDate) {
    return value != null && value.toDate() != null
        ? AgeValue(dateOfBirth: value.toDate()!).years(referenceDate).toString()
        : '--';
  }

  /// reference date e.g date submission created, or entry started...
  String getDateValue(ValueType type, Object? value) {
    return value != null && value is String && value.toDate() != null
        ? DateHelper.getEffectiveUiFormat(type).format(value.toDate()!)
        : '--';
  }
}
