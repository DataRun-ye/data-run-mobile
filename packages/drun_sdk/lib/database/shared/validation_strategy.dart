enum ValidationStrategy {
  OnComplete,
  OnUpdateAndInsert;

  static ValidationStrategy getValueType(String? value) {
    switch (value?.toLowerCase()) {
      case 'oncomplete':
        return OnComplete;
      case 'onupdateandinsert':
        return OnUpdateAndInsert;
      default:
        return OnComplete;
    }
  }
}
