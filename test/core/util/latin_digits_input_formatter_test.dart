import 'package:datarunmobile/core/util/latin_digits_input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const formatter = LatinDigitsInputFormatter();

  test('converts Arabic-Indic and Extended Arabic-Indic digits', () {
    expect(LatinDigitsInputFormatter.normalize('٠١٢٣٤٥٦٧٨٩'), '0123456789');
    expect(LatinDigitsInputFormatter.normalize('۰۱۲۳۴۵۶۷۸۹'), '0123456789');
  });

  test('keeps letters, spaces and Latin digits', () {
    expect(LatinDigitsInputFormatter.normalize('علي team-١٢ 7'), 'علي team-12 7');
  });

  test('returns the same string when nothing changes', () {
    const value = 'user123';
    expect(identical(LatinDigitsInputFormatter.normalize(value), value), isTrue);
  });

  test('keeps the cursor where the user typed', () {
    const typed = TextEditingValue(
      text: 'pass٤٥',
      selection: TextSelection.collapsed(offset: 6),
    );

    final result = formatter.formatEditUpdate(TextEditingValue.empty, typed);

    expect(result.text, 'pass45');
    expect(result.selection, const TextSelection.collapsed(offset: 6));
  });

  test('leaves the edit untouched when there is nothing to convert', () {
    const typed = TextEditingValue(text: 'abc');

    expect(identical(formatter.formatEditUpdate(TextEditingValue.empty, typed), typed), isTrue);
  });
}
