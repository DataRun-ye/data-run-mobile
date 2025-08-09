import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:d_sdk/datasource/metadata_datasource.dart';
import 'package:drift/drift.dart';

// @Order(DSOrder.Option)
// @Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
class OptionDatasource extends BaseDataSource<$DataOptionsTable, DataOption>
    implements MetaDataSource<DataOption> {
  @override
  String get resourceName => 'options';

  @override
  DataOption fromApiJson(Map<String, dynamic> data,
      {ValueSerializer? serializer}) {
    final optionSet =
        data['optionSet']['uid'] ?? data['optionSet']['id'].toString();
    return DataOption.fromJson({...data, 'optionSet': optionSet},
        serializer: serializer);
  }

  @override
  $DataOptionsTable get table => db.dataOptions;
}
