bool isValidDate(String? input) {
  if (input == null) return false;
  try {
    return DateTime.tryParse(input) != null;
  } catch (e) {
    return false;
  }
}
