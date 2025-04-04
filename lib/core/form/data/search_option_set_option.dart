import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:d2_remote/modules/metadatarun/option_set/entities/option_set.entity.dart';
import 'package:datarunmobile/utils/mass_utils/strings.dart';

class SearchOptionSetOption {
  const SearchOptionSetOption(/*this.optionSetModule*/);

  // final OptionModule optionSetModule;

  //List<Option> invoke(String? optionSetUid, String textToSearch,
  //       List<String> optionsToShow, List<String> optionsToHide)
  Future<List<FormOption>> call(String? optionSetUid, String textToSearch,
      List<String> optionsToShow, List<String> optionsToHide) async {
    OptionSet? optionSet;
    var query = D2Remote.optionSetModule.optionSet.byId(optionSet!.id!);
    // query = query.byOptionSet(optionSet?.id ?? '');
    optionSet = await query
        // .orderBy(attribute: 'sortOrder', order: SortOrder.ASC)
        .getOne();

    final List<FormOption> formOptions = optionSet!.options.unlock;

    if (textToSearch.isNotEmpty) {
      // query = query.like(attribute: 'displayName', value: '%$textToSearch%');
      formOptions.retainWhere((o) => !matchesString(
          haystack: o.name, needle: textToSearch, enableFlexibleSearch: true));
    }

    if (optionsToShow.isNotEmpty) {
      formOptions.retainWhere((o) => optionsToShow.contains(o.name));
      // query =
      //     query.whereIn(attribute: 'id', values: optionsToShow, merge: true);
    }

    // TODO(NMC): implement in SDK
    if (optionsToHide.isNotEmpty) {
      formOptions.removeWhere((o) => optionsToHide.contains(o.name));
      // query = query
      //     .whereIn(attribute: 'id', values: optionsToHide, merge: true);
      // repository = repository.byUid().notIn(optionsToHide)
    }

    return formOptions; //.blockingGet()
  }
}
