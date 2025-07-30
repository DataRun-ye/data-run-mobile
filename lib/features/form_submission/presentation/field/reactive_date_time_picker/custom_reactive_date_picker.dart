import 'package:d_sdk/core/utilities/date_helper.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reactive_date_time_picker/custom_date_pickers.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:flutter/material.dart' hide SelectableDayPredicate;
import 'package:intl/intl.dart' hide TextDirection;
import 'package:reactive_forms/reactive_forms.dart';

/// Extended types to include month-only and week-only pickers
enum ReactiveDatePickerFieldType {
  date,
  time,
  dateTime,
  month,
  week,
  year,
}

typedef GetInitialDate = DateTime Function(
    String? fieldValue, DateTime lastDate);
typedef GetInitialTime = TimeOfDay Function(String? fieldValue);

class CustomReactiveDateTimePicker
    extends ReactiveFocusableFormField<String, String> {
  CustomReactiveDateTimePicker({
    super.key,
    super.formControlName,
    super.formControl,
    ControlValueAccessor<String, String>? valueAccessor,
    super.validationMessages,
    super.showErrors,
    TextStyle? style,
    ReactiveDatePickerFieldType type = ReactiveDatePickerFieldType.date,
    InputDecoration? decoration,
    bool showClearIcon = true,
    Widget clearIcon = const Icon(Icons.clear),
    TransitionBuilder? builder,
    bool useRootNavigator = true,
    String? cancelText,
    String? confirmText,
    String? helpText,
    GetInitialDate? getInitialDate,
    DateFormat? dateFormat,
    DateTime? firstDate,
    DateTime? lastDate,
    DatePickerEntryMode datePickerEntryMode = DatePickerEntryMode.calendar,
    Locale? locale,
    TextDirection? textDirection,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
    RouteSettings? datePickerRouteSettings,
    TextInputType? keyboardType,
    Offset? anchorPoint,
    DateTime? currentDate,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    ValueChanged<DatePickerEntryMode>? onDatePickerModeChange,
    TimePickerEntryMode timePickerEntryMode = TimePickerEntryMode.dial,
    RouteSettings? timePickerRouteSettings,
    bool timePickerBarrierDismissible = true,
    Color? timePickerBarrierColor,
    String? timePickerBarrierLabel,
    String? hourLabelText,
    String? minuteLabelText,
    String? timePickerErrorInvalidText,
    EntryModeChangeCallback? onEntryModeChanged,
    Offset? timePickerAnchorPoint,
    Orientation? timePickerOrientation,
    Future<String?> Function(BuildContext context, String? value)? onTap,
    Widget Function(BuildContext context, String error)? errorBuilder,
    TextStyle? baseStyle,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    bool expands = false,
    MouseCursor cursor = SystemMouseCursors.click,
    ValueWidgetBuilder<String?>? valueBuilder,
    // Widget Function(BuildContext context, String? value)? valueBuilder,
    Icon? switchToInputEntryModeIcon,
    Icon? switchToCalendarEntryModeIcon,
  }) : super(
          valueAccessor:
              valueAccessor ?? _effectiveValueAccessor(type, dateFormat),
          builder: (field) {
            final isEmpty = field.value == null || field.value!.isEmpty;
            Widget? suffixIcon = decoration?.suffixIcon;
            if (showClearIcon && !isEmpty) {
              suffixIcon = InkWell(
                borderRadius: BorderRadius.circular(25),
                child: clearIcon,
                onTap: () {
                  field.control.markAsTouched();
                  field.didChange(null);
                },
              );
            }
            final deco = (decoration ?? const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                .copyWith(suffixIcon: suffixIcon);
            return HoverBuilder(builder: (context, isHovered) {
              return GestureDetector(
                onTap: () async {
                  field.control.focus();
                  final raw = field.control.value;
                  DateTime? initial =
                      _getInitialDate(raw, lastDate ?? DateTime(2100));

                  DateTime? pickedDate;
                  TimeOfDay? pickedTime;

                  switch (type) {
                    case ReactiveDatePickerFieldType.date:
                    case ReactiveDatePickerFieldType.dateTime:
                      pickedDate = await showDatePicker(
                        context: field.context,
                        initialDate: initial,
                        firstDate: firstDate ?? DateTime(1900),
                        lastDate: lastDate ?? DateTime(2100),
                        initialEntryMode: datePickerEntryMode,
                        helpText: helpText,
                        cancelText: cancelText,
                        confirmText: confirmText,
                        locale: locale,
                        useRootNavigator: useRootNavigator,
                        routeSettings: datePickerRouteSettings,
                        textDirection: textDirection,
                        builder: builder,
                        initialDatePickerMode: initialDatePickerMode,
                        errorFormatText: errorFormatText,
                        errorInvalidText: errorInvalidText,
                        fieldHintText: fieldHintText,
                        fieldLabelText: fieldLabelText,
                        keyboardType: keyboardType,
                        anchorPoint: anchorPoint,
                        barrierDismissible: barrierDismissible,
                        barrierColor: barrierColor,
                        barrierLabel: barrierLabel,
                        onDatePickerModeChange: onDatePickerModeChange,
                        switchToInputEntryModeIcon: switchToInputEntryModeIcon,
                        switchToCalendarEntryModeIcon:
                            switchToCalendarEntryModeIcon,
                      );
                      if (type == ReactiveDatePickerFieldType.dateTime &&
                          pickedDate != null) {
                        pickedTime = await showTimePicker(
                          context: field.context,
                          initialTime: _getInitialTime(raw),
                          builder: builder,
                          useRootNavigator: useRootNavigator,
                          initialEntryMode: timePickerEntryMode,
                          cancelText: cancelText,
                          confirmText: confirmText,
                          helpText: helpText,
                          routeSettings: timePickerRouteSettings,
                          barrierDismissible: timePickerBarrierDismissible,
                          barrierColor: timePickerBarrierColor,
                          barrierLabel: timePickerBarrierLabel,
                          errorInvalidText: timePickerErrorInvalidText,
                          hourLabelText: hourLabelText,
                          minuteLabelText: minuteLabelText,
                          onEntryModeChanged: onEntryModeChanged,
                          anchorPoint: timePickerAnchorPoint,
                          orientation: timePickerOrientation,
                        );
                      }
                      break;
                    case ReactiveDatePickerFieldType.time:
                      pickedTime = await showTimePicker(
                        context: field.context,
                        initialTime: _getInitialTime(raw),
                        builder: builder,
                        useRootNavigator: useRootNavigator,
                        initialEntryMode: timePickerEntryMode,
                        cancelText: cancelText,
                        confirmText: confirmText,
                        helpText: helpText,
                        routeSettings: timePickerRouteSettings,
                        barrierDismissible: timePickerBarrierDismissible,
                        barrierColor: timePickerBarrierColor,
                        barrierLabel: timePickerBarrierLabel,
                        errorInvalidText: timePickerErrorInvalidText,
                        hourLabelText: hourLabelText,
                        minuteLabelText: minuteLabelText,
                        onEntryModeChanged: onEntryModeChanged,
                        anchorPoint: timePickerAnchorPoint,
                        orientation: timePickerOrientation,
                      );
                      break;
                    case ReactiveDatePickerFieldType.month:
                      final picked = await CustomDatePickers.showMonthPicker(
                        context: field.context,
                        selectedDate: initial,
                        firstDate: DateTime.now()
                            .subtract(const Duration(days: 365 * 2)),
                        lastDate:
                            DateTime.now().add(const Duration(days: 365 * 2)),
                        selectedDateStyleColor: Colors.white,
                        selectedSingleDateDecorationColor: Colors.deepPurple,
                      );

                      if (picked != null && picked != initial) {
                        pickedDate = picked;
                      }
                      break;
                    case ReactiveDatePickerFieldType.week:
                      final picked = await CustomDatePickers.showWeekPicker(
                        context: field.context,
                        selectedDate: initial,
                        firstDate: firstDate,
                        lastDate: lastDate,
                        firstDayOfWeekIndex: 1,
                      );

                      if (picked != null && picked != initial) {
                        pickedDate = picked;
                      }
                      break;
                    case ReactiveDatePickerFieldType.year:
                      final picked = await CustomDatePickers.showYearPicker(
                        context: field.context,
                        selectedDate: initial,
                        firstDate: firstDate,
                        lastDate: lastDate,
                        selectedDateStyleColor: Colors.white,
                        selectedSingleDateDecorationColor: Colors.orange,
                      );
                      if (picked != null && picked != initial) {
                        pickedDate = picked;
                      }
                      break;
                  }

                  if ((pickedDate != null) || (pickedTime != null)) {
                    final combined = _combine(pickedDate, pickedTime);
                    final iso = combined.toIso8601String();
                    field.didChange(_effectiveValueAccessor(type, dateFormat)
                        .modelToViewValue(iso));
                  }

                  field.control.unfocus();
                  field.control.markAsTouched();
                },
                child: InputDecorator(
                  isHovering: isHovered,
                  isFocused: field.control.hasFocus,
                  isEmpty: isEmpty,
                  baseStyle: baseStyle,
                  textAlign: textAlign,
                  textAlignVertical: textAlignVertical,
                  expands: expands,
                  decoration: deco.copyWith(
                    enabled: field.control.enabled,
                    errorText: errorBuilder == null ? field.errorText : null,
                    error: errorBuilder != null && field.errorText != null
                        ? DefaultTextStyle.merge(
                            style: Theme.of(field.context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color:
                                      Theme.of(field.context).colorScheme.error,
                                )
                                .merge(deco.errorStyle),
                            child: errorBuilder.call(
                              field.context,
                              field.errorText!,
                            ),
                          )
                        : null,
                  ),
                  child: DefaultTextStyle.merge(
                    style: Theme.of(field.context)
                        .textTheme
                        .titleMedium
                        ?.merge(style)
                        .copyWith(
                          color: !field.control.enabled
                              ? Theme.of(field.context).disabledColor
                              : null,
                        ),
                    child: valueBuilder?.call(
                            field.context,
                            field.value,
                            Text(
                              // textAlign: TextAlign.center,
                              field.value ?? '',
                              textDirection: textDirection,
                              style: Theme.of(field.context)
                                  .inputDecorationTheme
                                  .labelStyle
                                  ?.copyWith(),
                            )) ??
                        Text(
                          // textAlign: TextAlign.center,
                          field.value ?? '',
                          textDirection: textDirection,
                          style: Theme.of(field.context)
                              .inputDecorationTheme
                              .labelStyle
                              ?.copyWith(),
                        ),
                  ),
                ),
                // InputDecorator(
                //   decoration: deco.copyWith(errorText: field.errorText),
                //   child: valueBuilder?.call(field.context, field.value, ) ??
                //       Text(
                //         field.value ?? '',
                //         style: Theme.of(field.context)
                //             .textTheme
                //             .titleMedium
                //             ?.merge(style),
                //       ),
                // ),
              );
            });
          },
        );

  // Value accessor including month/week formats
  static ControlValueAccessor<String, String> _effectiveValueAccessor(
      ReactiveDatePickerFieldType type, DateFormat? dateFormat) {
    switch (type) {
      case ReactiveDatePickerFieldType.date:
        return _DefaultAccessor(
            dateFormat ?? DateFormat(DateHelper.UI_DATE_FORMAT, 'en_US'));
      case ReactiveDatePickerFieldType.time:
        return _DefaultAccessor(
            dateFormat ?? DateFormat(DateHelper.TIME_FORMAT, 'en_US'));
      case ReactiveDatePickerFieldType.dateTime:
        return _DefaultAccessor(dateFormat ??
            DateFormat(DateHelper.DATE_TIME_FORMAT_EXPRESSION, 'en_US'));
      case ReactiveDatePickerFieldType.month:
        return _DefaultAccessor(
            dateFormat ?? DateFormat(DateHelper.UI_DATE_FORMAT, 'en_US'));
      case ReactiveDatePickerFieldType.week:
        return _DefaultAccessor(
            dateFormat ?? DateFormat(DateHelper.UI_DATE_FORMAT, 'en_US'));
      case ReactiveDatePickerFieldType.year:
        return _DefaultAccessor(
            dateFormat ?? DateFormat(DateHelper.UI_DATE_FORMAT, 'en_US'));
    }
  }

  static DateTime _combine(DateTime? date, TimeOfDay? time) {
    final d = date ?? DateTime.now();
    return DateTime(d.year, d.month, d.day, time?.hour ?? 0, time?.minute ?? 0);
  }

  static TimeOfDay _getInitialTime(dynamic raw) {
    final dt = raw != null ? DateTime.tryParse(raw) : null;
    return dt != null
        ? TimeOfDay(hour: dt.hour, minute: dt.minute)
        : TimeOfDay.now();
  }

  static DateTime _getInitialDate(String? raw, DateTime lastDate) {
    final dt = raw != null ? DateTime.tryParse(raw) : null;
    final now = DateTime.now();
    if (dt != null) return dt;
    return now.isAfter(lastDate) ? lastDate : now;
  }
}

/// Default accessor for formatting values
class _DefaultAccessor extends ControlValueAccessor<String, String> {
  _DefaultAccessor(this.fmt);

  final DateFormat fmt;

  @override
  String? modelToViewValue(String? modelValue) {
    if (modelValue == null) return null;
    final dt = DateTime.tryParse(modelValue);
    if (dt == null) return modelValue;
    return fmt.format(dt);
  }

  @override
  String? viewToModelValue(String? viewValue) => viewValue;
}

int getIsoWeekNumber(DateTime date) {
  final dayOfYear = int.parse(DateFormat('D').format(date));
  return ((dayOfYear - date.weekday + 10) / 7).floor();
}

DateTime getStartOfWeek(DateTime date) =>
    date.subtract(Duration(days: date.weekday - 1));
