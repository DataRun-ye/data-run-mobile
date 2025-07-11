import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';

// @injectable
class SearchOptionSetOption {
  const SearchOptionSetOption();

  Future<List<DataOption>> call(
      {String? optionSetUid,
      String textToSearch = '',
      List<String> optionsToShow = const [],
      List<String> optionsToHide = const []}) async {
    final List<DataOption> options = await DSdk.db.dataOptionsDao
        .selectOptions(
            optionSetUid: optionSetUid,
            optionsToShow: optionsToShow,
            optionsToHide: optionsToHide,
            textToSearch: textToSearch)
        .get();

    return options;
  }
}
