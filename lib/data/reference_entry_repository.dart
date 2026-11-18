import 'package:datarunmobile/core/util/search_folding.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/data/reference_uid.dart';
import 'package:drift/drift.dart';

class ReferenceEntryRepository {
  ReferenceEntryRepository(this._database);

  static const int maxRemotePageSize = 500;
  static const int maxSearchResults = 100;
  static const int maxLookupUids = 500;

  final AppDatabase _database;

  /// One scope per org unit whose assignment can add submissions to a form
  /// whose current version has a Reference field.
  ///
  /// Each distinct form version is decoded once. A user in many teams has
  /// thousands of assignment-form rows over a handful of versions, and
  /// decoding the version for every row took over a minute on a tablet.
  Future<List<ReferenceCatalogScope>> findSyncScopes() async {
    final assignments = _database.assignments;
    final assignmentForms = _database.assignmentForms;
    final formTemplates = _database.formTemplates;
    final query = _database.selectOnly(assignmentForms).join([
      innerJoin(
        assignments,
        assignments.id.equalsExp(assignmentForms.assignment),
        useColumns: false,
      ),
      innerJoin(
        formTemplates,
        formTemplates.id.equalsExp(assignmentForms.form),
        useColumns: false,
      ),
    ])
      ..addColumns([
        assignments.id,
        assignments.orgUnit,
        formTemplates.versionUid,
      ])
      ..where(
        assignmentForms.canAddSubmissions.equals(true) &
            (assignments.disabled.isNull() |
                assignments.disabled.equals(false)),
      );

    final rows = await query.get();
    final versionIds = {
      for (final row in rows) row.read(formTemplates.versionUid),
    }.whereType<String>().toSet();
    if (versionIds.isEmpty) {
      return const [];
    }
    final versions = await (_database.select(_database.formTemplateVersions)
          ..where((version) => version.id.isIn(versionIds)))
        .get();
    final referenceVersions = {
      for (final version in versions)
        if (version.fields.any((field) => field.type == ValueType.Reference))
          version.id,
    };

    final scopesByOrgUnit = <String, ReferenceCatalogScope>{};
    for (final row in rows) {
      if (!referenceVersions.contains(row.read(formTemplates.versionUid))) {
        continue;
      }
      final orgUnit = row.read(assignments.orgUnit)!;
      scopesByOrgUnit.putIfAbsent(
        orgUnit,
        () => ReferenceCatalogScope(
          assignmentUid: row.read(assignments.id)!,
          orgUnitUid: orgUnit,
        ),
      );
    }
    return scopesByOrgUnit.values.toList(growable: false);
  }

  Future<void> upsertRemotePage({
    required String orgUnitUid,
    required List<ReferenceEntry> entries,
  }) async {
    if (entries.isEmpty) return;
    if (entries.length > maxRemotePageSize) {
      throw ArgumentError.value(
        entries.length,
        'entries',
        'A remote page cannot exceed $maxRemotePageSize rows',
      );
    }
    for (final entry in entries) {
      if (!ReferenceUid.isValid(entry.uid)) {
        throw FormatException('Invalid Reference UID: ${entry.uid}');
      }
      if (entry.orgUnitUid != orgUnitUid) {
        throw ReferenceEntryScopeConflict(
          uid: entry.uid,
          expectedOrgUnitUid: orgUnitUid,
          actualOrgUnitUid: entry.orgUnitUid,
        );
      }
    }

    await _database.transaction(() async {
      final incomingUids = entries.map((entry) => entry.uid).toSet();
      final existing = await (_database.select(_database.referenceEntries)
            ..where((row) => row.uid.isIn(incomingUids)))
          .get();
      for (final entry in existing) {
        if (entry.orgUnitUid != orgUnitUid) {
          throw ReferenceEntryScopeConflict(
            uid: entry.uid,
            expectedOrgUnitUid: orgUnitUid,
            actualOrgUnitUid: entry.orgUnitUid,
          );
        }
      }

      await _database.batch(
        (batch) => batch.insertAllOnConflictUpdate(
          _database.referenceEntries,
          entries,
        ),
      );
    });
  }

  /// Names in [orgUnitUid] containing every word of [query], compared with
  /// [SearchFolding] so spelling variants match.
  ///
  /// Matching runs in Dart over the org unit's entries: one village holds a few
  /// hundred names, which avoids a stored search column and its migration.
  Future<List<ReferenceEntry>> search({
    required String orgUnitUid,
    String query = '',
    int limit = 50,
  }) async {
    final terms = SearchFolding.queryTerms(query);
    final boundedLimit = limit < 1
        ? 1
        : limit > maxSearchResults
            ? maxSearchResults
            : limit;
    final select = _database.select(_database.referenceEntries)
      ..where((row) => row.orgUnitUid.equals(orgUnitUid))
      ..orderBy([
        (row) => OrderingTerm.asc(row.displayName),
        (row) => OrderingTerm.asc(row.uid),
      ]);
    if (terms.isEmpty) {
      return (select..limit(boundedLimit)).get();
    }
    final entries = await select.get();
    return entries
        .where((entry) =>
            SearchFolding.matches(SearchFolding.fold(entry.displayName), terms))
        .take(boundedLimit)
        .toList(growable: false);
  }

  Future<ReferenceEntry?> findInScope({
    required String uid,
    required String orgUnitUid,
  }) {
    return (_database.select(_database.referenceEntries)
          ..where(
            (row) => row.uid.equals(uid) & row.orgUnitUid.equals(orgUnitUid),
          ))
        .getSingleOrNull();
  }

  Future<void> insertLocal(ReferenceEntry entry) async {
    if (!ReferenceUid.isValid(entry.uid)) {
      throw FormatException('Invalid Reference UID: ${entry.uid}');
    }
    if (entry.displayName.trim().isEmpty) {
      throw const FormatException('Reference display name cannot be empty');
    }

    await _database.transaction(() async {
      final existing = await (_database.select(_database.referenceEntries)
            ..where((row) => row.uid.equals(entry.uid)))
          .getSingleOrNull();
      if (existing != null) {
        throw ReferenceEntryUidCollision(entry.uid);
      }
      await _database.into(_database.referenceEntries).insert(entry);
    });
  }

  Future<List<ReferenceEntry>> findByUids(Set<String> uids) {
    if (uids.isEmpty) {
      return Future.value(const []);
    }
    if (uids.length > maxLookupUids) {
      throw ArgumentError.value(
        uids.length,
        'uids',
        'A Reference lookup cannot exceed $maxLookupUids UIDs',
      );
    }
    return (_database.select(_database.referenceEntries)
          ..where((row) => row.uid.isIn(uids)))
        .get();
  }
}

class ReferenceCatalogScope {
  const ReferenceCatalogScope({
    required this.assignmentUid,
    required this.orgUnitUid,
  });

  final String assignmentUid;
  final String orgUnitUid;
}

class ReferenceEntryScopeConflict implements Exception {
  const ReferenceEntryScopeConflict({
    required this.uid,
    required this.expectedOrgUnitUid,
    required this.actualOrgUnitUid,
  });

  final String uid;
  final String expectedOrgUnitUid;
  final String actualOrgUnitUid;

  @override
  String toString() =>
      'Reference $uid belongs to $actualOrgUnitUid, not $expectedOrgUnitUid';
}

class ReferenceEntryUidCollision implements Exception {
  const ReferenceEntryUidCollision(this.uid);

  final String uid;
}
