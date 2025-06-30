import 'package:datarunmobile/core/form/ui/intent/dropdown_option.dart';

abstract class FieldModel {
  String get uid;

  String get label;

  bool get mandatory;

  String? get value;

  String get section;

  bool get allowFutureDate;

  bool get editable;

  String get optionSet;

  String get warning;

  String get error;

  String get description;

  String get dataElement;

  List<String> get options;

  List<DropdownOption> get optionsList;

  int get row;

  int get column;

  String get storeBy;

  FieldModel setMandatory();

  FieldModel setValue(String value);

  FieldModel withWarning(String warning);

  FieldModel withError(String error);

  FieldModel withValue(String data);
}
