import 'package:datarunmobile/core/util/search_folding.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  void expectSameFold(List<String> spellings) {
    final folded = spellings.map(SearchFolding.fold).toSet();
    expect(folded, hasLength(1), reason: '$spellings fold to $folded');
  }

  test('treats alef forms as one letter', () {
    expectSameFold(['أحمد', 'احمد', 'إحمد', 'آحمد', 'ٱحمد']);
  });

  test('treats teh marbuta as heh and alef maksura as yeh', () {
    expectSameFold(['فاطمة', 'فاطمه']);
    expectSameFold(['مصطفى', 'مصطفي', 'مصطفی']);
  });

  test('ignores harakat, tatweel, spaces and invisible marks', () {
    expectSameFold(['مُحَمَّد', 'محـــمد', 'محمد', 'مح‌مد']);
    expectSameFold(['عبد الله', 'عبدالله', ' عبد  الله ']);
  });

  test('folds digits and Latin case', () {
    expectSameFold(['بيت ١٢', 'بيت 12', 'بيت ۱۲']);
    expectSameFold(['Ali Saleh', 'ALI SALEH', 'alisaleh']);
  });

  test('keeps letters that are not spelling variants apart', () {
    expect(SearchFolding.fold('حسن'), isNot(SearchFolding.fold('حسين')));
    expect(SearchFolding.fold('سعيد'), isNot(SearchFolding.fold('سعد')));
    expect(SearchFolding.fold('هدى'), isNot(SearchFolding.fold('هدا')));
  });

  test('matches every typed word in any order', () {
    final name = SearchFolding.fold('محمد علي صالح');

    expect(SearchFolding.matches(name, SearchFolding.queryTerms('محمد صالح')),
        isTrue);
    expect(SearchFolding.matches(name, SearchFolding.queryTerms('صالح محمد')),
        isTrue);
    expect(SearchFolding.matches(name, SearchFolding.queryTerms('محمد احمد')),
        isFalse);
  });

  test('has no terms for a blank query', () {
    expect(SearchFolding.queryTerms('   '), isEmpty);
    expect(SearchFolding.queryTerms('ـــ'), isEmpty);
  });
}
