extension IsNullDynamicExtension on dynamic {
  void isNull<T>(T? value, String message) {
    if (value == null) {
      throw Exception(message);
    }
  }
}
