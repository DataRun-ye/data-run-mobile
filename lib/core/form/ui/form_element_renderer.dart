import 'package:d_sdk/core/form/field_template/field_template.dart';
import 'package:datarunmobile/core/form/ui/form_element_renderer_function.dart';
import 'package:datarunmobile/core/form/ui/form_intent_dispatcher.dart';
import 'package:flutter/widgets.dart';

abstract class FormElementRenderer<TFormElement extends Template> {
  Widget render(
      TFormElement element,
      BuildContext context,
      FormIntentDispatcherFunction dispatcher,
      FormElementRendererFunction renderer);

  Type get formElementType => TFormElement;
}
