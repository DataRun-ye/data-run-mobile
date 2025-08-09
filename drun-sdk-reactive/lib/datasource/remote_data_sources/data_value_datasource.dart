import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:d_sdk/datasource/metadata_datasource.dart';
import 'package:drift/drift.dart';

// @Order(DSOrder.dataValue)
// @Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
class DataValueDatasource extends BaseDataSource<$DataValuesTable, DataValue>
    implements MetaDataSource<DataValue> {
  @override
  String get resourceName => 'dataValues';

  @override
  DataValue fromApiJson(Map<String, dynamic> data,
      {ValueSerializer? serializer}) {
    final parent = data['parent']?['uid'] ?? data['parent']?['id']?.toString();
    final submission =
        data['submission']['uid'] ?? data['submission']['id'].toString();
    final dataElement =
        data['dataElement']['uid'] ?? data['dataElement']['id']?.toString();

    return DataValue.fromJson({
      ...data,
      'parent': parent,
      'submission': submission,
      'dataElement': dataElement,
    }, serializer: serializer);
  }

  @override
  $DataValuesTable get table => db.dataValues;
}
