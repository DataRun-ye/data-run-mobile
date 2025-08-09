import 'package:drift/drift.dart';

import '../db_factory/platform_stub.dart'
if (dart.library.io) 'platform_app.dart'
if (dart.library.js_interop) 'platform_web.dart';

class Platform {
  /// used to encrypt database, to use open and pass to [AppDatabase]
  /// example:
  /// ```dart
  /// final database = AppDatabase(Platform.createDatabaseConnection('sample'));
  /// ```
  static QueryExecutor createDatabaseConnection(String databaseName) =>
      PlatformInterface.createDatabaseConnection(databaseName);
}
