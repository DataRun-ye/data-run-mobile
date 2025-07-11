class AppEnvironmentInstance {
  AppEnvironmentInstance({
    required this.envLabel,
    required this.apiBaseUrl,
    required this.apiPath,
    this.encryptionKey,
    String? apiUserAuthResource,
    String? defaultLocale,
    int? apiRequestSentTimeout,
    bool? secureCache,
    bool? secureDatabase,
  })  : this.apiRequestSentTimeout = apiRequestSentTimeout ?? 20,
        this.defaultLocale = defaultLocale ?? 'ar',
        this.apiUserAuthResource = apiUserAuthResource ?? 'me',
        this.secureCache = secureCache ?? false,
        this.secureDatabase = secureCache ?? false;

  String apiBaseUrl;
  String apiPath;
  String apiUserAuthResource;
  final String envLabel;
  final String defaultLocale;
  final int apiRequestSentTimeout;
  final bool secureCache;
  final bool secureDatabase;
  final String? encryptionKey;

  String get apiPingUrl => '$apiBaseUrl/api/authenticate';
}
