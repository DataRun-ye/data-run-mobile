import 'dart:async';

import 'package:datarunmobile/core/data_instance/field_value.dart';
import 'package:datarunmobile/core/util/string_extension.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/core/element_instance/display_value_lookup.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/age/age_value.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reactive_date_time_picker/custom_date_pickers.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class MapValueToDisplay {
  MapValueToDisplay({required this.lookup});

  final DisplayValueLookup lookup;

  FutureOr<String?> map(ValueType type, dynamic value) {
    return switch (type) {
      ValueType.Boolean ||
      ValueType.TrueOnly ||
      ValueType.YesNo =>
        value is String && value.isNotNullOrEmpty
            ? value.toBoolean()
                ? Intl.message('yes')
                : Intl.message('no')
            : value.toString(),
      ValueType.OrganisationUnit => value is String && value.isNotNullOrEmpty
          ? lookup.getOrgUnitById(value)
          : value.toString(),
      ValueType.Team => value is String && value.isNotNullOrEmpty
          ? lookup.getTeamById(value)
          : value.toString(),
      ValueType.SelectOne || ValueType.SelectMulti => value is String
          ? lookup.getOptionsByIds(value.split(','))
          : (value is List
              ? lookup.getOptionsByIds(value.cast<String>())
              : value?.toString()),
      _ => value,
    };
  }

  /// reference date e.g date submission created, or entry started...
  String getAgeValue(String? value, {DateTime? referenceDate}) {
    return value != null && value.toDate() != null && referenceDate != null
        ? AgeValue(dateOfBirth: value.toDate()!).years(referenceDate).toString()
        : '--';
  }

  String getFormatedValue(FieldValue? field, {DateFormat? fallbackFormat}) {
    if (field?.value == null) return '';
    if (DateTime.tryParse(field!.value!.toString()) == null)
      return '${field.value}';

    final date = DateTime.parse(field.value!.toString());

    return switch (field) {
      FieldValue(:final valueType)
          when valueType == ValueType.Date &&
              (field.properties.values.contains('month') ||
                  field.appearance.contains('month')) =>
        DateFormat.yMMMM().format(date),

      //
      FieldValue(:final valueType)
          when valueType == ValueType.Date &&
              (field.properties.values.contains('week') ||
                  field.appearance.contains('week')) =>
        '${date.year}, ${S.current.week(CustomDatePickers.getWeekNumber(date).toString().padLeft(2, '0'))}',
      //
      FieldValue(:final valueType)
          when valueType == ValueType.Date &&
              (field.properties.values.contains('year') ||
                  field.appearance.contains('year')) =>
        DateFormat.y().format(date),
      _ => DateFormat.yMMMMEEEEd().add_jm().format(date.toLocal()),
    };
  }
}
