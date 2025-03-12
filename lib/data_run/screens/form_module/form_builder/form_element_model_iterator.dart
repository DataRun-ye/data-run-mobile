import 'dart:collection';

import 'package:datarunmobile/data_run/screens/form_module/form_element_model/form_element_model.dart';

Iterable<TFormElement>
    getFormElementModelIterator<TFormElement extends FormElementModel<dynamic>>(
        FormElementModel<dynamic> formElement) sync* {
  var stack = Queue<FormElementModel<dynamic>>.from([formElement]);
  var visitedElements = {formElement};
  while (stack.isNotEmpty) {
    var formElement = stack.removeLast();
    visitedElements.add(formElement);
    if (formElement is TFormElement) {
      yield formElement;
    }
    List<FormElementModel<dynamic>> formElements = [];

    if (formElement is SectionElementModel) {
      formElements.addAll(formElement.elements.values);
    }

    if (formElement is RepeatElementModel) {
      formElements.addAll(formElement.elements);
    }

    formElements.forEach((e) {
      if (!visitedElements.contains(e)) {
        stack.addLast(e);
      }
    });
  }
}
