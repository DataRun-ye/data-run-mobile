import 'package:d2_remote/modules/metadatarun/option_set/entities/option.entity.dart';
import 'package:datarunmobile/app/app.locator.dart';
import 'package:datarunmobile/core/form/data/search_option_set_option.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:stacked/stacked.dart';

class OptionSetDialogViewModel extends BaseViewModel {
  OptionSetDialogViewModel({required this.field})
      : _searchOptionSetOption = locator<SearchOptionSetOption>();

  final SearchOptionSetOption _searchOptionSetOption;
  final FieldUiModel field;
  List<Option> options = [];
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

  Future<List<Option>> _loadOptions([String textToSearch = '']) {
    return _searchOptionSetOption(field.optionSet, textToSearch);
  }
}
