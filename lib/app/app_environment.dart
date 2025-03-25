abstract class AppEnvironment {
  static const envLabel = String.fromEnvironment('env_label');
  static const apiBaseUrl = String.fromEnvironment('api_base_url');
  static const defaultLocale =
      String.fromEnvironment('default_locale', defaultValue: 'en');
  static const apiRequestSentTimeout =
      int.fromEnvironment('api_request_send_timeout');
  static const apiPingUrl = '$apiBaseUrl/api/authenticate';

  static const isDev =
      AppEnvironment.envLabel == 'dev' || AppEnvironment.envLabel == 'local';
}
