abstract class AppEnvironment {
  static const envLabel = String.fromEnvironment('env_label');
  static const apiBaseUrl = String.fromEnvironment('api_base_url');
  static const apiPath = String.fromEnvironment('api_path');
  static const defaultLocale =
      String.fromEnvironment('default_locale', defaultValue: 'en');
  static const apiRequestSentTimeout =
      int.fromEnvironment('api_request_send_timeout');
  static const secureDatabase = bool.fromEnvironment('secure_database');
  static const secureCache = bool.fromEnvironment('secure_cache');
  static const encryptionKey = String.fromEnvironment('encryption_key');
  static const apiPingUrl = '$apiBaseUrl/api/authenticate';
  static const isDev =
      AppEnvironment.envLabel == 'dev' || AppEnvironment.envLabel == 'local';


  // static RunDatabaseConfig getDbConfig({String? username, String? url}) {
  //   final uri = Uri.tryParse(url ?? '')?.host;
  //   final String databaseName = '${username}_$uri';
  //   return RunDatabaseConfig(
  //       inMemory: const bool.fromEnvironment('in_memory'),
  //       databaseName: databaseName,
  //       securityConfig: const DbSecurityConfig(
  //         secure: bool.fromEnvironment('secure_database'),
  //         phrase: String.fromEnvironment('encryption_key'),
  //       ));
  // }
}
