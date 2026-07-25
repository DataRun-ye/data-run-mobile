import 'package:datarunmobile/core/code_generator.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/data/reference_entry_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator/full_name_validator.dart';

typedef ReferenceUidGenerator = String Function();

class ReferenceFieldService {
  ReferenceFieldService(
    this._database, {
    ReferenceEntryRepository? repository,
    ReferenceUidGenerator uidGenerator = CodeGenerator.generateUid,
  })  : _repository = repository ?? ReferenceEntryRepository(_database),
        _uidGenerator = uidGenerator;

  static const int _maxUidAttempts = 5;

  final AppDatabase _database;
  final ReferenceEntryRepository _repository;
  final ReferenceUidGenerator _uidGenerator;

  Future<String> resolveOrgUnitUid(String? assignmentUid) async {
    if (assignmentUid == null) {
      throw const ReferenceFieldConfigurationException(
        'Reference field requires an assignment',
      );
    }
    final assignment = await (_database.select(_database.assignments)
          ..where((row) => row.id.equals(assignmentUid)))
        .getSingleOrNull();
    if (assignment == null) {
      throw ReferenceFieldConfigurationException(
        'Assignment $assignmentUid is not available locally',
      );
    }
    return assignment.orgUnit;
  }

  Future<List<ReferenceEntry>> search({
    required String orgUnitUid,
    String query = '',
  }) {
    return _repository.search(orgUnitUid: orgUnitUid, query: query);
  }

  Future<ReferenceEntry?> find({
    required String orgUnitUid,
    required String uid,
  }) {
    return _repository.findInScope(uid: uid, orgUnitUid: orgUnitUid);
  }

  Future<ReferenceEntry> create({
    required String orgUnitUid,
    required String displayName,
  }) async {
    final normalizedName = ArEnFullNameValidator.normalize(displayName);
    final nameError =
        const ArEnFullNameValidator().validateValue(normalizedName);
    if (normalizedName.isEmpty || nameError != null) {
      throw ReferenceDisplayNameException(
        nameError?['fullName']?.toString() ?? 'required',
      );
    }

    for (var attempt = 0; attempt < _maxUidAttempts; attempt++) {
      final entry = ReferenceEntry(
        uid: _uidGenerator(),
        orgUnitUid: orgUnitUid,
        displayName: normalizedName,
      );
      try {
        await _repository.insertLocal(entry);
        return entry;
      } on ReferenceEntryUidCollision {
        // Generate another UID. A collision does not alter the existing row.
      }
    }
    throw const ReferenceFieldConfigurationException(
      'Could not generate a unique Reference UID',
    );
  }
}

class ReferenceDisplayNameException implements Exception {
  const ReferenceDisplayNameException(this.reason);

  final String reason;
}

class ReferenceFieldConfigurationException implements Exception {
  const ReferenceFieldConfigurationException(this.message);

  final String message;

  @override
  String toString() => message;
}
