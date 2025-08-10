abstract class AppEnvironment {
  static const envLabel =
      String.fromEnvironment('env_label', defaultValue: "prod");
  static const apiBaseUrl = String.fromEnvironment(
    'api_base_url',
    defaultValue: 'https://api.nmcpye.org',
  );
  static const defaultLocale =
      String.fromEnvironment('default_locale', defaultValue: 'ar');

  static const isDev = envLabel == 'dev';

  // if not present it defaults to false
  static const secureCache =
      bool.fromEnvironment('secure_cache', defaultValue: true);
  static const apiPath = '/api/custom';
  static const apiV1Path = '/api/v1';
  static const apiPingUrl = '$apiBaseUrl/api/authenticate';
}
