import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ElementExtendedControl {
  ElementExtendedControl(this.itemFormGroup, this.item);
  final FormGroup itemFormGroup;
  final RepeatItemInstance item;
}
