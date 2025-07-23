import 'dart:collection';

import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';

/// Ordered

// Iterable<TFormElement>
//     getFormElementIterator<TFormElement extends FormElementInstance<dynamic>>(
//         FormElementInstance<dynamic> element) sync* {
//   final children = <FormElementInstance<dynamic>>[];
//   if (element is Section) {
//     children.addAll(element.elements.values);
//   }
//   if (element is RepeatSection) {
//     children.addAll(element.elements);
//   }
//
//   for (var child in children) {
//     yield* getFormElementIterator<TFormElement>(child);
//   }
// }

Iterable<TFormElement>
    getFormElementIterator<TFormElement extends FormElementInstance<dynamic>>(
        FormElementInstance<dynamic> root) sync* {
  final stack = Queue<FormElementInstance<dynamic>>()..add(root);
  final visited = <FormElementInstance<dynamic>>{};

  while (stack.isNotEmpty) {
    final current = stack.removeLast();
    if (!visited.add(current)) continue;

    if (current is TFormElement) {
      yield current;
    }

    // Gather children in natural order…
    final children = <FormElementInstance<dynamic>>[];
    if (current is Section) {
      children.addAll(current.elements.values);
    }
    if (current is RepeatSection) {
      children.addAll(current.elements);
    }

    // …then push them *reversed*, so the first child is removed next:
    for (var child in children.reversed) {
      if (!visited.contains(child)) {
        stack.addLast(child);
      }
    }
  }
}

Iterable<TFormElement> getFormElementIteratorOld<
        TFormElement extends FormElementInstance<dynamic>>(
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

    if (formElement is Section) {
      formElements.addAll(formElement.elements.values);
    }

    if (formElement is RepeatSection) {
      formElements.addAll(formElement.elements);
    }

    formElements.forEach((e) {
      if (!visitedElements.contains(e)) {
        stack.addLast(e);
      }
    });
  }
}
