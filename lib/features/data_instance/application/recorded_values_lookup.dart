import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/core/util/latin_digits_input_formatter.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/extensions/form_template_version.extension.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';
import 'package:datarunmobile/features/data_instance/application/reference_value_extractor.dart';
import 'package:drift/drift.dart';

/// Finds values this phone already recorded in other submissions of a form for
/// one org unit: households (Reference values) and the values of fields marked
/// to warn on repeats, such as card numbers.
///
/// Only this phone's submissions are visible; repeats across phones are left
/// to the daily review on the server. Drafts count, deleted submissions don't.
class RecordedValuesLookup {
  RecordedValuesLookup(
    this._database, {
    ReferenceValueExtractor extractor = const ReferenceValueExtractor(),
  }) : _extractor = extractor;

  final AppDatabase _database;
  final ReferenceValueExtractor _extractor;

  /// The form used to compare field values: trimmed, with Latin digits.
  static String? normalize(Object? value) {
    if (value == null) return null;
    final text = LatinDigitsInputFormatter.normalize(value.toString().trim());
    return text.isEmpty ? null : text;
  }

  /// Each recorded Reference value with the time its latest submission was
  /// started.
  Future<Map<String, DateTime>> references({
    required String formId,
    required String orgUnitUid,
    required String excludeSubmissionId,
  }) async {
    final recorded = <String, DateTime>{};
    for (final (submission, template) in await _otherSubmissions(
      formId: formId,
      orgUnitUid: orgUnitUid,
      excludeSubmissionId: excludeSubmissionId,
    )) {
      final List<ReferenceValueOccurrence> occurrences;
      try {
        occurrences = _extractor.extract(
          template: template,
          formData: submission.formData,
        );
      } on FormatException {
        continue;
      }
      for (final occurrence in occurrences) {
        _keepLatest(recorded, occurrence.uid, submission.startEntryTime);
      }
    }
    return recorded;
  }

  /// For each of [fieldNames], the values recorded in fields of that name,
  /// in every row of repeated sections too, with the time each was last
  /// recorded.
  Future<Map<String, Map<String, DateTime>>> fieldValues({
    required String formId,
    required String orgUnitUid,
    required String excludeSubmissionId,
    required Set<String> fieldNames,
  }) async {
    final recorded = {
      for (final name in fieldNames) name: <String, DateTime>{},
    };
    if (fieldNames.isEmpty) return recorded;
    for (final (submission, template) in await _otherSubmissions(
      formId: formId,
      orgUnitUid: orgUnitUid,
      excludeSubmissionId: excludeSubmissionId,
    )) {
      final formData = submission.formData;
      if (formData == null) continue;
      _collectFieldValues(
        elements: template.elementTree,
        container: formData,
        fieldNames: fieldNames,
        visit: (name, value) =>
            _keepLatest(recorded[name]!, value, submission.startEntryTime),
      );
    }
    return recorded;
  }

  void _collectFieldValues({
    required Iterable<Template> elements,
    required Map<Object?, Object?> container,
    required Set<String> fieldNames,
    required void Function(String name, String value) visit,
  }) {
    for (final element in elements) {
      final name = element.name;
      if (name == null) continue;
      final value = container[name];
      if (element is FieldTemplate) {
        final normalized = fieldNames.contains(name) ? normalize(value) : null;
        if (normalized != null) visit(name, normalized);
      } else if (element is SectionTemplate) {
        final containers = element.repeatable
            ? (value is List ? value.whereType<Map<Object?, Object?>>() : null)
            : (value is Map ? [value] : null);
        for (final nested in containers ?? const <Map<Object?, Object?>>[]) {
          _collectFieldValues(
            elements: element.children,
            container: nested,
            fieldNames: fieldNames,
            visit: visit,
          );
        }
      }
    }
  }

  static void _keepLatest(
    Map<String, DateTime> recorded,
    String value,
    DateTime startedAt,
  ) {
    final previous = recorded[value];
    if (previous == null || startedAt.isAfter(previous)) {
      recorded[value] = startedAt;
    }
  }

  /// Other non-deleted submissions of [formId] for [orgUnitUid], each with its
  /// form version; submissions whose version is not on the phone are skipped.
  Future<List<(DataInstance, FormTemplateModel)>> _otherSubmissions({
    required String formId,
    required String orgUnitUid,
    required String excludeSubmissionId,
  }) async {
    final submissions = _database.dataInstances;
    final assignments = _database.assignments;
    final query = _database.select(submissions).join([
      innerJoin(
        assignments,
        assignments.id.equalsExp(submissions.assignment),
        useColumns: false,
      ),
    ])
      ..where(submissions.formTemplate.equals(formId) &
          assignments.orgUnit.equals(orgUnitUid) &
          submissions.id.equals(excludeSubmissionId).not() &
          submissions.deleted.isNotValue(true));
    final rows = await query.map((row) => row.readTable(submissions)).get();
    if (rows.isEmpty) return const [];

    final versionIds = rows.map((row) => row.templateVersion).toSet();
    final versions = await (_database.select(_database.formTemplateVersions)
          ..where((version) => version.id.isIn(versionIds)))
        .get();
    final templates = {
      for (final version in versions) version.id: version.toTemplateModel(),
    };
    return [
      for (final row in rows)
        if (templates[row.templateVersion] case final template?)
          (row, template),
    ];
  }
}
