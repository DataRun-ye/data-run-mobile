import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/home/form_template/domain/model/form_template_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

@injectable
class OptionSetService {
  Future<IMap<String, IList<FormOption>>> getOptionSets(
      FormTemplateModel template) async {
    final List<String> optionSets = template.fields
        .where((t) => t.type?.isSelectType == true && t.optionSet != null)
        .map((t) => t.optionSet!)
        .toList();
    IMap<String, IList<FormOption>> optionLists = IMap();

    final List<DataOptionSet> formOptionSets = [];
    if (optionSets.isNotEmpty) {
      formOptionSets.addAll(await DSdk.dataOptionSet.getByIds(optionSets));
      optionLists = IMap.fromIterable(formOptionSets,
          keyMapper: (optionSet) => optionSet.id,
          valueMapper: (optionSet) => IList(optionSet.options
            ..sort((p1, p2) => p1.order.compareTo(p2.order))));
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
