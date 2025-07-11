import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';

enum FormatNumberType {
  percent, // 1,000.00%
  int, // 1,000
  double, // 1,000.00
  inputAmount, // 1000
  duration,
}

double round(double? value, int precision) {
  if (value == null || value.isNaN) {
    return 0;
  }

  final int fac = pow(10, precision) as int;
  double result = value * fac;

  // Workaround for floating point issues:
  // ie. 35 * 1.107 => 38.745
  // ie. .75 * 55.3 => 41.4749999999
  if ('$result'.contains('999999')) {
    result += 0.000001;
  }

  return result.round() / fac;
}

int? parseInt(String value, {bool zeroIsNull = false}) {
  value = value.replaceAll(RegExp(r'[^0-9\.\-]'), '');

  final int intValue = int.tryParse(value) ?? 0;

  return (intValue == 0 && zeroIsNull) ? null : intValue;
}

double? parseDouble(String value, {bool zeroIsNull = false}) {
  value = value.replaceAll(RegExp(r'[^0-9\.\-]'), '');

  final double doubleValue = double.tryParse(value) ?? 0.0;

  return (doubleValue == 0 && zeroIsNull) ? null : doubleValue;
}

String formatSize(int size) {
  return size > 1000000
      ? '${round(size / 1000000, 1).toInt()} MB'
      : '${round(size / 1000, 0).toInt()} KB';
}

String? formatNumber(
  double? value,
  BuildContext context, {
  String? clientId,
  String? currencyId,
  FormatNumberType formatNumberType = FormatNumberType.int,
  bool? showCurrencyCode,
  bool zeroIsNull = false,
  bool roundToPrecision = true,
}) {
  if ((zeroIsNull || formatNumberType == FormatNumberType.inputAmount) &&
      value == 0) {
    return null;
  } else if (value == null) {
    return '';
  }

  // if (formatNumberType == FormatNumberType.duration) {
  //   return formatDuration(Duration(seconds: value.toInt()));
  // }

  numberFormatSymbols['custom'] = const NumberSymbols(
    NAME: 'custom',
    DECIMAL_SEP: '.',
    GROUP_SEP: ' ',
    ZERO_DIGIT: '0',
    PLUS_SIGN: '+',
    MINUS_SIGN: '-',
    CURRENCY_PATTERN: '',
    DECIMAL_PATTERN: '',
    DEF_CURRENCY_CODE: '',
    EXP_SYMBOL: '',
    INFINITY: '',
    NAN: '',
    PERCENT: '',
    PERCENT_PATTERN: '',
    PERMILL: '',
    SCIENTIFIC_PATTERN: '',
  );

  late NumberFormat formatter;
  String? formatted;

  if (formatNumberType == FormatNumberType.int) {
    return NumberFormat('#,##0', 'custom').format(value);
  } else if (formatNumberType == FormatNumberType.double) {
    return NumberFormat('#,##0.#####', 'custom').format(value);
  } else if (formatNumberType == FormatNumberType.inputAmount) {
    return NumberFormat('#.#####', 'custom').format(value);
  } else {
    formatter = NumberFormat('#,##0.00###', 'custom');

    formatted = formatter.format(value < 0 ? value * -1 : value);

    // Ugly workaround to prevent showing negative zero values
    if (formatted == '-0.00') {
      formatted = '0.00';
    } else if (formatted == '-0,00') {
      formatted = '0,00';
    }
  }

  final String prefix = value < 0 ? '-' : '';

  if (formatNumberType == FormatNumberType.percent) {
    return '$prefix$formatted%';
  }

  return null;
}

String cleanApiUrl(String? url) => (url ?? '')
    .trim()
    .replaceFirst(RegExp(r'/api/'), '')
    .replaceFirst(RegExp(r'/$'), '');
