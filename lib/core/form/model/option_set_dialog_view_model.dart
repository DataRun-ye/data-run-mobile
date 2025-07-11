import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/core/form/data/search_option_set_option.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:stacked/stacked.dart';

class OptionSetDialogViewModel extends BaseViewModel {
  OptionSetDialogViewModel({required this.field})
      : _searchOptionSetOption = appLocator<SearchOptionSetOption>();

  final SearchOptionSetOption _searchOptionSetOption;
  final FieldUiModel field;
  List<DataOption> options = [];
  String searchValue = '';

  Future<void> init() async {
    setBusy(true);
    final initialOptions = await _loadOptions();
    options.addAll(initialOptions);
    setBusy(false);
  }

  Future<void> onSearchingOption(String newValue) async {
    searchValue = newValue;
    setBusy(true);
    options.addAll(await _loadOptions(newValue));
    setBusy(false);
  }

  Future<List<DataOption>> _loadOptions([String textToSearch = '']) {
    return _searchOptionSetOption(
        optionSetUid: field.optionSet, textToSearch: textToSearch);
  }
}
