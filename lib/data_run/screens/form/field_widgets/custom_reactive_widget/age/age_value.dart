

/// Metadata for the age field, storing only a reference date and
/// readonly flag
class AgeFieldElement {
  AgeFieldElement({
    required this.label,
    this.initialValue,
    this.readOnly = false,
    DateTime? referenceDate,
  }) : referenceDate = referenceDate ?? DateTime.now();
  final String label;
  // from API as dob-based
  final AgeValue? initialValue;
  final bool readOnly;
  final DateTime referenceDate;
}

/// Internal model holding DOB and derived components
class AgeValue {
  AgeValue({required this.dateOfBirth});

  final DateTime dateOfBirth;

  /// Derive years, months, days relative to ref
  int years(DateTime ref) {
    var diff = ref.year - dateOfBirth.year;
    if (ref.month < dateOfBirth.month ||
        (ref.month == dateOfBirth.month && ref.day < dateOfBirth.day)) diff--;
    return diff;
  }

  int months(DateTime ref) {
    final y = years(ref);
    final totalMonths =
        (ref.year - dateOfBirth.year) * 12 + ref.month - dateOfBirth.month;
    if (ref.day < dateOfBirth.day) return totalMonths - 1;
    return totalMonths;
  }

  int days(DateTime ref) => ref.difference(dateOfBirth).inDays;

  /// Rebuild from components
  /// Use exact calendar month logic to avoid approximation errors
  AgeValue copyWith(
      {int? years, int? months, int? days, required DateTime ref}) {
    final currentY = years ?? this.years(ref);
    final currentM = months ?? (this.months(ref) - currentY * 12);
    final currentD = days ??
        (this.days(ref) -
            (DateTime(ref.year, ref.month, ref.day)
                .difference(DateTime(
                    ref.year - currentY, ref.month - currentM, ref.day))
                .inDays));

    DateTime base = DateTime(ref.year, ref.month, ref.day);
    DateTime dob = DateTime(base.year - currentY, base.month, base.day);
    if (currentM != 0) {
      dob = DateTime(dob.year, dob.month - currentM, dob.day);
    }
    if (currentD != 0) {
      dob = dob.subtract(Duration(days: currentD));
    }

    // Normalize the date (avoid overflow into previous month)
    final lastDay = DateTime(dob.year, dob.month + 1, 0).day;
    final safeDay = dob.day.clamp(1, lastDay);
    return AgeValue(dateOfBirth: DateTime(dob.year, dob.month, safeDay));
  }
}
