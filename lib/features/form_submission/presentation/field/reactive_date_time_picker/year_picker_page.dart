// import 'package:d_sdk/core/logging/new_app_logging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
// import 'package:flutter_date_pickers/flutter_date_pickers.dart';
//
// /// A utility class to show custom week and month picker dialogs.
// class CustomDatePickers {
//   // Helper to calculate week number (ISO 8601 standard)
//   static int getWeekNumber(DateTime date) {
//     // Adjust date to be Monday of the week for consistent week number calculation
//     DateTime mondayOfCurrentWeek =
//         date.subtract(Duration(days: date.weekday == 7 ? 6 : date.weekday - 1));
//     DateTime firstDayOfYear = DateTime(mondayOfCurrentWeek.year, 1, 1);
//     // Find the first Monday of the year
//     DateTime firstMondayOfYear = firstDayOfYear.weekday == 1
//         ? firstDayOfYear
//         : firstDayOfYear.add(Duration(days: (8 - firstDayOfYear.weekday) % 7));
//
//     if (mondayOfCurrentWeek.isBefore(firstMondayOfYear)) {
//       // If the date is before the first Monday of the current year,
//       // it belongs to the last week of the previous year.
//       return getWeekNumber(DateTime(mondayOfCurrentWeek.year - 1, 12,
//           28)); // A date in the last week of previous year
//     }
//
//     int daysSinceFirstMonday =
//         mondayOfCurrentWeek.difference(firstMondayOfYear).inDays;
//     return (daysSinceFirstMonday ~/ 7) + 1;
//   }
//
//   /// Show a month-only picker dialog.
//   ///
//   /// Returns the selected [DateTime] or `null` if the dialog is dismissed.
//   static Future<DateTime?> showMonthPicker({
//     required BuildContext context,
//     Color? selectedDateStyleColor,
//     Color? selectedSingleDateDecorationColor,
//     DateTime? selectedDate,
//     DateTime? firstDate,
//     DateTime? lastDate,
//   }) async {
//     DateTime _selectedDate = selectedDate ?? DateTime.now();
//     final DateTime _firstDate =
//         firstDate ?? DateTime.now().subtract(const Duration(days: 365 * 5));
//     final DateTime _lastDate =
//         lastDate ?? DateTime.now().add(const Duration(days: 365 * 5));
//
//     return await showDialog<DateTime>(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: const Text('Select Month'),
//           content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               // Apply custom styles or use default theme colors
//               DatePickerStyles styles = DatePickerStyles(
//                 selectedDateStyle: Theme.of(context)
//                     .textTheme
//                     .bodyLarge
//                     ?.copyWith(
//                         color: selectedDateStyleColor ??
//                             Theme.of(context).colorScheme.onSecondary),
//                 selectedSingleDateDecoration: BoxDecoration(
//                   color: selectedSingleDateDecorationColor ??
//                       Theme.of(context).colorScheme.secondary,
//                   shape: BoxShape.circle,
//                 ),
//               );
//
//               return SizedBox(
//                 width: MediaQuery.of(context).size.width *
//                     0.8, // Make it responsive
//                 height:
//                     MediaQuery.of(context).size.height * 0.6, // Adjust height
//                 child: MonthPicker.single(
//                   selectedDate: _selectedDate,
//                   onChanged: (newDate) {
//                     setState(() {
//                       _selectedDate = newDate;
//                     });
//                   },
//                   firstDate: _firstDate,
//                   lastDate: _lastDate,
//                   datePickerStyles: styles,
//                 ),
//               );
//             },
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(dialogContext, null); // Return null on cancel
//               },
//               child: const Text('CANCEL'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(
//                     dialogContext, _selectedDate); // Return selected date on OK
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   /// Show a week-only picker dialog.
//   ///
//   /// Returns the start [DateTime] of the selected week or `null` if the dialog is dismissed.
//   static Future<DateTime?> showWeekPicker({
//     required BuildContext context,
//     int? firstDayOfWeekIndex,
//     Color? selectedPeriodStartColor,
//     Color? selectedPeriodLastColor,
//     Color? selectedPeriodMiddleColor,
//     DateTime? selectedDate,
//     DateTime? firstDate,
//     DateTime? lastDate,
//     EventDecorationBuilder? eventDecorationBuilder,
//   }) async {
//     DateTime _selectedDate = selectedDate ?? DateTime.now();
//     final DateTime _firstDate =
//         firstDate ?? DateTime.now().subtract(const Duration(days: 365 * 5));
//     final DateTime _lastDate =
//         lastDate ?? DateTime.now().add(const Duration(days: 365 * 5));
//
//     // Initialize _selectedPeriod based on _selectedDate for initial display
//     // We need to ensure the _selectedPeriod reflects the week of _selectedDate
//     // The WeekPicker itself will highlight the correct week.
//     // Here we just create a period for the display text.
//     int effectiveFirstDayOfWeekIndex =
//         firstDayOfWeekIndex ?? 1; // Default to Monday
//     DateTime initialWeekStart = _selectedDate.subtract(Duration(
//         days: (_selectedDate.weekday - effectiveFirstDayOfWeekIndex + 7) % 7));
//     DatePeriod _selectedPeriod = DatePeriod(
//         initialWeekStart, initialWeekStart.add(const Duration(days: 6)));
//
//     return await showDialog<DateTime>(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: const Text('Select Week'),
//           content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               // // Initialize _selectedPeriod based on _selectedDate for initial display
//               // // We need to ensure the _selectedPeriod reflects the week of _selectedDate
//               // // The WeekPicker itself will highlight the correct week.
//               // // Here we just create a period for the display text.
//               // int effectiveFirstDayOfWeekIndex = firstDayOfWeekIndex ?? 1; // Default to Monday
//               // DateTime initialWeekStart = _selectedDate.subtract(
//               //     Duration(days: (_selectedDate.weekday - effectiveFirstDayOfWeekIndex + 7) % 7));
//               // DatePeriod _selectedPeriod = DatePeriod(initialWeekStart, initialWeekStart.add(const Duration(days: 6)));
//
//               DatePickerRangeStyles styles = DatePickerRangeStyles(
//                 firstDayOfWeekIndex: effectiveFirstDayOfWeekIndex,
//                 selectedPeriodLastDecoration: BoxDecoration(
//                   color: selectedPeriodLastColor ??
//                       Theme.of(context).colorScheme.secondary,
//                   borderRadius: const BorderRadiusDirectional.only(
//                     topEnd: Radius.circular(10.0),
//                     bottomEnd: Radius.circular(10.0),
//                   ),
//                 ),
//                 selectedPeriodStartDecoration: BoxDecoration(
//                   color: selectedPeriodStartColor ??
//                       Theme.of(context).colorScheme.secondary,
//                   borderRadius: const BorderRadiusDirectional.only(
//                     topStart: Radius.circular(10.0),
//                     bottomStart: Radius.circular(10.0),
//                   ),
//                 ),
//                 selectedPeriodMiddleDecoration: BoxDecoration(
//                   color: selectedPeriodMiddleColor ??
//                       Theme.of(context)
//                           .colorScheme
//                           .secondary
//                           .withValues(alpha: 0.5),
//                   shape: BoxShape.rectangle,
//                 ),
//               );
//
//               return SizedBox(
//                 width: MediaQuery.of(context).size.width *
//                     0.8, // Make it responsive
//                 height:
//                     MediaQuery.of(context).size.height * 0.6, // Adjust height
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         'Selected: Week ${getWeekNumber(_selectedPeriod.start)} of ${_selectedPeriod.start.year}',
//                         style: Theme.of(context).textTheme.titleMedium,
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Expanded(
//                       child: WeekPicker(
//                         selectedDate: _selectedDate,
//                         onChanged: (newPeriod) {
//                           setState(() {
//                             _selectedDate = newPeriod
//                                 .start; // Update selected date to start of the week
//                             _selectedPeriod =
//                                 newPeriod; // Store the full period
//                           });
//                         },
//                         firstDate: _firstDate,
//                         lastDate: _lastDate,
//                         datePickerStyles: styles,
//                         onSelectionError: (e) {
//                           logDebug('Selection error: $e');
//                         },
//                         eventDecorationBuilder: eventDecorationBuilder,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(dialogContext, null); // Return null on cancel
//               },
//               child: const Text('CANCEL'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Return the start date of the selected period
//                 Navigator.pop(dialogContext, _selectedPeriod.start);
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   /// Show a year-only picker dialog.
//   ///
//   /// Returns the selected [DateTime] (representing the start of the year) or `null` if the dialog is dismissed.
//   static Future<DateTime?> showYearPicker({
//     required BuildContext context,
//     Color? selectedDateStyleColor,
//     Color? selectedSingleDateDecorationColor,
//     DateTime? selectedDate,
//     DateTime? firstDate,
//     DateTime? lastDate,
//   }) async {
//     DateTime _selectedDate = selectedDate ?? DateTime.now();
//     final DateTime _firstDate =
//         firstDate ?? DateTime(DateTime.now().year - 50); // 50 years back
//     final DateTime _lastDate =
//         lastDate ?? DateTime(DateTime.now().year + 50); // 50 years forward
//
//     return await showDialog<DateTime>(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: const Text('Select Year'),
//           content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               // Apply custom styles or use default theme colors
//               DatePickerStyles styles = DatePickerStyles(
//                 selectedDateStyle: Theme.of(context)
//                     .textTheme
//                     .bodyLarge
//                     ?.copyWith(
//                         color: selectedDateStyleColor ??
//                             Theme.of(context).colorScheme.onSecondary),
//                 selectedSingleDateDecoration: BoxDecoration(
//                   color: selectedSingleDateDecorationColor ??
//                       Theme.of(context).colorScheme.secondary,
//                   shape: BoxShape.circle,
//                 ),
//               );
//
//               return SizedBox(
//                 width: MediaQuery.of(context).size.width *
//                     0.8, // Make it responsive
//                 height:
//                     MediaQuery.of(context).size.height * 0.6, // Adjust height
//                 child: dp.YearPicker.single(
//                   selectedDate: _selectedDate,
//                   onChanged: (newDate) {
//                     setState(() {
//                       _selectedDate = newDate;
//                     });
//                   },
//                   firstDate: _firstDate,
//                   lastDate: _lastDate,
//                   datePickerStyles: styles,
//                 ),
//               );
//             },
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(dialogContext, null); // Return null on cancel
//               },
//               child: const Text('CANCEL'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(
//                     dialogContext, _selectedDate); // Return selected date on OK
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// // --- Demo Application ---
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Date Picker Dialog Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   DateTime? _selectedMonth;
//   DateTime? _selectedWeekStart;
//   DateTime? _selectedYear;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Date Picker Dialog Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () async {
//                 final DateTime? picked =
//                     await CustomDatePickers.showMonthPicker(
//                   context: context,
//                   selectedDate: _selectedMonth,
//                   firstDate:
//                       DateTime.now().subtract(const Duration(days: 365 * 2)),
//                   lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
//                   selectedDateStyleColor: Colors.white,
//                   selectedSingleDateDecorationColor: Colors.deepPurple,
//                 );
//                 if (picked != null && picked != _selectedMonth) {
//                   setState(() {
//                     _selectedMonth = picked;
//                   });
//                 }
//               },
//               child: const Text('Show Month Picker'),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               _selectedMonth == null
//                   ? 'No month selected'
//                   : 'Selected Month: ${_selectedMonth!.month}/${_selectedMonth!.year}',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: () async {
//                 final DateTime? picked = await CustomDatePickers.showWeekPicker(
//                   context: context,
//                   selectedDate: _selectedWeekStart,
//                   firstDate: DateTime.now().subtract(const Duration(days: 70)),
//                   lastDate: DateTime.now().add(const Duration(days: 70)),
//                   firstDayOfWeekIndex: 1,
//                   // Monday
//                   selectedPeriodStartColor: Colors.green,
//                   selectedPeriodLastColor: Colors.green,
//                   selectedPeriodMiddleColor:
//                       Colors.lightGreen.withValues(alpha: 0.5),
//                 );
//                 if (picked != null && picked != _selectedWeekStart) {
//                   setState(() {
//                     _selectedWeekStart = picked;
//                   });
//                 }
//               },
//               child: const Text('Show Week Picker'),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               _selectedWeekStart == null
//                   ? 'No week selected'
//                   : 'Selected Week Starts: ${_selectedWeekStart!.toLocal().toString().split(' ')[0]}',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: () async {
//                 final DateTime? picked = await CustomDatePickers.showYearPicker(
//                   context: context,
//                   selectedDate: _selectedYear,
//                   firstDate: DateTime(DateTime.now().year - 10),
//                   // Example: 10 years back
//                   lastDate: DateTime(DateTime.now().year + 10),
//                   // Example: 10 years forward
//                   selectedDateStyleColor: Colors.white,
//                   selectedSingleDateDecorationColor: Colors.orange,
//                 );
//                 if (picked != null && picked != _selectedYear) {
//                   setState(() {
//                     _selectedYear = picked;
//                   });
//                 }
//               },
//               child: const Text('Show Year Picker'),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               _selectedYear == null
//                   ? 'No year selected'
//                   : 'Selected Year: ${_selectedYear!.year}',
//               style: const TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
