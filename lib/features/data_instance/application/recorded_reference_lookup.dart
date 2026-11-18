import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/extensions/form_template_version.extension.dart';
import 'package:datarunmobile/features/data_instance/application/reference_value_extractor.dart';
import 'package:drift/drift.dart';

/// Finds the Reference values (households) this phone already recorded in
/// other submissions of a form for one org unit.
///
/// Only this phone's submissions are visible; repeats across phones are left
/// to the daily review on the server. Drafts count, deleted submissions don't.
class RecordedReferenceLookup {
  RecordedReferenceLookup(
    this._database, {
    ReferenceValueExtractor extractor = const ReferenceValueExtractor(),
  }) : _extractor = extractor;

  final AppDatabase _database;
  final ReferenceValueExtractor _extractor;

  /// Each recorded value with the time its latest submission was started.
  Future<Map<String, DateTime>> recordedElsewhere({
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
    if (rows.isEmpty) return const {};

    final versionIds = rows.map((row) => row.templateVersion).toSet();
    final versions = await (_database.select(_database.formTemplateVersions)
          ..where((version) => version.id.isIn(versionIds)))
        .get();
    final templates = {
      for (final version in versions) version.id: version.toTemplateModel(),
    };

    final recorded = <String, DateTime>{};
    for (final submission in rows) {
      final template = templates[submission.templateVersion];
      if (template == null) continue;
      final List<ReferenceValueOccurrence> occurrences;
      try {
        occurrences = _extractor.extract(
          template: template,
          formData: submission.formData,
        );
      } on FormatException {
        continue;
      }
      final startedAt = submission.startEntryTime;
      for (final occurrence in occurrences) {
        final previous = recorded[occurrence.uid];
        if (previous == null || startedAt.isAfter(previous)) {
          recorded[occurrence.uid] = startedAt;
        }
      }
    }
    return recorded;
  }
}
