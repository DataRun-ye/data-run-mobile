import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:flutter/widgets.dart';

typedef FormElementRendererFunction<TFormElement extends Template> = Widget
    Function(TFormElement formElement, BuildContext context);
