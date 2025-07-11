import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/commons/extensions/string_extension.dart';
import 'package:datarunmobile/core/form/extensions/dynamic_value_extensions.dart';

/// EventDataValueExtensions
///
/// UserFriendlyEventDataValueExtensions
extension UserFriendlyEventDataValueExtension on DataValue {
  Future<String?> userFriendlyValue() async {
    if (this.value.isNullOrEmpty) {
      return this.value;
    }

    final DataElement? dataElement = await DSdk.db.managers.dataElements
        .filter((f) => f.id(this.dataElement))
        .getSingleOrNull();

    if (await CheckWhatValueExtension.check(
        dataElement!.type, dataElement.optionSet, value!)) {
      String? v;
      if (dataElement.optionSet != null &&
          dataElement.type != ValueType.SelectMulti) {
        v = await CheckWhatValueExtension.checkOptionSetValue(
            dataElement.optionSet!, '');
      }
      return v ??
          await CheckWhatValueExtension.checkValueTypeValue(
              dataElement.type, value!);
    }
    return null;
  }
}

/// ValueExtensions
///
///
/// WithValueTypeCheckExtension
extension WithValueTypeCheckExtension on String? {
  String? withValueTypeCheck(ValueType? valueType) {
    if (isNullOrEmpty) return this;
    switch (valueType) {
      case ValueType.Percentage:
      case ValueType.Integer:
      case ValueType.IntegerPositive:
      case ValueType.IntegerNegative:
      case ValueType.IntegerZeroOrPositive:
        return (int.tryParse(this!) ?? toDouble().toInt()).toString();
      case ValueType.UnitInterval:
        return (int.tryParse(this!) ?? toDouble()).toString();
      default:
        return this;
    }
  }
}
