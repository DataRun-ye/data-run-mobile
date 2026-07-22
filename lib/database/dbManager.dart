import 'package:datarunmobile/database/app_database.dart';

// @LazySingleton(scope: UserSession.activeSessionScope)
class DbManager {
  final AppDatabase? _currentUserDb;

  DbManager({required AppDatabase db}) : _currentUserDb = db;

  AppDatabase get db => _currentUserDb!;
}
