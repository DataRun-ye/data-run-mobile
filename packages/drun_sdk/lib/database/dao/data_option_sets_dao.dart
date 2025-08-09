import 'package:d_sdk/core/util/list_extensions.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/converters/custom_serializer.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/tables/option_sets.table.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:drift/drift.dart';

part 'data_option_sets_dao.g.dart';

@DriftAccessor(tables: [DataOptionSets])
class DataOptionSetsDao extends DatabaseAccessor<AppDatabase>
    with _$DataOptionSetsDaoMixin, BaseDaoMixin<DataOptionSet> {
  DataOptionSetsDao(AppDatabase db) : super(db);

  @override
  String get resourceName => 'optionSets';

  /// pull out Options companions
  @override
  Future<List<CompanionInsert>> extractExtraEntities(
      List<Map<String, dynamic>> raw) async {
    final inserts = <CompanionInsert>[];

    for (final item in raw) {
      final extraItemsJson = item['options'] as List? ?? [];
      if (!extraItemsJson.isNullOrEmpty) {
        final extraItems = extraItemsJson.asMap().entries.map((t) {
          final json = {
            ...t.value as Map<String, dynamic>,
            'optionSet': item['uid']!,
            'order': t.key + 1,
            'dirty': false,
            'isToUpdate': true,
            'label': t.value['label'] ?? <String, dynamic>{},
            'translations': (t.value['translations'] as List?) ?? [],
          };
          return DataOption.fromJson(json, serializer: CustomSerializer());
        });

        for (var m in extraItems) {
          inserts.add(CompanionInsert(db.dataOptions, m));
        }
      }
    }
    return inserts;
  }

  @override
  DataOptionSet fromApiJson(Map<String, dynamic> data,
          {ValueSerializer? serializer}) =>
      DataOptionSet.fromJson(data, serializer: serializer);

  @override
  $DataOptionSetsTable get table =>
      dataOptionSets;
}
