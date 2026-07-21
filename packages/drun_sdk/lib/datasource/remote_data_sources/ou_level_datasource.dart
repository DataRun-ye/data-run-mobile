import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/datasource/abstract_datasource.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:d_sdk/datasource/metadata_datasource.dart';
import 'package:d_sdk/datasource/remote_datasource_order_map.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Order(DSOrder.ouLevel)
@Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
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
