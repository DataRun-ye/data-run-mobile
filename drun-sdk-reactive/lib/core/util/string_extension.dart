import 'package:d_sdk/core/util/date_helper.dart';
import 'package:intl/intl.dart';

extension StringNullExtension on String? {
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool toBoolean() {
    return this == 'true' ||
        this == 'TRUE' ||
        this == '1' ||
        this == 'yes' ||
        this == 'Yes' ||
        this == 'YES' ||
        this == 'Y';
  }

  DateTime? toDate() {
    DateTime? date;

    // "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    date = DateFormat(DateHelper.DATABASE_FORMAT_EXPRESSION, 'en_US')
        .tryParse(this ?? '');

    if (date == null) {
      //"yyyy-MM-dd HH:mm"
      date = DateFormat(DateHelper.DATABASE_FORMAT_EXPRESSION, 'en_US')
          .tryParse(this ?? '');
    }

    if (date == null) {
      //'yyyy-MM-dd'
      date =
          DateFormat(DateHelper.UI_DATE_FORMAT, 'en_US').tryParse(this ?? '');
    }

    if (date == null) {
      //'yyyy-MM-dd'
      date = DateTime.tryParse(this ?? '');
    }

    return date;
  }

  double toDouble() => double.parse(this!);

  int toInt({int? radix}) => int.parse(this!, radix: radix);
}
