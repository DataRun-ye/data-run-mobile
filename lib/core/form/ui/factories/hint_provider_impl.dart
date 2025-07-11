import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/core/form/ui/factories/hint_provider.dart';
import 'package:datarunmobile/generated/l10n.dart';

// @Injectable(as: HintProvider)
class HintProviderImpl implements HintProvider {
  const HintProviderImpl();

  @override
  String provideDateHint(ValueType valueType) {
    switch (valueType) {
      case ValueType.Text:
        return S.current.textHint;
      case ValueType.LongText:
        return S.current.longTextHint;
      case ValueType.Letter:
        return S.current.oneLetterFieldHint;
      case ValueType.Number:
        return S.current.numberFieldHint;
      case ValueType.UnitInterval:
        return S.current.unitIntervalFieldHint;
      case ValueType.Percentage:
        return S.current.percentageFieldHint;
      case ValueType.Integer:
        return S.current.integerFieldHint;
      case ValueType.IntegerPositive:
        return S.current.positiveIntegerFieldHint;
      case ValueType.IntegerNegative:
        return S.current.negativeIntegerFieldHint;
      case ValueType.IntegerZeroOrPositive:
        return S.current.integerOrZeroFieldHint;
      case ValueType.PhoneNumber:
        return S.current.phoneNumberFieldHint;
      case ValueType.Email:
        return S.current.emailFieldHint;
      case ValueType.URL:
        return S.current.urlFieldHint;
      case ValueType.FileResource:
        return S.current.fileResourceFieldHint;
      case ValueType.Coordinate:
        return S.current.coordinatesFieldHint;
      case ValueType.Username:
        return S.current.usernameFieldHint;
      case ValueType.TrackerAssociate:
        return 'fieldHintText';
      case ValueType.Age:
        return S.current.ageFieldHint;
      case ValueType.Image:
        return S.current.imageFieldHint;
      case ValueType.Boolean:
        return S.current.booleanFieldHint;
      case ValueType.TrueOnly:
        return S.current.trueOnlyFieldHint;
      case ValueType.Time:
        return S.current.timeFieldHint;
      case ValueType.OrganisationUnit:
        return S.current.orgunitFieldHint;
      case ValueType.DateTime:
        return S.current.dataTimeFieldHint;
      case ValueType.Date:
        return S.current.dataFieldHint;
      case ValueType.Reference:
        return S.current.referenceFieldHint;
      case ValueType.GeoJson:
        return 'fieldHintText';
      case ValueType.Progress:
        return S.current.progressFieldHint;
      case ValueType.Section:
        return 'fieldHintText';
      case ValueType.RepeatableSection:
        return 'fieldHintText';
      case ValueType.Attribute:
        return 'fieldHintText';
      case ValueType.Team:
        return S.current.teamFieldHint;
      case ValueType.FullName:
        return S.current.fullNameFieldHint;
      case ValueType.SelectMulti:
        return S.current.selectMultiFieldHint;
      case ValueType.SelectOne:
        return S.current.selectOneFieldHint;
      case ValueType.YesNo:
        return S.current.yesOrNoFieldHint;
      case ValueType.Calculated:
        return 'fieldHintText';
      case ValueType.ScannedCode:
        return S.current.scanCodeFieldHint;
    }
  }
}
