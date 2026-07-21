import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/datasource/abstract_datasource.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:d_sdk/datasource/metadata_datasource.dart';
import 'package:d_sdk/datasource/remote_datasource_order_map.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Order(DSOrder.dataElement)
@Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
class DataElementDatasource
    extends BaseDataSource<$DataElementsTable, DataElement>
    implements MetaDataSource<DataElement> {
  @override
  String get resourceName => 'dataElements';

  @override
  DataElement fromApiJson(Map<String, dynamic> data,
      {ValueSerializer? serializer}) {
    final String? optionSet = data['optionSet']?['uid'];

    return DataElement.fromJson({
      ...data,
      'optionSet': optionSet,
    }, serializer: serializer);
  }

  @override
  $DataElementsTable get table => db.dataElements;
}
