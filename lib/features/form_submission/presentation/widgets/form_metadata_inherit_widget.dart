import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:flutter/material.dart';

class FormMetadataWidget extends InheritedWidget {
  const FormMetadataWidget({
    super.key,
    required this.formMetadata,
    required super.child,
  });

  final FormMetadata formMetadata;

  static FormMetadata of(BuildContext context) {
    final FormMetadataWidget? inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<FormMetadataWidget>();
    if (inheritedWidget == null) {
      throw 'No FormMetadataWidget found in context.';
    }
    return inheritedWidget.formMetadata;
  }

  @override
  bool updateShouldNotify(covariant FormMetadataWidget oldWidget) {
    return oldWidget.formMetadata != formMetadata;
  }
}
