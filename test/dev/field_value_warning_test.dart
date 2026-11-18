import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  test('a value warning follows the value and never blocks the form', () {
    final control = FormControl<String>(value: '100');
    final form = FormGroup({'card': control});
    final card = FieldInstance<String>(
      form: form,
      template:
          FieldTemplate(id: 'card-id', name: 'card', type: ValueType.Text),
      elementProperties: FieldElementState<String>(),
    );
    final root = Section(
      template: SectionTemplate(id: 'root-id', path: ''),
      form: form,
      elements: {'card': card},
    )
      ..bindControlReferences()
      ..resolveDependencies()
      ..evaluate(emitEvent: false);

    card.configureValueWarning(
      (value) => value == '101' ? 'recorded before' : null,
    );
    expect(card.elementState.warning, isEmpty);

    card.updateValue('101', emitEvent: false);
    expect(card.elementState.warning, 'recorded before');
    expect(control.valid, isTrue);

    card.updateValue('102', emitEvent: false);
    expect(card.elementState.warning, isEmpty);
    root.dispose();
  });
}
