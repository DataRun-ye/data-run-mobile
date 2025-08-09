import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/di/injection.dart';

// @LazySingleton(scope: UserSession.activeSessionScope)
class DbManager {
  UserSession? get _currentUserSession => rSdkLocator<UserSession>();

  String? get userId => _currentUserSession?.username;

  final AppDatabase? _currentUserDb;

  DbManager({required AppDatabase db}) : _currentUserDb = db;

  AppDatabase get db => _currentUserDb!;

  // @preResolve
  // static Future<DbManager> initDbForUser(
  //     {required String userId, required DatabaseFactory factory}) async {
  //   // valid non null auth context
  //   logDebug(
  //       'initializing DbManager: $userId, scope: ${rSdkLocator.currentScopeName}');
  //
  //   final executor = await factory.openForUser(userId);
  //   return DbManager._(
  //       db: AppDatabase(executor: executor), databaseFactory: factory);
  // }

  /// Returns a stream of AuthUserData from the local database.
  Stream<User?> watchAuthUserData(String userId) {
    return (db.select(db.users)..where((t) => t.id.equals(userId)))
        .watchSingleOrNull();
  }

  /// called only after authentication success and
  /// registering the AuthenticatedUser
  Future<User?> loadAuthUserData(String userId) async {
    return (db.select(db.users)..where((t) => t.username.equals(userId)))
        .getSingleOrNull();
  }

  Future<void> saveAuthUserData(User authUserData) async {
    await (db.into(db.users).insertOnConflictUpdate(authUserData));
  }

  Future<void> deleteDataForUser(String userId) async {
    await db.customStatement('PRAGMA foreign_keys = OFF');
    try {
      db.transaction(() async {
        for (final table in db.allTables) {
          await db.delete(table).go();
        }
      });
    } finally {
      await db.customStatement('PRAGMA foreign_keys = OFF');
    }
  }

// Future<void> closeForUser(String userId) {
//   return databaseFactory.closeForUser(userId);
// }

// @disposeMethod
// Future<void> dispose() async {
//   logDebug('Closing all database connections', source: this);
//   databaseFactory.close();
// }
}
