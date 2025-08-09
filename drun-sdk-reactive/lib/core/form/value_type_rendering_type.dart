enum ValueTypeRenderingType {
  DEFAULT,
  DROPDOWN,
  VERTICAL_RADIOBUTTONS,
  HORIZONTAL_RADIOBUTTONS,
  VERTICAL_CHECKBOXES,
  HORIZONTAL_CHECKBOXES,
  SHARED_HEADER_RADIOBUTTONS,
  ICONS_AS_BUTTONS,
  SPINNER,
  ICON,
  TOGGLE,
  VALUE,
  SLIDER,
  LINEAR_SCALE,
  AUTOCOMPLETE,
  QR_CODE,
  BAR_CODE,
  GS1_DATAMATRIX;

  static ValueTypeRenderingType valueOf(String? str) =>
      ValueTypeRenderingType.values.firstWhere(
          (e) => e.toString() == 'ValueTypeRenderingType.' + '$str',
          orElse: () => DEFAULT);
}
