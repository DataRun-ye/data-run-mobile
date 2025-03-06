import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';

abstract class DisplayNameProvider {
  Future<String?> provideDisplayValue(
      [ValueType? valueType, String? value, String? optionSet]);
}
