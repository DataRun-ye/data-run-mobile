import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarunmobile/core/form/ui/factories/hint_provider.dart';

class HintProviderImpl implements HintProvider {
  const HintProviderImpl();

  @override
  String provideDateHint(ValueType valueType) {
    switch (valueType) {
      case ValueType.Text:
        return 'fieldHintText';
      case ValueType.LongText:
        return 'fieldHintText';
      case ValueType.Letter:
        return 'fieldHintText';
      case ValueType.Number:
        return 'fieldHintText';
      case ValueType.UnitInterval:
        return 'fieldHintText';
      case ValueType.Percentage:
        return 'fieldHintText';
      case ValueType.Integer:
        return 'fieldHintText';
      case ValueType.IntegerPositive:
        return 'fieldHintText';
      case ValueType.IntegerNegative:
        return 'fieldHintText';
      case ValueType.IntegerZeroOrPositive:
        return 'fieldHintText';
      case ValueType.PhoneNumber:
        return 'fieldHintText';
      case ValueType.Email:
        return 'fieldHintText';
      case ValueType.URL:
        return 'fieldHintText';
      case ValueType.FileResource:
        return 'fieldHintText';
      case ValueType.Coordinate:
        return 'fieldHintText';
      case ValueType.Username:
        return 'fieldHintText';
      case ValueType.TrackerAssociate:
        return 'fieldHintText';
      case ValueType.Age:
        return 'fieldHintText';
      case ValueType.Image:
        return 'fieldHintText';
      case ValueType.Boolean:
        return 'fieldHintText';
      case ValueType.TrueOnly:
        return 'fieldHintText';
      case ValueType.Time:
        return 'fieldHintText';
      case ValueType.OrganisationUnit:
        return 'fieldHintText';
      case ValueType.DateTime:
      case ValueType.Date:
        return 'fieldHintText';
      case ValueType.Reference:
        return 'fieldHintText';
      case ValueType.GeoJson:
        return 'fieldHintText';
      case ValueType.Progress:
        return 'fieldHintText';
      case ValueType.Section:
        return 'fieldHintText';
      case ValueType.RepeatableSection:
        return 'fieldHintText';
      case ValueType.Attribute:
        return 'fieldHintText';
      case ValueType.Team:
        return 'fieldHintText';
      case ValueType.FullName:
        return 'fieldHintText';
      case ValueType.SelectMulti:
        return 'fieldHintText';
      case ValueType.SelectOne:
        return 'fieldHintText';
      case ValueType.YesNo:
        return 'fieldHintText';
      case ValueType.Calculated:
        return 'fieldHintText';
      case ValueType.ScannedCode:
        return 'fieldHintText';
      case ValueType.Unknown:
        return 'fieldHintText';
    }
  }
}
