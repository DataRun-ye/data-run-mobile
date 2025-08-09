import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

part 'data_elements_dao.g.dart';

@DriftAccessor(tables: [DataElements])
class DataElementsDao extends DatabaseAccessor<AppDatabase>
    with _$DataElementsDaoMixin, BaseDaoMixin<DataElement> {
  DataElementsDao(AppDatabase db) : super(db);

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
  $DataElementsTable get table =>
      dataElements;
}
