import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/data/form_template_list_service.dart';
import 'package:datarunmobile/data/option_set_service.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator/future_date_policy.dart';
import 'package:drift/native.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FieldTemplate date(String id, String name, {bool allowFuture = false}) =>
      FieldTemplate(
        id: id,
        name: name,
        parent: 'main',
        type: ValueType.Date,
        properties: (allowFuture
                ? const {FutureDatePolicy.property: true}
                : const <String, dynamic>{})
            .lock,
      );

  FieldTemplate named(Iterable<Template> fields, String name) =>
      fields.whereType<FieldTemplate>().firstWhere((f) => f.name == name);

  test('a date field follows the newest version when that allows the future',
      () {
    final draftVersion = <Template>[
      date('expiry-id', 'expiry'),
      date('old-id', 'renamed_expiry'),
      date('visit-id', 'visit'),
      FieldTemplate(
          id: 'note-id', name: 'note', parent: 'main', type: ValueType.Text),
    ];
    final newest = <Template>[
      date('expiry-id', 'expiry', allowFuture: true),
      date('other-id', 'renamed_expiry', allowFuture: true),
      date('visit-id', 'visit'),
    ];

    final seen = FutureDatePolicy.followingNewestVersion(draftVersion, newest);

    expect(FutureDatePolicy.appliesTo(named(seen, 'expiry')), isFalse);
    expect(FutureDatePolicy.appliesTo(named(seen, 'renamed_expiry')), isFalse,
        reason: 'matched by name when the id changed');
    expect(FutureDatePolicy.appliesTo(named(seen, 'visit')), isTrue);
    expect(named(seen, 'note'), same(draftVersion[3]));
    expect(named(seen, 'expiry').id, 'expiry-id');
    expect(named(seen, 'expiry').parent, 'main');
    expect(
      FutureDatePolicy.followingNewestVersion(draftVersion, draftVersion),
      same(draftVersion),
      reason: 'nothing to follow when no version allows future dates',
    );
  });

  group('opening a form version on the phone', () {
    late AppDatabase database;
    late FormTemplateListService service;

    setUp(() async {
      await appLocator.reset();
      database = AppDatabase(
        executor: NativeDatabase.memory(),
        userId: 'future-dates-test',
      );
      appLocator.registerSingleton<AppDatabase>(database);
      service = FormTemplateListService(optionSetService: OptionSetService());
      await database.customStatement('''
        INSERT INTO form_templates (id, version_uid, version_number, name)
        VALUES ('stock', 'stock-v2', 2, 'Stock');
      ''');
      for (final (id, number, allowFuture) in [
        ('stock-v1', 1, false),
        ('stock-v2', 2, true),
      ]) {
        await database.into(database.formTemplateVersions).insert(
              FormTemplateVersion(
                id: id,
                template: 'stock',
                versionNumber: number,
                fields: [
                  date('expiry-id', 'expiry', allowFuture: allowFuture),
                  date('visit-id', 'visit'),
                ],
                sections: [
                  SectionTemplate(id: 'main', name: 'main', path: 'main'),
                ],
                options: const [],
              ),
            );
      }
    });

    tearDown(() async {
      await database.close();
      await appLocator.reset();
    });

    bool refusesFuture(FormTemplateModel model, String name) =>
        FutureDatePolicy.appliesTo(named(model.fields, name));

    test('a draft on an older version accepts what the newest one accepts',
        () async {
      final draft =
          await service.getTemplateByVersionOrLatest(versionId: 'stock-v1');
      final current =
          await service.getTemplateByVersionOrLatest(versionId: 'stock-v2');
      final latest =
          await service.getTemplateByVersionOrLatest(templateId: 'stock');

      expect(draft.versionUid, 'stock-v1');
      expect(refusesFuture(draft, 'expiry'), isFalse);
      expect(refusesFuture(draft, 'visit'), isTrue);
      expect(refusesFuture(current, 'expiry'), isFalse);
      expect(refusesFuture(latest, 'expiry'), isFalse);
      expect(refusesFuture(latest, 'visit'), isTrue);
    });
  });
}
