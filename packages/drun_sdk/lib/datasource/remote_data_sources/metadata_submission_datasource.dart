import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/datasource/datasource.dart';
import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Order(DSOrder.metadataSubmission)
@Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
class MetadataSubmissionDatasource
    extends BaseDataSource<$MetadataSubmissionsTable, MetadataSubmission>
    implements MetaDataSource<MetadataSubmission> {
  @override
  String get resourceName => 'metadataSubmissions';

  @override
  MetadataSubmission fromApiJson(Map<String, dynamic> data,
          {ValueSerializer? serializer}) =>
      MetadataSubmission.fromJson(data, serializer: serializer);

  @override
  $MetadataSubmissionsTable get table =>
      db.metadataSubmissions;
}
