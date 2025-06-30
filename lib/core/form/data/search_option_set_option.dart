import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/metadatarun/option_set/entities/option.entity.dart';
import 'package:d2_remote/modules/metadatarun/option_set/queries/option.query.dart';
import 'package:d2_remote/shared/utilities/sort_order.util.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchOptionSetOption {
  const SearchOptionSetOption();

  Future<List<Option>> call(String? optionSetUid, String textToSearch,
      {List<String> optionsToShow = const [],
      List<String> optionsToHide = const []}) async {
    OptionQuery query = D2Remote.optionSetModule.option;
    if (optionSetUid != null) {
      query.byOptionSet(optionSetUid);
    }

    if (optionsToShow.isNotEmpty) {
      query = query.byIds(optionsToShow);
    }
    if (optionsToHide.isNotEmpty) {
      query =
          query.whereNotIn(attribute: 'id', values: optionsToShow, merge: true);
    }
    if (textToSearch.isNotEmpty) {
      query = query.like(attribute: 'displayName', value: '%$textToSearch%');
    }

    return query
        .orderBy(attribute: 'sortOrder', sortOrder: SortOrder.ASC)
        .get();
  }
}
