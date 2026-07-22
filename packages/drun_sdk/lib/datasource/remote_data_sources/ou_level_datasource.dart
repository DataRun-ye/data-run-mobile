import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:d_sdk/datasource/metadata_datasource.dart';
import 'package:drift/drift.dart';

class OuLevelDatasource extends BaseDataSource<$OuLevelsTable, OuLevel>
    implements MetaDataSource<OuLevel> {
  @override
  String get resourceName => 'ouLevels';

  @override
  OuLevel fromApiJson(Map<String, dynamic> data,
          {ValueSerializer? serializer}) =>
      OuLevel.fromJson(data, serializer: serializer);

  @override
  $OuLevelsTable get table => db.ouLevels;
}
