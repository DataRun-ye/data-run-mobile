import 'package:intl/intl.dart';

String getItemLocalString(Map<String?, dynamic>? localsMap,
    {String? defaultString}) {
  final String local = Intl.getCurrentLocale();
  final String? localString = local.startsWith('en') && localsMap != null ? localsMap['en'] : localsMap?[local];
  return localString ??
      localsMap?.values.firstOrNull ??
      defaultString ??
      'unProvidedLocale';
}
