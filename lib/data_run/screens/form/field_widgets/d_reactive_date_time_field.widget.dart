// import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
// import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
// import 'package:datarunmobile/data/form_instance.provider.dart';
// import 'package:datarunmobile/data_run/screens/form/element/exceptions/form_element_exception.dart';
// import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
// import 'package:datarunmobile/data_run/screens/form/element/validation/form_element_validator.dart';
// import 'package:datarunmobile/data_run/screens/form/field_widgets/reactive_date_time_picker/reactive_date_time_picker.dart';
// import 'package:datarunmobile/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:reactive_forms/reactive_forms.dart';
//
// /// A field that can pick Date, Time, or Date+Time, storing the result
// /// in a [FormControl<String>] as an ISO‐8601 string.
// class DReactiveDateTimeFormField extends ConsumerWidget {
//   const DReactiveDateTimeFormField({super.key, required this.element});
//
//   final FieldInstance<String> element;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final formInstance = ref
//         .watch(
//             formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
//         .requireValue;
//     final displayFormat = getEffectiveUiFormat(element.type);
//     return ReactiveFormField<String, String>(
//       formControl: formInstance.form.control(element.elementPath!)
//           as FormControl<String>,
//       valueAccessor: _DateTimeValueAccessor(
//           displayFormat: getEffectiveUiFormat(element.type)),
//       validationMessages: validationMessages(),
//       builder: (field) {
//         final effectiveFirst = DateTime(1990);
//         final effectiveLast = DateTime(2060);
//         final effectiveFormat = DateFormat(displayFormat);
//         return InputDecorator(
//           decoration: InputDecoration(
//             labelText: element.label,
//             enabled: field.control.enabled,
//             errorText: field.errorText,
//             suffixIcon: IconButton(
//               icon: Icon(elementIcon),
//               onPressed: field.control.enabled
//                   ? () => _showPicker(context, field, effectiveFormat,
//                       effectiveFirst, effectiveLast)
//                   : null,
//             ),
//           ),
//           child: Text(
//             field.value ?? '',
//             // style: field.control.enabled
//             //     ? null
//             //     : Theme.of(context).textTheme.bodySmall?.copyWith(
//             //               color: Colors.grey,
//             //             ) ??
//             //         TextStyle(color: Colors.grey),
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _showPicker(
//     BuildContext context,
//     ReactiveFormFieldState<String, String> field,
//     DateFormat format,
//     DateTime first,
//     DateTime last,
//   ) async {
//     DateTime? pickedDate =
//         field.value != null ? DateTime.tryParse(field.value!) : null;
//     ReactiveDateTimePickerMode mode = dReactiveFieldType;
//     if (mode == ReactiveDateTimePickerMode.date ||
//         mode == ReactiveDateTimePickerMode.dateTime) {
//       final date = await showDatePicker(
//         context: context,
//         initialDate: pickedDate ?? DateTime.now(),
//         firstDate: first,
//         lastDate: last,
//       );
//       if (date == null) return;
//       pickedDate = date;
//     }
//
//     TimeOfDay? pickedTime;
//     if (mode == ReactiveDateTimePickerMode.time ||
//         mode == ReactiveDateTimePickerMode.dateTime) {
//       final initial = pickedDate != null
//           ? TimeOfDay.fromDateTime(pickedDate)
//           : TimeOfDay.now();
//       final time = await showTimePicker(
//         context: context,
//         initialTime: initial,
//       );
//       if (time == null && mode == ReactiveDateTimePickerMode.time) return;
//       pickedTime = time;
//     }
//
//     // build a DateTime or just today's date+time
//     DateTime result;
//     if (mode == ReactiveDateTimePickerMode.time) {
//       final now = DateTime.now();
//       result = DateTime(
//           now.year, now.month, now.day, pickedTime!.hour, pickedTime.minute);
//     } else if (mode == ReactiveDateTimePickerMode.dateTime) {
//       result = DateTime(pickedDate!.year, pickedDate.month, pickedDate.day,
//           pickedTime!.hour, pickedTime.minute);
//     } else {
//       result = pickedDate!;
//     }
//
//     // write back as ISO string
//     // field.didChange(result.toIso8601String());
//     field.didChange(DateHelper.formatUtc(result));
//   }
//
//   ReactiveDatePickerFieldType get reactiveFieldType => switch (element.type) {
//         ValueType.Date => ReactiveDatePickerFieldType.date,
//         ValueType.DateTime => ReactiveDatePickerFieldType.dateTime,
//         ValueType.Time => ReactiveDatePickerFieldType.time,
//         _ => throw FormElementNotFoundException(element),
//       };
//
//   ReactiveDateTimePickerMode get dReactiveFieldType => switch (element.type) {
//         ValueType.Date => ReactiveDateTimePickerMode.date,
//         ValueType.DateTime => ReactiveDateTimePickerMode.dateTime,
//         ValueType.Time => ReactiveDateTimePickerMode.time,
//         _ => throw FormElementNotFoundException(element),
//       };
//
//   IconData get elementIcon => switch (element.type) {
//         ValueType.Date => Icons.calendar_today,
//         ValueType.Time => Icons.access_time,
//         ValueType.DateTime => Icons.event,
//         _ => Icons.event,
//       };
//
//   static String getEffectiveUiFormat(ValueType? valueType) =>
//       switch (valueType) {
//         ValueType.Date => DateHelper.UI_DATE_FORMAT,
//         ValueType.Time => DateHelper.TIME_FORMAT,
//         _ => DateHelper.DATE_TIME_FORMAT_EXPRESSION,
//       };
// }
//
// /// Converts between ISO String in the model and formatted text in the UI.
// class _DateTimeValueAccessor extends ControlValueAccessor<String, String> {
//   _DateTimeValueAccessor({this.displayFormat});
//
//   final String? displayFormat;
//
//   @override
//   String? modelToViewValue(String? modelValue) {
//     if (modelValue == null) return null;
//     final dt = DateTime.tryParse(modelValue);
//     if (dt == null) return modelValue;
//     return DateFormat(displayFormat ?? 'yMMMd – HH:mm').format(dt);
//   }
//
//   @override
//   String? viewToModelValue(String? viewValue) {
//     // we never read back from UI text, only from picker
//     return viewValue;
//   }
// }
//
// /// Which type of picker to display.
// enum ReactiveDateTimePickerMode {
//   date,
//   time,
//   dateTime,
// }
