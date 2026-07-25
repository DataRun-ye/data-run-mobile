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

  Future<List<ReferenceCatalogScope>> findSyncScopes() async {
    final query = _database.select(_database.assignmentForms).join([
      innerJoin(
        _database.assignments,
        _database.assignments.id
            .equalsExp(_database.assignmentForms.assignment),
      ),
      innerJoin(
        _database.formTemplates,
        _database.formTemplates.id.equalsExp(_database.assignmentForms.form),
      ),
      innerJoin(
        _database.formTemplateVersions,
        _database.formTemplateVersions.id
            .equalsExp(_database.formTemplates.versionUid),
      ),
    ])
      ..where(
        _database.assignmentForms.canAddSubmissions.equals(true) &
            (_database.assignments.disabled.isNull() |
                _database.assignments.disabled.equals(false)),
      );

    final rows = await query.get();
    final scopesByOrgUnit = <String, ReferenceCatalogScope>{};
    for (final row in rows) {
      final version = row.readTable(_database.formTemplateVersions);
      if (!version.fields.any((field) => field.type == ValueType.Reference)) {
        continue;
      }

      final assignment = row.readTable(_database.assignments);
      scopesByOrgUnit.putIfAbsent(
        assignment.orgUnit,
        () => ReferenceCatalogScope(
          assignmentUid: assignment.id,
          orgUnitUid: assignment.orgUnit,
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

  Future<List<ReferenceEntry>> search({
    required String orgUnitUid,
    String query = '',
    int limit = 50,
  }) {
    final normalizedQuery = query.trim();
    final boundedLimit = limit < 1
        ? 1
        : limit > maxSearchResults
            ? maxSearchResults
            : limit;
    final select = _database.select(_database.referenceEntries)
      ..where((row) {
        final scope = row.orgUnitUid.equals(orgUnitUid);
        return normalizedQuery.isEmpty
            ? scope
            : scope & row.displayName.contains(normalizedQuery);
      })
      ..orderBy([
        (row) => OrderingTerm.asc(row.displayName),
        (row) => OrderingTerm.asc(row.uid),
      ])
      ..limit(boundedLimit);
    return select.get();
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
