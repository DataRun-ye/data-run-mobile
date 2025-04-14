import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:drift/drift.dart';

class DataValueRepository {
  static AppDatabase get db => DSdk.db;

  static Future<DataValue?> get(
      {required String submissionId,
      required String path,
      String? parent}) async {
    await db.select(db.dataValues)
      ..where((row) => row.submission.equals(submissionId));
    return (db.select(db.dataValues)
          ..where((tbl) => tbl.id.equals(_makeCompositeKey(
              submission: submissionId, parent: parent, path: path))))
        .getSingleOrNull();
  }

  static Future<DataValue> create(
      {required String submissionId,
      required String path,
      dynamic value,
      String? parent}) async {
    final elementPath = path.split('.');
    final dv = DataValue(
        id: _makeCompositeKey(
            submission: submissionId, parent: parent, path: path),
        parent: parent,
        value: value,
        submission: submissionId,
        templatePath: path,
        dataElement: elementPath[elementPath.length - 1],
        lastModifiedDate: DateTime.now().toUtc(),
        createdDate: DateTime.now().toUtc());

    await db.into(db.dataValues).insert(dv);

    return dv;
  }

  static Future<DataValue> update(
      {required String submissionId,
      required String path,
      dynamic value,
      String? parent}) async {
    final elementPath = path.split('.');
    final dv =
        await get(submissionId: submissionId, path: path, parent: parent);
    dv!.copyWith(
        parent: Value(parent),
        value: Value(value),
        submission: submissionId,
        templatePath: path,
        dataElement: elementPath[elementPath.length - 1],
        lastModifiedDate: DateTime.now().toUtc());
    await db.update(db.dataValues).replace(dv);

    // DataValue(
    //     id: _makeCompositeKey(
    //         submission: submissionId, parent: parent, path: path),
    //     parent: parent,
    //     value: value,
    //     submission: submissionId,
    //     templatePath: path,
    //     dataElement: elementPath[elementPath.length - 1],
    //     lastModifiedDate: DateHelper.nowUtc(),
    //     dirty: true);

    return dv;
  }

  static String _makeCompositeKey(
      {required String submission, String? parent, required String path}) {
    final elementIdentifier = path.split('.');
    return '$submission${parent != null ? '.$parent' : ''}.${elementIdentifier[elementIdentifier.length - 1]}';
  }
}
