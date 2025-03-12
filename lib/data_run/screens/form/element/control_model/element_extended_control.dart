import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ElementExtendedControl {
  ElementExtendedControl(this.itemFormGroup, this.item);
  final FormGroup itemFormGroup;
  final RepeatItemInstance item;
}
