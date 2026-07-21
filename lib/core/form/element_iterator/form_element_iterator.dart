import 'dart:collection';

import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';

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

    final children = <FormElementInstance<dynamic>>[];
    if (current is Section) {
      children.addAll(current.elements.values);
    }
    if (current is RepeatSection) {
      children.addAll(current.elements);
    }

    for (var child in children.reversed) {
      if (!visited.contains(child)) {
        stack.addLast(child);
      }
    }
  }
}
