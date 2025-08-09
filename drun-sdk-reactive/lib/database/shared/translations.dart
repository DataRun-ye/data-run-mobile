import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';

class Translation with EquatableMixin {
  final String locale;
  final String property;
  final String? value;

  Translation({required this.locale, required this.property, this.value});

  @override
  List<Object?> get props => [locale, property, value];

  Map<String, dynamic> toJson() {
    return {
      'locale': this.locale,
      'property': this.property,
      'value': this.value,
    };
  }

  factory Translation.fromJson(Map<String, dynamic> map) {
    return Translation(
      locale: map['locale'],
      property: map['property'],
      value: map['value'],
    );
  }

  static JsonTypeConverter2<Translation, String, Object?> converter =
      TypeConverter.json2(
    fromJson: (json) => Translation.fromJson(json as Map<String, Object?>),
    toJson: (translation) => translation.toJson(),
  );
}
