import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:d_sdk/datasource/metadata_datasource.dart';
import 'package:drift/drift.dart';

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
