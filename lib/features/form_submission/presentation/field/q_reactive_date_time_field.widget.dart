import 'package:d_sdk/core/utilities/date_helper.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/ui/factories/hint_provider.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reactive_date_time_picker/custom_date_pickers.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reactive_date_time_picker/custom_reactive_date_picker.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:reactive_forms/reactive_forms.dart';

/// A field that can pick Date, Time, or Date+Time, storing the result
/// in a [FormControl<String>] as an ISO‐8601 string.
class QReactiveDateTimeFormField extends ConsumerWidget {
  const QReactiveDateTimeFormField({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final formInstance = ref
    //     .watch(
    //         formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
    //     .requireValue;
    final formInstance = appLocator<FormInstance>();

    final viewFormat = DateHelper.getEffectiveUiFormat(element.type);
    final control =
        formInstance.form.control(element.elementPath!) as FormControl<String>;
    return CustomReactiveDateTimePicker(
      formControl: control,
      dateFormat: viewFormat,
      textDirection: TextDirection.ltr,
      type: reactiveFieldType,
      validationMessages: validationMessages(),
      decoration: InputDecoration(
        labelText: element.label,
        enabled: control.enabled,
        prefixIcon: Icon(elementIcon),
        hintText: appLocator<HintProvider>().provideHint(element.type),
      ),
      valueBuilder: customValueBuilder ? valueBuilder : null,
    );
  }

  bool get customValueBuilder => switch (element) {
        FieldInstance(:final type)
            when type == ValueType.Date &&
                (element.template.properties.values.contains('month') ||
                    element.template.appearance.contains('month')) =>
          true,

        //
        FieldInstance(:final type)
            when type == ValueType.Date &&
                (element.template.properties.values.contains('week') ||
                    element.template.appearance.contains('week')) =>
          true,
        //
        FieldInstance(:final type)
            when type == ValueType.Date &&
                (element.template.properties.values.contains('year') ||
                    element.template.appearance.contains('year')) =>
          true,
        _ => false,
      };

  Widget valueBuilder(BuildContext context, String? value, Widget? child) {
    if (value == null || DateTime.tryParse(value) == null) return Text('');
    final date = DateTime.parse(value);

    return switch (element) {
      FieldInstance(:final type)
          when type == ValueType.Date &&
              (element.template.properties.values.contains('month') ||
                  element.template.appearance.contains('month')) =>
        Text(DateFormat.yMMMM().format(date)),

      //
      FieldInstance(:final type)
          when type == ValueType.Date &&
              (element.template.properties.values.contains('week') ||
                  element.template.appearance.contains('week')) =>
        Text(
            '${date.year}, ${S.of(context).week(CustomDatePickers.getWeekNumber(date).toString().padLeft(2, '0'))}'),
      //
      FieldInstance(:final type)
          when type == ValueType.Date &&
              (element.template.properties.values.contains('year') ||
                  element.template.appearance.contains('year')) =>
        Text(DateFormat.y().format(date)),
      _ => child!,
    };
  }

  ReactiveDatePickerFieldType get reactiveFieldType => switch (element) {
        FieldInstance(:final type)
            when type == ValueType.Date &&
                (element.template.properties.values.contains('month') ||
                    element.template.appearance.contains('month')) =>
          ReactiveDatePickerFieldType.month,
        FieldInstance(:final type)
            when type == ValueType.Date &&
                (element.template.properties.values.contains('week') ||
                    element.template.appearance.contains('week')) =>
          ReactiveDatePickerFieldType.week,
        FieldInstance(:final type)
            when type == ValueType.Date &&
                (element.template.properties.values.contains('year') ||
                    element.template.appearance.contains('year')) =>
          ReactiveDatePickerFieldType.year,
        FieldInstance(:final type) when type == ValueType.Date =>
          ReactiveDatePickerFieldType.date,
        FieldInstance(:final type) when type == ValueType.DateTime =>
          ReactiveDatePickerFieldType.dateTime,
        FieldInstance(:final type) when type == ValueType.Time =>
          ReactiveDatePickerFieldType.time,
        FieldInstance<String>() => throw UnimplementedError(),
      };

  IconData get elementIcon => switch (element) {
        FieldInstance(:final type)
            when type == ValueType.Date &&
                (element.template.properties.values.contains('month') ||
                    element.template.appearance.contains('month')) =>
          Icons.calendar_month,
        FieldInstance(:final type)
            when type == ValueType.Date &&
                (element.template.properties.values.contains('week') ||
                    element.template.appearance.contains('week')) =>
          Icons.calendar_view_week,
        FieldInstance(:final type)
            when type == ValueType.Date &&
                (element.template.properties.values.contains('year') ||
                    element.template.appearance.contains('year')) =>
          Icons.calendar_month_outlined,
        FieldInstance(:final type) when type == ValueType.Date =>
          Icons.calendar_today,
        FieldInstance(:final type) when type == ValueType.DateTime =>
          Icons.access_time,
        FieldInstance(:final type) when type == ValueType.Time => Icons.event,
        FieldInstance<String>() => throw UnimplementedError(),
      };
}

/// Which type of picker to display.
enum ReactiveDateTimePickerMode {
  date,
  time,
  dateTime,
}
