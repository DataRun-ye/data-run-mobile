import 'package:d_sdk/core/utilities/date_helper.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/data/form_instance.provider.dart';
import 'package:datarunmobile/data_run/screens/form/element/exceptions/form_element_exception.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data_run/screens/form/element/validation/form_element_validator.dart';
import 'package:datarunmobile/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_date_time_picker/reactive_date_time_picker.dart';

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
    final displayFormat = DateHelper.getEffectiveUiFormat(element.type);
    final viewFormat =
        DateFormat(DateHelper.getEffectiveUiFormat(element.type));
    final control =
        formInstance.form.control(element.elementPath!) as FormControl<String>;
    return ReactiveDateTimePicker(
      formControl: control,
      dateFormat: viewFormat,
      type: reactiveFieldType,
      validationMessages: validationMessages(),
      decoration: InputDecoration(
        labelText: element.label,
        enabled: control.enabled,
        suffixIcon: Icon(elementIcon),
      ),
    );
  }

  Future<DateTime?> showDateTimePickerD(
    BuildContext context, {
    DateTime? value,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? currentDate,
  }) async {
    final result = await showDatePicker(
      context: context,
      initialDate: value ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    );
    // await showDatePicker(
    //   context: context,
    //   initialDate: value ?? DateTime.now(),
    //   firstDate: firstDate ?? DateTime(2000),
    //   lastDate: lastDate ?? DateTime(2100),
    // );
    // final result = await _showCalendarDatePicker2Dialog(
    //   context,
    //   firstDate: firstDate,
    //   lastDate: lastDate,
    //   currentDate: currentDate,
    //   value: [value],
    //   calendarType: CalendarDatePicker2Type.single,
    // );

    return result;
  }

  // Future<void> _showPicker(BuildContext context,
  //     ReactiveFormFieldState<String, String> field,
  //     DateFormat format,
  //     DateTime first,
  //     DateTime last,) async {
  //   DateTime? pickedDate =
  //   field.value != null ? DateTime.tryParse(field.value!) : null;
  //   ReactiveDateTimePickerMode mode = dReactiveFieldType;
  //   if (mode == ReactiveDateTimePickerMode.date ||
  //       mode == ReactiveDateTimePickerMode.dateTime) {
  //     final date = await showDatePicker(
  //       context: context,
  //       initialDate: pickedDate ?? DateTime.now(),
  //       firstDate: first,
  //       lastDate: last,
  //     );
  //     if (date == null) return;
  //     pickedDate = date;
  //   }
  //
  //   TimeOfDay? pickedTime;
  //   if (mode == ReactiveDateTimePickerMode.time ||
  //       mode == ReactiveDateTimePickerMode.dateTime) {
  //     final initial = pickedDate != null
  //         ? TimeOfDay.fromDateTime(pickedDate)
  //         : TimeOfDay.now();
  //     final time = await showTimePicker(
  //       context: context,
  //       initialTime: initial,
  //     );
  //     if (time == null && mode == ReactiveDateTimePickerMode.time) return;
  //     pickedTime = time;
  //   }
  //
  //   // build a DateTime or just today's date+time
  //   DateTime result;
  //   if (mode == ReactiveDateTimePickerMode.time) {
  //     final now = DateTime.now();
  //     result = DateTime(
  //         now.year, now.month, now.day, pickedTime!.hour, pickedTime.minute);
  //   } else if (mode == ReactiveDateTimePickerMode.dateTime) {
  //     result = DateTime(pickedDate!.year, pickedDate.month, pickedDate.day,
  //         pickedTime!.hour, pickedTime.minute);
  //   } else {
  //     result = pickedDate!;
  //   }
  //
  //   // write back as ISO string
  //   // field.didChange(result.toIso8601String());
  //   field.didChange(DateHelper.formatUtc(result));
  // }

  ReactiveDatePickerFieldType get reactiveFieldType => switch (element.type) {
        ValueType.Date => ReactiveDatePickerFieldType.date,
        ValueType.DateTime => ReactiveDatePickerFieldType.dateTime,
        ValueType.Time => ReactiveDatePickerFieldType.time,
        _ => throw FormElementNotFoundException(element),
      };

  ReactiveDateTimePickerMode get dReactiveFieldType => switch (element.type) {
        ValueType.Date => ReactiveDateTimePickerMode.date,
        ValueType.DateTime => ReactiveDateTimePickerMode.dateTime,
        ValueType.Time => ReactiveDateTimePickerMode.time,
        _ => throw FormElementNotFoundException(element),
      };

  IconData get elementIcon => switch (element.type) {
        ValueType.Date => Icons.calendar_today,
        ValueType.Time => Icons.access_time,
        ValueType.DateTime => Icons.event,
        _ => Icons.event,
      };
}

/// Which type of picker to display.
enum ReactiveDateTimePickerMode {
  date,
  time,
  dateTime,
}
