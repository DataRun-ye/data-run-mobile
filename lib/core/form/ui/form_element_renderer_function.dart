import 'package:d_sdk/core/form/field_template/field_template.dart';
import 'package:flutter/widgets.dart';

typedef FormElementRendererFunction<TFormElement extends Template> = Widget
    Function(TFormElement formElement, BuildContext context);
