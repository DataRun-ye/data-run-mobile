import 'package:datarunmobile/features/form_submission/presentation/field/reactive_date_time_picker/custom_reactive_date_picker.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FormGroup formGroup = fb.group({
    'date': FormControl<String>(
        value: DateTime.now().toIso8601String(), disabled: true),
    'time': FormControl<String>(value: DateTime.now().toIso8601String()),
    'dateTime': FormControl<String>(value: DateTime.now().toIso8601String()),
    'month': FormControl<String>(value: DateTime.now().toIso8601String()),
    'week': FormControl<String>(value: DateTime.now().toIso8601String()),
    'year': FormControl<String>(value: DateTime.now().toIso8601String()),
    'dateTimeNullable': FormControl<String>(value: null),
  });

  @override
  Widget build(BuildContext context) {
    final locale = Locale('en', 'en_us');
    return MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('ar', ''),
        Locale('en', 'en_us'),
      ],
      locale: Locale('ar', 'en_us'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: ReactiveForm(
              formGroup: formGroup,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  CustomReactiveDateTimePicker(
                    formControlName: 'date',
                    locale: locale,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                      helperText: '',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Time',
                      border: OutlineInputBorder(),
                      helperText: '',
                      filled: true,
                      fillColor: Colors.green,
                      // hoverColor: Colors.yellow,
                      suffixIcon: Icon(Icons.watch_later_outlined),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomReactiveDateTimePicker(
                    formControlName: 'time',
                    locale: locale,
                    type: ReactiveDatePickerFieldType.time,
                    decoration: const InputDecoration(
                      labelText: 'Time',
                      border: OutlineInputBorder(),
                      helperText: '',
                      filled: true,
                      fillColor: Colors.green,
                      // hoverColor: Colors.yellow,
                      suffixIcon: Icon(Icons.watch_later_outlined),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomReactiveDateTimePicker(
                    formControlName: 'year',
                    type: ReactiveDatePickerFieldType.year,
                    locale: locale,
                    decoration: const InputDecoration(
                      labelText: 'year',
                      border: OutlineInputBorder(),
                      helperText: '',
                      filled: true,
                      fillColor: Colors.green,
                      suffixIcon: Icon(Icons.calendar_view_month),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  CustomReactiveDateTimePicker(
                    formControlName: 'month',
                    type: ReactiveDatePickerFieldType.month,
                    locale: locale,
                    decoration: const InputDecoration(
                      labelText: 'Month',
                      border: OutlineInputBorder(),
                      helperText: '',
                      filled: true,
                      fillColor: Colors.green,
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomReactiveDateTimePicker(
                    formControlName: 'week',
                    locale: locale,
                    type: ReactiveDatePickerFieldType.week,
                    decoration: const InputDecoration(
                      labelText: 'Week',
                      border: OutlineInputBorder(),
                      helperText: '',
                      filled: true,
                      fillColor: Colors.green,
                      suffixIcon: Icon(Icons.calendar_view_week),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CustomReactiveDateTimePicker(
                          formControlName: 'dateTime',
                          locale: locale,
                          type: ReactiveDatePickerFieldType.dateTime,
                          decoration: const InputDecoration(
                            labelText: 'Date & Time',
                            border: OutlineInputBorder(),
                            helperText: '',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          valueBuilder: (_, value) => Text(
                            value ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                            decoration: const InputDecoration(
                          labelText: 'Date & Time',
                          border: OutlineInputBorder(),
                          helperText: '',
                          suffixIcon: Icon(Icons.calendar_today),
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CustomReactiveDateTimePicker(
                    formControlName: 'dateTimeNullable',
                    locale: locale,
                    type: ReactiveDatePickerFieldType.dateTime,
                    decoration: const InputDecoration(
                      labelText: 'Date & Time',
                      hintText: 'hintText',
                      border: OutlineInputBorder(),
                      helperText: 'helperText',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 1)),
                  ),
                  const SizedBox(height: 8),
                  CustomReactiveDateTimePicker(
                    formControlName: 'dateTimeNullable',
                    locale: locale,
                    type: ReactiveDatePickerFieldType.date,
                    decoration: const InputDecoration(
                      labelText: 'Date & Time',
                      hintText: 'hintText',
                      border: OutlineInputBorder(),
                      helperText: 'helperText',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: (context, value) async {
                      return (await showDateTimePickerD(context))
                          ?.toIso8601String();
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    child: const Text('Sign Up'),
                    onPressed: () {
                      showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(DateTime.now()));
                      if (formGroup.valid) {
                        // ignore: avoid_print
                        print(formGroup.value);
                      } else {
                        formGroup.markAllAsTouched();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
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

// Future<List<DateTime?>?> _showCalendarDatePicker2Dialog(
//     BuildContext context, {
//       required CalendarDatePicker2Type calendarType,
//       List<DateTime?> value = const [],
//       DateTime? firstDate,
//       DateTime? lastDate,
//       DateTime? currentDate,
//     }) async {
//
//   showCalendarDatePicker2Dialog(
//     value: value,
//     context: context,
//     config: calendarConfig(
//       context,
//       calendarType: calendarType,
//       firstDate: firstDate,
//       lastDate: lastDate,
//       currentDate: currentDate,
//     ),
//     dialogSize: const Size(360, 400),
//     borderRadius: BorderRadius.circular(16),
//     dialogBackgroundColor: Colors.white,
//   );
// }
//
// CalendarDatePicker2WithActionButtonsConfig calendarConfig(
//     BuildContext context, {
//       CalendarDatePicker2Type calendarType = CalendarDatePicker2Type.single,
//       DateTime? firstDate,
//       DateTime? lastDate,
//       DateTime? currentDate,
//     }) {
//   final primaryColor = Theme.of(context).primaryColor;
//
//   const dayTextStyle = TextStyle(
//     fontWeight: FontWeight.w700,
//   );
//
//   final firstDay = firstDate?.startOfDay();
//   final lastDay = lastDate?.startOfDay();
//
//   return CalendarDatePicker2WithActionButtonsConfig(
//     firstDate: firstDate,
//     lastDate: lastDate,
//     dayTextStyle: dayTextStyle,
//     calendarType: calendarType,
//     selectedDayHighlightColor: primaryColor,
//     closeDialogOnCancelTapped: true,
//     firstDayOfWeek: 1,
//     selectableDayPredicate: (day) =>
//     (firstDay == null || !day.isBefore(firstDay)) &&
//         (lastDay == null || !day.isAfter(lastDay)),
//     currentDate: currentDate,
//     weekdayLabelTextStyle: TextStyle(
//       color: primaryColor,
//       fontWeight: FontWeight.w500,
//     ),
//     controlsTextStyle: TextStyle(
//       color: primaryColor,
//       fontSize: 15,
//       fontWeight: FontWeight.w500,
//     ),
//     centerAlignModePicker: true,
//     customModePickerIcon: const SizedBox(),
//     selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
//     nextMonthIcon: Icon(
//       Icons.arrow_circle_right,
//       size: 20,
//       color: primaryColor,
//     ),
//     lastMonthIcon: Icon(
//       Icons.arrow_circle_left,
//       size: 20,
//       color: primaryColor,
//     ),
//     todayTextStyle: dayTextStyle.merge(TextStyle(color: primaryColor)),
//   );
// }

extension on DateTime {
  DateTime startOfDay() {
    return DateTime(year, month, day);
  }
}
