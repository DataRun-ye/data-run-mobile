import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/utils/mass_utils/strings.dart';

class SearchOptionSetOption {
  const SearchOptionSetOption(/*this.optionSetModule*/);

  // final OptionModule optionSetModule;

  //List<Option> invoke(String? optionSetUid, String textToSearch,
  //       List<String> optionsToShow, List<String> optionsToHide)
  Future<List<FormOption>> call(String? optionSetUid, String textToSearch,
      List<String> optionsToShow, List<String> optionsToHide) async {
    DataOptionSet? optionSet = await DSdk.db.managers.dataOptionSets
        .filter((f) => f.id.equals(optionSetUid))
        .getSingleOrNull();

    final List<FormOption> formOptions = optionSet!.options ?? [];

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
