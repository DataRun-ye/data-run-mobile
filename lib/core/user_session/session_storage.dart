import 'package:datarunmobile/core/user_session/user_session.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SessionStorage {
  SessionStorage({
    required SharedPreferences storage,
  }) : _storage = storage;
  final SharedPreferences _storage;

  /// Write session
  Future<void> writeSession(String userId,
      {required UserSession session}) async {
    await _storage.setString(
      userId,
      session.toJsonString(),
    );
  }

  /// Read session
  UserSession? readSession(String userId) {
    final jsonString = _storage.getString(userId);
    if (jsonString == null) return null;
    return UserSession.fromJsonString(jsonString);
  }
}
