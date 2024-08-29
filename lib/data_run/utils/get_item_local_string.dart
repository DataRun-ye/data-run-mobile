import 'package:intl/intl.dart';

String getItemLocalString(Map<String?, String?>? localsMap,
    {String? defaultString}) {
  final String local = Intl.getCurrentLocale();

  return localsMap?[local] ??
      localsMap?.values.firstOrNull ??
      defaultString ??
      'unProvidedLocale';
}
