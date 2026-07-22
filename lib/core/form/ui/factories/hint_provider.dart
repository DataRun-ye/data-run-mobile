import 'package:datarunmobile/database/shared/value_type.dart';

abstract class HintProvider {
  String provideHint(ValueType? valueType);
}
