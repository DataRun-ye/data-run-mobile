final class ReferenceUid {
  ReferenceUid._();

  static final RegExp _pattern = RegExp(r'^[a-zA-Z][a-zA-Z0-9]{10}$');

  static bool isValid(Object? value) =>
      value is String && _pattern.hasMatch(value);
}
