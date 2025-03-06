enum UiRenderType {
  DEFAULT,
  POINT,
  POLYGON,
  MULTI_POLYGON,
  VERTICAL_RADIOBUTTONS,
  HORIZONTAL_RADIOBUTTONS,
  VERTICAL_CHECKBOXES,
  HORIZONTAL_CHECKBOXES,
  AUTOCOMPLETE,
  MATRIX,
  SEQUENCIAL,
  QR_CODE,
  BAR_CODE;

  bool get isRadioButton =>
      [VERTICAL_RADIOBUTTONS, HORIZONTAL_RADIOBUTTONS].contains(this);

  bool get isCheckBox =>
      [VERTICAL_CHECKBOXES, HORIZONTAL_CHECKBOXES].contains(this);

  bool get isVisualOptionSet => [MATRIX, SEQUENCIAL].contains(this);

  bool get isPolygon => [POLYGON, MULTI_POLYGON].contains(this);
}
