import 'package:d_sdk/database/shared/value_type.dart';
import 'package:intl/intl.dart';

extension UiDateString on String {}

class DateHelper {
  static const String DATABASE_FORMAT_EXPRESSION =
      "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
  static const String DATABASE_FORMAT_EXPRESSION_NO_SECONDS =
      "yyyy-MM-dd'T'HH:mm";

  static const String DATE_TIME_FORMAT_EXPRESSION = "yyyy-MM-dd HH:mm";

  static const String UI_DATE_FORMAT = 'yyyy-MM-dd';

  static const String TIME_FORMAT = 'HH:mm';

  static DateFormat getEffectiveUiFormat(ValueType? valueType) =>
      switch (valueType) {
        ValueType.Date => DateFormat(DateHelper.UI_DATE_FORMAT, 'en_US'),
        ValueType.Time => DateFormat(DateHelper.TIME_FORMAT, 'en_US'),
        _ => DateFormat(DateHelper.DATE_TIME_FORMAT_EXPRESSION, 'en_US')
      };

  static DateFormat databaseDateFormat() {
    return DateFormat(DATABASE_FORMAT_EXPRESSION, 'en_US');
  }

  static DateFormat uiDateFormat() {
    return DateFormat(UI_DATE_FORMAT, 'en_US');
  }

  static DateFormat uiDateFormatNoSeconds() {
    return DateFormat(DATE_TIME_FORMAT_EXPRESSION, 'en_US');
  }

  static DateFormat timeFormat() {
    return DateFormat('HH:mm', 'en_US');
  }

  /// Parse from string to String (ensuring UTC)
  static String fromUiLocalToDbUtcFormat(String date) {
    final DateTime? parsed = DateTime.tryParse(date);

    return parsed != null ? DateHelper.formatUtc(parsed) : date;
  }

  /// from DbUtc To Ui Local Format
  static String fromDbUtcToUiLocalFormat(String date,
      {bool includeTime = false, onlyTime = false}) {
    final DateTime? parsed =
        DateTime.tryParse(date.endsWith('Z') ? date : '${date}Z');
    return parsed != null
        ? DateHelper.formatForUi(parsed, includeTime: includeTime)
        : date;
  }

  static String formatForUi(DateTime dateTime,
      {bool includeTime = false, bool onlyTime = false}) {
    final DateTime localDate = dateTime.toLocal();

    DateFormat formatter = uiDateFormat();

    if (includeTime) {
      formatter = uiDateFormatNoSeconds();
    }

    if (onlyTime) {
      formatter = timeFormat();
    }

    return formatter.format(localDate);
  }

  // Format DateTime to ISO 8601 UTC string
  static String formatUtc(DateTime dateTime) {
    // same as dateTime.toUtc().toIso8601String(), but
    // without microsecond, last 3 digits, not effect
    return databaseDateFormat().format(dateTime.toUtc());
  }

  // Get current UTC timestamp
  static String nowUtc() {
    // same as DateTime.now().toUtc().toIso8601String(), but
    // without microsecond, last 3 digits, not effect
    return formatUtc(DateTime.now());
  }

  // Compare two dates (ignoring time)
  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.toUtc().toIso8601String().substring(0, 10) ==
        date2.toUtc().toIso8601String().substring(0, 10);
  }

  // Compare two DateTimes (full precision)
  static int compare(DateTime date1, DateTime date2) {
    return date1.toUtc().compareTo(date2.toUtc());
  }

  // Convert DateTime to Unix timestamp (milliseconds since epoch)
  static int toUnixTimestamp(DateTime dateTime) {
    return dateTime.toUtc().millisecondsSinceEpoch;
  }

  // Convert Unix timestamp to DateTime (UTC)
  static DateTime fromUnixTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
  }

  static String convertDateTimeToSqlDate([DateTime? date]) {
    date = date ?? DateTime.now();
    return databaseDateFormat().format(date.toUtc());
  }

  static String formatDateRange(String startDate, String endDate) {
    final DateTime today = DateTime.now();

    final DateTime? startDateTime = DateTime.tryParse(startDate)?.toLocal();
    final DateFormat startFormatter =
        DateFormat(today.year == startDateTime?.year ? 'MMM d' : 'MMM d, yyy');
    final String startDateTimeString = startFormatter.format(startDateTime!);

    final DateTime? endDateTime = DateTime.tryParse(endDate)?.toLocal();
    final DateFormat endFormatter =
        DateFormat(today.year == endDateTime?.year ? 'MMM d' : 'MMM d, yyy');
    final String endDateTimeString = endFormatter.format(endDateTime!);

    return '$startDateTimeString - $endDateTimeString';
  }
}

void main() {
  // DateTime now = DateTime.now();
  // String utcString1 = DateHelper.formatUtc(now);
  // String utcString2 = DateHelper.formatUtc(now);
  // String utcString3 = DateHelper.convertDateTimeToSqlDate(now);
  // DateTime parsed = DateHelper.parseUtc(utcString1);
  // DateTime parsed2 = DateHelper.parseUtc(utcString2);
  // DateTime parsed3 = DateHelper.parseUtc(utcString3);

  // DateTime now2 = DateTime.now(); // Local time
  // String utcString = now2.toUtc().toIso8601String();
  // print(utcString); // Example: "2025-02-10T12:00:00.000Z"

  // print('UTC String: $utcString');
  // print('Parsed Date: ${DateHelper.formatForUi(parsed3)}');
  // print('Is Same Date: ${DateHelper.isSameDate(parsed, now)}');
}
