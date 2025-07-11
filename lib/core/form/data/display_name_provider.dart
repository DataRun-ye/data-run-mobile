import 'package:d_sdk/database/shared/value_type.dart';

abstract class DisplayNameProvider {
  Future<String?> provideDisplayValue(
      [ValueType? valueType, String? value, String? optionSet]);
}
