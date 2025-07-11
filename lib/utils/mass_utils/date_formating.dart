// import 'package:d_sdk/core/datarun/utilities/date_utils.dart' as sdk;
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import 'formatting.dart';
//
// String convertDateTimeToSqlDate([DateTime? date]) {
//   date = date ?? DateTime.now();
//   return sdk.DDateUtils.databaseDateFormat().format(date.toUtc());
// }
//
// DateTime convertSqlDateToDateTime([String? date]) {
//   date = date ?? convertDateTimeToSqlDate();
//   final List<String> parts = date.split('-');
//   return DateTime.utc(
//     parseInt(parts[0])!, // ?? 2022,
//     parseInt(parts[1])!, // ?? 1,
//     parseInt(parts[2])!, // ?? 1,
//   );
// }
//
// DateTime convertTimestampToDate(int? timestamp) =>
//     // DateTime.fromMillisecondsSinceEpoch((timestamp ?? 0) * 1000, isUtc: true);
// DateTime.fromMillisecondsSinceEpoch(timestamp ?? 0, isUtc: true);
//
// String convertTimestampToDateString(int? timestamp) =>
//     convertTimestampToDate(timestamp).toIso8601String();
//
// String formatDuration(Duration duration, {bool showSeconds = true}) {
//   final String time = duration.toString().split('.')[0];
//
//   if (showSeconds) {
//     return time;
//   } else {
//     final List<String> parts = time.split(':');
//     return '${parts[0]}:${parts[1]}';
//   }
// }
//
// DateTime convertTimeOfDayToDateTime(TimeOfDay? timeOfDay,
//     [DateTime? dateTime]) {
//   dateTime ??= DateTime.now();
//   return DateTime(dateTime.year, dateTime.month, dateTime.day,
//       timeOfDay?.hour ?? 0, timeOfDay?.minute ?? 0)
//   ;
// }
//
// TimeOfDay convertDateTimeToTimeOfDay(DateTime? dateTime) =>
//     TimeOfDay(hour: dateTime?.hour ?? 0, minute: dateTime?.minute ?? 0);
//
// String formatDateRange(String startDate, String endDate, BuildContext context) {
//   final DateTime today = DateTime.now();
//
//   final DateTime? startDateTime = DateTime.tryParse(startDate)?.toLocal();
//   final DateFormat startFormatter =
//   DateFormat(today.year == startDateTime?.year ? 'MMM d' : 'MMM d, yyy');
//   final String startDateTimeString = startFormatter.format(startDateTime!);
//
//   final DateTime? endDateTime = DateTime.tryParse(endDate)?.toLocal();
//   final DateFormat endFormatter =
//   DateFormat(today.year == endDateTime?.year ? 'MMM d' : 'MMM d, yyy');
//   final String endDateTimeString = endFormatter.format(endDateTime!);
//
//   return '$startDateTimeString - $endDateTimeString';
// }
//
// String formatDate(String? value,
//     {bool showDate = true, bool showTime = false, bool showSeconds = true}) {
//   if (value == null || value.isEmpty) {
//     return '';
//   }
//
//   // final state = StoreProvider.of<AppState>(context).state;
//   // final CompanyEntity company = state.company;
//
//   if (showTime) {
//     String format;
//     if (!showDate) {
//       format = showSeconds ? 'h:mm:ss a' : 'h:mm a';
//     } else {
//       format = 'yyyy-MM-dd'; //dateFormats[dateFormatId].format;
//       format += ' ${showSeconds ? 'h:mm:ss a' : 'h:mm a'}';
//     }
//     final DateFormat formatter = DateFormat(format);
//     final DateTime? parsed = DateTime.tryParse(value.endsWith('Z') ? value : '${value}Z');
//
//     return parsed == null ? '' : formatter.format(parsed.toLocal());
//   } else {
//     final DateFormat formatter = sdk.DDateUtils.uiDateFormat();
//     final DateTime? parsed = DateTime.tryParse(value);
//     return parsed == null ? '' : formatter.format(parsed);
//   }
// }
//
// String parseDate(String? value) {
//   if (value == null || value.isEmpty) {
//     return '';
//   }
//   final DateFormat formatter = DateFormat('dd/MM/yyyy');
//
//   return convertDateTimeToSqlDate(formatter.parse(value));
// }
