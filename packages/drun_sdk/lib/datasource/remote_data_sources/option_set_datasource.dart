import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/core/util/list_extensions.dart';
import 'package:d_sdk/database/converters/custom_serializer.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/datasource/datasource.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Order(DSOrder.optionSet)
@Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
class OptionSetDatasource
    extends BaseDataSource<$DataOptionSetsTable, DataOptionSet>
    implements MetaDataSource<DataOptionSet> {
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
  $DataOptionSetsTable get table => db.dataOptionSets;

// @override
// Future<List<DataOptionSet>> syncWithRemote(
//     {SyncConfig? options, ProgressCallback? progressCallback}) async {
//   final resourcePath = '$resourceName$pathPostfix';
//   final response =
//       await apiClient.request(resourceName: resourcePath, method: 'get');
//
//   final raw = response.data;
//
//   /// expecting paged list ({ apiResourceName: [...] }),
//   List dataItems = raw?[resourceName]?.toList() ?? [];
//
//   List<DataOption> options = [];
//   for (final item in dataItems) {
//     final optionsJson = item['options'] as List?;
//     if (!options.isNullOrEmpty) {
//       options.addAll(optionsJson!
//           .asMap()
//           .entries
//           .map<DataOption>((t) => DataOption.fromJson(
//               {...t.value, 'optionSet': item['uid']!, 'order': t.key + 1}))
//           .toList());
//     }
//   }
//
//   final optionSets = dataItems.map((item) {
//     return fromApiJson({
//       ...item,
//       'id': item['uid']!,
//       'translations': (item['translations'] as List?) ?? [],
//     }, serializer: CustomSerializer());
//   }).toList();
//
//   progressCallback?.call(60);
//
//   if (optionSets.isNotEmpty) {
//     db.transaction(() async {
//       await db.batch((b) {
//         b.insertAllOnConflictUpdate(table, optionSets);
//       });
//       if (options.isNotEmpty) {
//         await db.batch((b) {
//           b.insertAllOnConflictUpdate(db.managedTeams, options);
//         });
//       }
//     });
//   }
//   progressCallback?.call(100);
//   return optionSets;
// }
}
