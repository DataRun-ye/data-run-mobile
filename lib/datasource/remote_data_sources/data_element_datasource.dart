import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/datasource/base_datasource.dart';
import 'package:datarunmobile/datasource/metadata_datasource.dart';
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
