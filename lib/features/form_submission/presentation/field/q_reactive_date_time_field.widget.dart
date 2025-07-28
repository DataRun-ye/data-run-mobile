import 'package:d_sdk/core/utilities/date_helper.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/ui/factories/hint_provider.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reactive_date_time_picker/custom_reactive_date_picker.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A field that can pick Date, Time, or Date+Time, storing the result
/// in a [FormControl<String>] as an ISO‐8601 string.
class QReactiveDateTimeFormField extends ConsumerWidget {
  const QReactiveDateTimeFormField({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;
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
        suffixIcon: Icon(elementIcon),
        hintText: appLocator<HintProvider>().provideHint(element.type),
      ),
    );
  }

  ReactiveDatePickerFieldType get reactiveFieldType => switch (element) {
        FieldInstance(:final type) when type == ValueType.Date =>
          ReactiveDatePickerFieldType.date,
        FieldInstance(:final type) when type == ValueType.DateTime =>
          ReactiveDatePickerFieldType.dateTime,
        FieldInstance(:final type) when type == ValueType.Time =>
          ReactiveDatePickerFieldType.time,
        FieldInstance(:final type)
            when type?.isDateTime == true &&
                element.template.appearance.contains('month') =>
          ReactiveDatePickerFieldType.month,
        FieldInstance(:final type)
            when type?.isDateTime == true &&
                element.template.appearance.contains('week') =>
          ReactiveDatePickerFieldType.week,
        FieldInstance(:final type)
            when type?.isDateTime == true &&
                element.template.appearance.contains('year') =>
          ReactiveDatePickerFieldType.year,
        FieldInstance<String>() => throw UnimplementedError(),
      };

  IconData get elementIcon => switch (element) {
        FieldInstance(:final type) when type == ValueType.Date =>
          Icons.calendar_today,
        FieldInstance(:final type) when type == ValueType.DateTime =>
          Icons.access_time,
        FieldInstance(:final type) when type == ValueType.Time => Icons.event,
        FieldInstance(:final type)
            when type?.isDateTime == true &&
                element.template.appearance.contains('month') =>
          Icons.calendar_month,
        FieldInstance(:final type)
            when type?.isDateTime == true &&
                element.template.appearance.contains('week') =>
          Icons.calendar_view_week,
        FieldInstance(:final type)
            when type?.isDateTime == true &&
                element.template.appearance.contains('year') =>
          Icons.calendar_month_outlined,
        FieldInstance<String>() => throw UnimplementedError(),
      };
}

/// Which type of picker to display.
enum ReactiveDateTimePickerMode {
  date,
  time,
  dateTime,
}
