import 'package:built_collection/built_collection.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/extensions/data_submission.extension.dart';
import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';
import 'package:datarunmobile/data/reference_entry_repository.dart';
import 'package:datarunmobile/data/reference_uid.dart';
import 'package:datarunmobile/features/data_instance/application/reference_value_extractor.dart';

class ReferenceUploadPayloadBuilder {
  ReferenceUploadPayloadBuilder(
    this._database, {
    ReferenceEntryRepository? repository,
    ReferenceValueExtractor extractor = const ReferenceValueExtractor(),
  })  : _repository = repository ?? ReferenceEntryRepository(_database),
        _extractor = extractor;

  static const int _maxTemplateLookupIds = 500;

  final AppDatabase _database;
  final ReferenceEntryRepository _repository;
  final ReferenceValueExtractor _extractor;

  Future<List<Map<String, dynamic>>> build(
    List<DataInstance> submissions,
  ) async {
    if (submissions.isEmpty) {
      return const [];
    }

    final versionsByUid = await _loadTemplateVersions(
      submissions.map((submission) => submission.templateVersion).toSet(),
    );
    final templatesByVersionUid = versionsByUid.map(
      (uid, version) => MapEntry(
        uid,
        FormTemplateModel(
          id: version.template,
          name: version.template,
          versionUid: version.id,
          versionNumber: version.versionNumber,
          fields: BuiltList(version.fields),
          sections: BuiltList(version.sections),
          options: BuiltList<FormOption>(version.options ?? const []),
        ),
      ),
    );
    final occurrencesBySubmission = <String, List<ReferenceValueOccurrence>>{};
    final referencedUids = <String>{};
    final referenceAssignmentUids = <String>{};

    for (final submission in submissions) {
      final template = templatesByVersionUid[submission.templateVersion];
      if (template == null) {
        throw StateError(
          'Pinned form version ${submission.templateVersion} is missing',
        );
      }
      final occurrences = _extractor.extract(
        template: template,
        formData: submission.formData,
      );
      for (final occurrence in occurrences) {
        if (!ReferenceUid.isValid(occurrence.uid)) {
          throw FormatException(
            'Invalid Reference UID at ${occurrence.elementPath}',
          );
        }
        referencedUids.add(occurrence.uid);
      }
      if (occurrences.isNotEmpty) {
        final assignmentUid = submission.assignment;
        if (assignmentUid == null) {
          throw StateError(
            'Reference submission ${submission.id} has no assignment',
          );
        }
        referenceAssignmentUids.add(assignmentUid);
      }
      occurrencesBySubmission[submission.id] = occurrences;
    }

    final entriesByUid = await _loadReferenceEntries(referencedUids);
    final assignmentsByUid = await _loadAssignments(referenceAssignmentUids);
    return submissions.map((submission) {
      final payload = submission.toUpload();
      final definitionsByUid = <String, Map<String, String>>{};
      final occurrences = occurrencesBySubmission[submission.id] ?? const [];
      final assignment =
          occurrences.isEmpty ? null : assignmentsByUid[submission.assignment];
      if (occurrences.isNotEmpty && assignment == null) {
        throw StateError(
          'Assignment ${submission.assignment} is missing locally',
        );
      }
      for (final occurrence in occurrences) {
        final entry = entriesByUid[occurrence.uid];
        if (entry != null && entry.orgUnitUid == assignment!.orgUnit) {
          definitionsByUid.putIfAbsent(
            entry.uid,
            () => {
              'uid': entry.uid,
              'name': entry.displayName,
            },
          );
        }
      }
      if (definitionsByUid.isNotEmpty) {
        payload['referenceDefinitions'] =
            definitionsByUid.values.toList(growable: false);
      }
      return payload;
    }).toList(growable: false);
  }

  Future<Map<String, FormTemplateVersion>> _loadTemplateVersions(
    Set<String> versionUids,
  ) async {
    final versionsByUid = <String, FormTemplateVersion>{};
    for (final chunk in _chunks(versionUids, _maxTemplateLookupIds)) {
      final versions = await (_database.select(_database.formTemplateVersions)
            ..where((row) => row.id.isIn(chunk)))
          .get();
      for (final version in versions) {
        versionsByUid[version.id] = version;
      }
    }
    return versionsByUid;
  }

  Future<Map<String, ReferenceEntry>> _loadReferenceEntries(
    Set<String> uids,
  ) async {
    final entriesByUid = <String, ReferenceEntry>{};
    for (final chunk in _chunks(uids, ReferenceEntryRepository.maxLookupUids)) {
      final entries = await _repository.findByUids(chunk);
      for (final entry in entries) {
        entriesByUid[entry.uid] = entry;
      }
    }
    return entriesByUid;
  }

  Future<Map<String, Assignment>> _loadAssignments(
    Set<String> assignmentUids,
  ) async {
    final assignmentsByUid = <String, Assignment>{};
    for (final chunk in _chunks(assignmentUids, _maxTemplateLookupIds)) {
      final assignments = await (_database.select(_database.assignments)
            ..where((row) => row.id.isIn(chunk)))
          .get();
      for (final assignment in assignments) {
        assignmentsByUid[assignment.id] = assignment;
      }
    }
    return assignmentsByUid;
  }

  Iterable<Set<String>> _chunks(Set<String> values, int size) sync* {
    final chunk = <String>{};
    for (final value in values) {
      chunk.add(value);
      if (chunk.length == size) {
        yield Set.unmodifiable(chunk);
        chunk.clear();
      }
    }
    if (chunk.isNotEmpty) {
      yield Set.unmodifiable(chunk);
    }
  }
}
