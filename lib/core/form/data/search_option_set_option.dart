import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:d2_remote/modules/metadatarun/option_set/entities/option_set.entity.dart';
import 'package:d2_remote/modules/metadatarun/option_set/queries/option_set.query.dart';
import 'package:d2_remote/shared/utilities/sort_order.util.dart';

class SearchOptionSetOption {
  const SearchOptionSetOption(/*this.optionSetModule*/);

  // final OptionModule optionSetModule;

  //List<Option> invoke(String? optionSetUid, String textToSearch,
  //       List<String> optionsToShow, List<String> optionsToHide)
  Future<List<FormOption>> call(String? optionSetUid, String textToSearch,
      List<String> optionsToShow, List<String> optionsToHide) async {
    OptionSet? optionSet;
    OptionSetQuery query =
        D2Remote.optionSetModule.optionSet.byId(optionSet!.id!).getOne();
    // query = query.byOptionSet(optionSet?.id ?? '');

    if (textToSearch.isNotEmpty) {
      query = query.like(attribute: 'displayName', value: '%$textToSearch%');
    }

    if (optionsToShow.isNotEmpty) {
      query =
          query.whereIn(attribute: 'id', values: optionsToShow, merge: true);
    }

    // TODO(NMC): implement in SDK
    if (optionsToHide.isNotEmpty) {
      // query = query
      //     .whereIn(attribute: 'id', values: optionsToHide, merge: true);
      // repository = repository.byUid().notIn(optionsToHide)
    }

    return query
        .orderBy(attribute: 'sortOrder', order: SortOrder.ASC)
        .get(); //.blockingGet()
  }
}
