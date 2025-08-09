import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/tables/data_values.table.dart';
import 'package:drift/drift.dart';

part 'data_values_dao.g.dart';

@DriftAccessor(tables: [DataValues])
class DataValuesDao extends DatabaseAccessor<AppDatabase>
    with _$DataValuesDaoMixin, BaseDaoMixin<DataValue> {
  DataValuesDao(AppDatabase db) : super(db);

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
  $DataValuesTable get table => dataValues;
}
