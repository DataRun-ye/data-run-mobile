import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

part 'metadata_submissions_dao.g.dart';

@DriftAccessor(tables: [MetadataSubmissions])
class MetadataSubmissionsDao extends DatabaseAccessor<AppDatabase>
    with _$MetadataSubmissionsDaoMixin, BaseDaoMixin<MetadataSubmission> {
  MetadataSubmissionsDao(AppDatabase db) : super(db);

  @override
  String get resourceName => 'metadataSubmissions';

  @override
  MetadataSubmission fromApiJson(Map<String, dynamic> data,
          {ValueSerializer? serializer}) =>
      MetadataSubmission.fromJson(data, serializer: serializer);

  @override
  $MetadataSubmissionsTable get table => metadataSubmissions;
}
