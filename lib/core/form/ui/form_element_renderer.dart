import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
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
