import 'package:d_sdk/database/shared/value_type.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static const String DATABASE_FORMAT_EXPRESSION =
      "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
  static const String DATE_TIME_FORMAT_EXPRESSION = "yyyy-MM-dd HH:mm";

  static const String UI_DATE_FORMAT = 'yyyy-MM-dd';

  static const String TIME_FORMAT = 'HH:mm';

  static DateFormat getEffectiveUiFormat(ValueType? valueType,
          [String? locale]) =>
      switch (valueType) {
        ValueType.Date => DateFormat(DateHelper.UI_DATE_FORMAT, locale),
        ValueType.Time => DateFormat(DateHelper.TIME_FORMAT, locale),
        _ => DateFormat(DateHelper.DATE_TIME_FORMAT_EXPRESSION, locale)
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
}
