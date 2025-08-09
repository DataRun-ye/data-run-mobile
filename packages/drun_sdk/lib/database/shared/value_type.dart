import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/validators.dart';

enum ValueType {
  Progress(TextValidator()),
  Section(TextValidator()),
  RepeatableSection(TextValidator()),
  Attribute(TextValidator()),
  Text(TextValidator()),
  LongText(LongTextValidator()),
  Letter(LetterValidator()),
  PhoneNumber(PhoneNumberValidator()),
  Email(EmailValidator()),
  Boolean(BooleanValidator()),
  TrueOnly(TrueOnlyValidator()),
  Date(DateValidator()),
  DateTime(DateTimeValidator()),
  Time(TimeValidator()),
  Number(NumberValidator()),
  UnitInterval(UnitIntervalValidator()),
  Percentage(PercentageValidator()),
  Integer(IntegerValidator()),
  IntegerPositive(IntegerPositiveValidator()),
  IntegerNegative(IntegerNegativeValidator()),
  IntegerZeroOrPositive(IntegerZeroOrPositiveValidator()),
  TrackerAssociate(UidValidator()),
  Username(TextValidator()),
  Coordinate(CoordinateValidator()),
  OrganisationUnit(UidValidator()),
  Team(UidValidator()),
  Reference(TextValidator()),
  Age(NumberValidator()),
  FullName(FullNameValidator()),
  URL(UrlValidator()),
  FileResource(UidValidator()),
  Image(UidValidator()),
  // split by  `,`
  SelectMulti(TextValidator()),
  SelectOne(TextValidator()),
  YesNo(TextValidator()),
  GeoJson(TextValidator()),
  Calculated(TextValidator()),
  ScannedCode(TextValidator());

  const ValueType(this._validator);

  final ValueTypeValidator<DException> _validator;

  ValueTypeValidator<DException> get validator => _validator;

  static List<ValueType> get INTEGER_TYPES => <ValueType>[
        Integer,
        IntegerPositive,
        IntegerNegative,
        IntegerZeroOrPositive
      ];

  static List<ValueType> get NUMERIC_TYPES => <ValueType>[
        Integer,
        Number,
        IntegerPositive,
        IntegerNegative,
        IntegerZeroOrPositive,
        UnitInterval,
        Percentage
      ];

  static List<ValueType> get DECIMAL_TYPES =>
      <ValueType>[Number, UnitInterval, Percentage];

  static List<ValueType> get BASIC_TYPES => <ValueType>[
        Text,
        LongText,
        Letter,
        Time,
        Integer,
        Number,
        IntegerPositive,
        IntegerNegative,
        IntegerZeroOrPositive,
        UnitInterval,
        Percentage
      ];

  static List<ValueType> get SECTION_TYPES =>
      <ValueType>[Section, RepeatableSection];

  static List<ValueType> get WITH_OPTIONS_TYPES =>
      <ValueType>[SelectOne, SelectMulti];

  static List<ValueType> get BOOLEAN_TYPES => <ValueType>[Boolean, TrueOnly];

  static List<ValueType> get TEXT_TYPES => <ValueType>[
        Text,
        LongText,
        Letter,
        Coordinate,
        FullName,
        Integer,
        Number,
        IntegerPositive,
        IntegerNegative,
        IntegerZeroOrPositive,
        UnitInterval,
        Percentage
      ];

  static List<ValueType> get DATE_TYPES => <ValueType>[Date, DateTime, Time];

  static List<ValueType> get FILE_TYPES => <ValueType>[Image, FileResource];

  bool get isBasicType => BASIC_TYPES.contains(this);

  bool get isInteger => INTEGER_TYPES.contains(this);

  bool get isDecimal => DECIMAL_TYPES.contains(this);

  bool get isSection => this == Section;

  bool get isRepeatSection => this == RepeatableSection;

  // bool get isSectionType => SECTION_TYPES.contains(this);

  // bool get isSection => this == ValueType.Section;

  // bool get isRepeatSection => this == ValueType.RepeatableSection;

  bool get selectTypes => WITH_OPTIONS_TYPES.contains(this);

  bool get isSelectType => WITH_OPTIONS_TYPES.contains(this);

  bool get isNumeric => NUMERIC_TYPES.contains(this);

  bool get isBoolean => BOOLEAN_TYPES.contains(this);

  bool get isText => TEXT_TYPES.contains(this);

  bool get isDateTime => DATE_TYPES.contains(this);

  bool get isCalculate => this == ValueType.Calculated;

  bool get isDate => this == ValueType.Date;

  bool get isTime => this == ValueType.Time;

  bool get isFile => FILE_TYPES.contains(this);

  bool get isCoordinate => this == Coordinate;

  static ValueType? getValueType(String? valueType) {
    switch (valueType?.toLowerCase()) {
      case 'section':
        return ValueType.Section;
      case 'scannedcode':
        return ValueType.ScannedCode;
      case 'repeatablesection':
        return ValueType.RepeatableSection;
      case 'text':
        return ValueType.Text;
      case 'longtext':
        return ValueType.LongText;
      case 'letter':
        return ValueType.Letter;
      case 'phonenumber':
        return ValueType.PhoneNumber;
      case 'email':
        return ValueType.Email;
      case 'boolean':
        return ValueType.Boolean;
      case 'trueonly':
        return ValueType.TrueOnly;
      case 'date':
        return ValueType.Date;
      case 'datetime':
        return ValueType.DateTime;
      case 'time':
        return ValueType.Time;
      case 'number':
        return ValueType.Number;
      case 'unitinterval':
        return ValueType.UnitInterval;
      case 'percentage':
        return ValueType.Percentage;
      case 'progress':
        return ValueType.Progress;
      case 'integer':
        return ValueType.Integer;
      case 'integerpositive':
        return ValueType.IntegerPositive;
      case 'integernegative':
        return ValueType.IntegerNegative;
      case 'integerzeroorpositive':
        return ValueType.IntegerZeroOrPositive;
      case 'trackerassociate':
        return ValueType.TrackerAssociate;
      case 'username':
        return ValueType.Username;
      case 'coordinate':
        return ValueType.Coordinate;
      case 'organisationunit':
        return ValueType.OrganisationUnit;
      case 'team':
        return ValueType.Team;
      case 'reference':
        return ValueType.Reference;
      case 'age':
        return ValueType.Age;
      case 'fullname':
        return ValueType.FullName;
      case 'url':
        return ValueType.URL;
      case 'fileresource':
        return ValueType.FileResource;
      case 'image':
        return ValueType.Image;
      case 'selectmulti':
        return ValueType.SelectMulti;
      case 'selectone':
        return ValueType.SelectOne;
      case 'yesno':
        return ValueType.YesNo;
      case 'geojson':
        return ValueType.GeoJson;
      case 'attribute':
        return ValueType.Attribute;
      case 'calculated':
        return ValueType.Calculated;
      default:
        return null;
      // throw ArgumentError('Invalid value type: $valueType'); Attribute
    }
  }
}
