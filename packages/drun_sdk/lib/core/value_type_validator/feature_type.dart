enum FeatureType {
  POINT('POINT', 'Point'),
  POLYGON('POLYGON', 'Polygon'),
  MULTI_POLYGON('MULTI_POLYGON', 'MultiPolygon'),
  NONE('NONE', 'None'),
  SYMBOL('SYMBOL', 'Symbol');

  const FeatureType(this._featureType, this._geometryType);

  final String _featureType;
  final String _geometryType;

  String get featureType => _featureType;

  String get geometryType => _geometryType;

  static FeatureType? valueOfFeatureType(String featureType) {
    for (FeatureType value in FeatureType.values) {
      if (value.featureType == featureType ||
          value.geometryType == featureType) {
        return value;
      }
    }
    return null;
  }
}
