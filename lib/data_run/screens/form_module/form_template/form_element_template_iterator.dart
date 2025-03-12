import 'dart:collection';

import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';

Iterable<TFormElement>
    getFormElementTemplateIterator<TFormElement extends FormElementTemplate>(
        FormElementTemplate formElement) sync* {
  var stack = Queue<FormElementTemplate>.from([formElement]);
  var visitedElements = {formElement};
  while (stack.isNotEmpty) {
    var formElement = stack.removeLast();
    visitedElements.add(formElement);
    if (formElement is TFormElement) {
      yield formElement;
    }
    List<FormElementTemplate> formElements = [];

    if (formElement is SectionElementTemplate) {
      formElements.addAll(formElement.children);
    }

    formElements.forEach((e) {
      if (!visitedElements.contains(e)) {
        stack.addLast(e);
      }
    });
  }
}
