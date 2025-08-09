import 'package:d_sdk/core/util/strings_utils.dart';

import 'form_data_util.dart';

enum Aggregation {
  count,
  countDistinct,
  sum,
  avg,
  min,
  max,
  first,
  last,
  concat
}

class FormDataAggregator {
  /// Takes either a single value or a List of num, and applies the agg.
  /// Takes a raw output (single value or List of values) and applies the agg.
  // - raw: single value or List of values
  /// - agg: which Aggregation to run
  /// - delimiter: only used for `Aggregation.concat`
  static dynamic aggregate(
    dynamic raw,
    Aggregation agg, {
    String delimiter = ',',
  }) {
    final List<dynamic> items = raw is List ? raw : [raw];
    final nonNullItems = items.where((v) => v != null).toList();

    switch (agg) {
      case Aggregation.count:
        return nonNullItems.length;

      case Aggregation.countDistinct:
        return nonNullItems.toSet().length;

      case Aggregation.first:
        final List<DateTime> dates = [
          for (var v in nonNullItems)
            if (v is String && isValidDate(v)) DateTime.parse(v)
        ];
        if (dates.isNotEmpty)
          return dates.reduce((a, b) => a.isBefore(b) ? a : b);

        return nonNullItems.isNotEmpty ? nonNullItems.first : null;

      case Aggregation.last:
        return nonNullItems.isNotEmpty ? nonNullItems.last : null;

      case Aggregation.concat:
        // Prepare a flat list of string items:
        final List<String> strings = nonNullItems.expand((v) {
          if (v is List) {
            // e.g. a multi-select field producing ["opt1","opt2"]
            return v.map((e) => e?.toString() ?? '');
          }
          return [v.toString()];
        }).toList();

        return strings.join(delimiter);

      case Aggregation.sum:
      case Aggregation.avg:
      case Aggregation.min:
      case Aggregation.max:
        final List<num> nums = [
          for (var v in nonNullItems)
            if (v is num) v
        ];
        if (nums.isEmpty) return null;

        switch (agg) {
          case Aggregation.sum:
            return nums.reduce((a, b) => a + b);
          case Aggregation.avg:
            return nums.reduce((a, b) => a + b) / nums.length;
          case Aggregation.min:
            return nums.reduce((a, b) => a < b ? a : b);
          case Aggregation.max:
            return nums.reduce((a, b) => a > b ? a : b);
          default:
            return null;
        }
    }
  }
}

void main() {
  final formData = {
    'people': [
      {'name': 'Ali'},
      {'name': 'Salim'},
      {'name': 'Fatima'},
    ],
    'scores': [
      {'value': 10},
      {'value': 20},
      {'value': 30},
    ],
  };

  // -- TEXT CONCATENATION --
  final rawNames = FormDataUtil.getRawByPath(formData, 'people.name');
  print('Raw names: $rawNames');
  print(
      'Concat (comma): ${FormDataAggregator.aggregate(rawNames, Aggregation.concat)}');
  // → "Ali,Salim,Fatima"

  print('Concat (pipe): ${FormDataAggregator.aggregate(
    rawNames,
    Aggregation.concat,
    delimiter: ' | ',
  )}');
  // → "Ali | Salim | Fatima"

  // -- NUMERIC EXAMPLE UNCHANGED --
  final rawScores = FormDataUtil.getRawByPath(formData, 'scores.value');
  print(
      '\nSum of scores: ${FormDataAggregator.aggregate(rawScores, Aggregation.sum)}');
  // → 60

  // -- MIXED TYPES (all get stringified) --
  final mixed = ['x', 1, true, null, 'y'];
  print(
      'Mixed concat: ${FormDataAggregator.aggregate(mixed, Aggregation.concat)}');
  // → "x,1,true,y"
}
