class DataRunUrlGenerator {
  static String generate(String resourceName) {
    return 'api/custom/${resourceName}?paged=false';
  }
}
