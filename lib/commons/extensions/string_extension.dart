import 'package:d_sdk/core/utilities/date_helper.dart';
import 'package:intl/intl.dart';

extension StringNullExtension on String? {
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool toBoolean() {
    return this == 'true' || this == 'TRUE';
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

    return date;
  }

// double toDouble() => double.parse(this!);
//
// int toInt({int? radix}) => int.parse(this!, radix: radix);
//
//   String? format(List args, {String needleRegex = '%s'}) {
//     final RegExp exp = RegExp(needleRegex);
//
//     int i = -1;
//     return this?.replaceAllMapped(exp, (Match match) {
//       i = i + 1;
//       return '${args[i]}';
//     });
//   }
// }
//
// extension StringExtension on String {
//   String format(List args, {String needleRegex = '%s'}) {
//     final RegExp exp = RegExp(needleRegex);
//
//     // Iterable<RegExpMatch> matches = exp.allMatches(this);
//     // assert(
//     //     l.length == matches.length,
//     //     'StringExtension.format: number of string '
//     //     'args not match number of %s in the string');
//
//     int i = -1;
//     return replaceAllMapped(exp, (Match match) {
//       i = i + 1;
//       return '${args[i]}';
//     });
//   }
}
