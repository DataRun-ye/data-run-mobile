import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/features/form/application/form_template_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class OptionSetService {
  Future<Map<String, List<DataOption>>> getOptionSets(
      FormTemplateModel? template) async {
    final List<String> optionSets = (template?.fields)
            ?.where((t) => t.type?.isSelectType == true && t.optionSet != null)
            .map((t) => t.optionSet!)
            .toList() ??
        [];
    Map<String, List<DataOption>> optionLists = {};

    final List<DataOptionSet> formOptionSets = [];
    if (optionSets.isNotEmpty) {
      final List<DataOption> options = await DSdk.db.managers.dataOptions
          .filter((f) => f.optionSet.id.isIn(optionSets))
          .get();

      optionLists = Map.fromIterable(options,
          key: (option) => option.optionSet,
          value: (option) =>
              options.where((o) => o.optionSet == option.optionSet).toList());
    }

    return optionLists;
  }

  Future<DataOptionSet?> getOptionSet(String id) async {
    final DataOptionSet? optionSet = await DSdk.db.managers.dataOptionSets
        .filter((f) => f.id(id))
        .getSingleOrNull();

    return optionSet;
  }
}
