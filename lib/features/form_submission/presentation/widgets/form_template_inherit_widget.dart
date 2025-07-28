import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:flutter/material.dart';

class FormFlatTemplateInheritWidget extends InheritedWidget {
  const FormFlatTemplateInheritWidget({
    super.key,
    required this.formContainerTemplate,
    required super.child,
  });

  final FormTemplateRepository formContainerTemplate;

  static FormTemplateRepository of(BuildContext context) {
    final FormFlatTemplateInheritWidget? inheritedWidget = context
        .dependOnInheritedWidgetOfExactType<FormFlatTemplateInheritWidget>();
    if (inheritedWidget == null) {
      throw 'No FormElementInheritedWidget found in context.';
    }
    return inheritedWidget.formContainerTemplate;
  }

  @override
  bool updateShouldNotify(covariant FormFlatTemplateInheritWidget oldWidget) {
    return oldWidget.formContainerTemplate != formContainerTemplate;
  }
}
