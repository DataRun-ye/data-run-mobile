import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
import 'package:flutter/widgets.dart';

typedef FormElementRendererFunction<TFormElement extends Template> = Widget
    Function(TFormElement formElement, BuildContext context);
