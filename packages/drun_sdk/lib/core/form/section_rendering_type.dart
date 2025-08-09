enum SectionRenderingType {
  LISTING,
  SEQUENTIAL,
  MATRIX;

  static SectionRenderingType? valueOf(String? str) =>
      SectionRenderingType.values.firstWhere(
          (e) => e.toString() == 'SectionRenderingType.' + '$str',
          orElse: () => SEQUENTIAL);
}
