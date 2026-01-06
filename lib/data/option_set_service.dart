import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/form_option.dart';
import 'package:d_sdk/database/shared/form_template_model.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

@injectable
class OptionSetService {
  Future<Map<String, List<FormOption>>> getOptions(
      FormTemplateModel? template) async {
    final List<String> optionSets = (template?.fields)
            ?.where((t) => t.type?.isSelectType == true && t.optionSet != null)
            .map((t) => t.optionSet!)
            .toList() ??
        [];

    Map<String, List<FormOption>> optionLists = {};
    IMap<String, FormOption> templateOptionMap = IMap.fromIterable(
        template?.options ?? <FormOption>[],
        keyMapper: (o) => o.id,
        valueMapper: (o) => o);

    final List<DataOptionSet> formOptionSets = [];
    if (optionSets.isNotEmpty) {
      final IList<FormOption> elementsOptions = (await DSdk
              .db.managers.dataOptions
              .filter((f) =>
                  f.optionSet.id.isIn(optionSets) &
                  f.deletedAt.isNull() &
                  f.optionSet.deletedAt.isNull())
              .orderBy((o) => o.order.asc())
              .get())
          .map((o) => FormOption.fromDataOptionFactory(o,
              filterExpression: templateOptionMap.get(o.id)?.filterExpression,
              properties: templateOptionMap.get(o.id)?.properties))
          .toIList();

      optionLists = Map.fromIterable(elementsOptions,
          key: (option) => option.optionSet,
          value: (option) => elementsOptions
              .where((o) => o.optionSet == option.optionSet)
              .toList());
    }

    return optionLists;
  }

  //
  // Future<List<FormOption>> mergeOptions(
  //     Iterable<FormOption> formOptions) async {
  //   final optionIdsMap = IMap.fromIterable(formOptions,
  //       keyMapper: (o) => o.id, valueMapper: (o) => o);
  //
  //   final List<FormOption> options = [];
  //
  //   if (optionIdsMap.isNotEmpty) {
  //     final mergedOptions = (await DSdk.db.managers.dataOptions
  //             .filter((f) => f.id.isIn(optionIdsMap.keys))
  //             .get())
  //         .map((o) => optionIdsMap.get(o.id)?.fromDataOption(o))
  //         .whereType<FormOption>()
  //         .toList();
  //
  //     return mergedOptions;
  //   }
  //
  //   return [];
  // }

  Future<Map<String, DataOptionSet>> getOptionSets(
      FormTemplateModel? template) async {
    final List<String> optionSets = (template?.fields)
            ?.where((t) => t.type?.isSelectType == true && t.optionSet != null)
            .map((t) => t.optionSet!)
            .toList() ??
        [];

    final Map<String, DataOptionSet> formOptionSets = {};
    if (optionSets.isNotEmpty) {
      final List<DataOptionSet> sets = await DSdk.db.managers.dataOptionSets
          .filter((f) => f.id.isIn(optionSets))
          .get();
      formOptionSets.addAll(
          Map.fromIterable(sets, key: (set) => set.id, value: (set) => set));
    }

    return formOptionSets;
  }

  Future<DataOptionSet?> getOptionSet(String id) async {
    final DataOptionSet? optionSet = await DSdk.db.managers.dataOptionSets
        .filter((f) => f.id(id))
        .getSingleOrNull();

    return optionSet;
  }
}
