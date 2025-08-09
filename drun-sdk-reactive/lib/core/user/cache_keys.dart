abstract interface class CacheKeys {
  static const String storedUserIdsKey = 'sessions_register';
  static const String activeUserKey = 'active_session';

  //
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String expiryDateKey = 'expiry_date';

  static String getActiveSessionKey(String userId) {
    return '${activeUserKey}_$userId';
  }

  static String getAccessTokenKey(String userId) {
    return '${accessTokenKey}_$userId';
  }

  static String getRefreshTokenKey(String userId) {
    return '${refreshTokenKey}_$userId';
  }

  static String getExpiryDateKey(String userId) {
    return '${expiryDateKey}_$userId';
  }
}
