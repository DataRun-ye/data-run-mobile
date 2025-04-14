import 'package:d_sdk/database/shared/shared.dart';

abstract class DisplayNameProvider {
  Future<String?> provideDisplayValue(
      [ValueType? valueType, String? value, String? optionSet]);
}
