import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';

import 'package:mass_pro/form/ui/style/form_ui_model_style.dart';

abstract class UiStyleProvider {
  const UiStyleProvider();

  FormUiModelStyle provideStyle(ValueType valueType);
}
