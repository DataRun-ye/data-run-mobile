import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

part 'data_options_dao.g.dart';

@DriftAccessor(tables: [DataOptions])
class DataOptionsDao extends DatabaseAccessor<AppDatabase>
    with _$DataOptionsDaoMixin, BaseDaoMixin<DataOption> {
  DataOptionsDao(AppDatabase db) : super(db);

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

  Future<List<DataOption>> searchOptions(String setId, String filter) {
    final query = select(dataOptions)
      ..where((tbl) => tbl.name.like('%$filter%'));
    return query.get();
  }

  Selectable<DataOption> selectOptions(
      {String? optionSetUid,
      String textToSearch = '',
      List<String> optionsToShow = const [],
      List<String> optionsToHide = const []}) {
    final byOptionSet = dataOptionSets.id.equals(optionSetUid ?? '');

    var query = selectOnly(dataOptions)..where(byOptionSet);

    if (textToSearch.isNotEmpty) {
      final pattern = '%$textToSearch%';
      query = query
        ..where(
            dataOptions.name.like(pattern) | dataOptions.code.like(pattern));
    }

    if (optionsToShow.isNotEmpty) {
      query = query..where(dataOptions.code.isIn(optionsToHide));
    }

    if (optionsToShow.isNotEmpty) {
      query = query..where(dataOptions.code.isNotIn(optionsToHide));
    }

    query
      ..orderBy([
        OrderingTerm(expression: dataOptions.order, mode: OrderingMode.asc),
      ]);

    // Map rows to model
    return query.map((row) {
      return row.readTable(dataOptions);
    });
  }

  @override
  $DataOptionsTable get table => dataOptions;
}
