import 'dart:collection';

import 'package:datarun/data_run/screens/form/element/form_element.dart';

Iterable<TFormElement>
    getFormElementIterator<TFormElement extends FormElementInstance<dynamic>>(
        FormElementInstance<dynamic> formElement) sync* {
  var stack = Queue<FormElementInstance<dynamic>>.from([formElement]);
  var visitedElements = {formElement};
  while (stack.isNotEmpty) {
    var formElement = stack.removeLast();
    visitedElements.add(formElement);
    if (formElement is TFormElement) {
      yield formElement;
    }
    List<FormElementInstance<dynamic>> formElements = [];

    if (formElement is SectionInstance) {
      formElements.addAll(formElement.elements.values);
    }

    if (formElement is RepeatInstance) {
      formElements.addAll(formElement.elements);
    }

    formElements.forEach((e) {
      if (!visitedElements.contains(e)) {
        stack.addLast(e);
      }
    });
  }
}
