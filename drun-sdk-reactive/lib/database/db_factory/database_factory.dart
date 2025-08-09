import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/database/db_factory/platform.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:synchronized/synchronized.dart';

@lazySingleton
class DatabaseFactory {
  DatabaseFactory();

  static final _instances = <String, QueryExecutor>{};
  static final _locks = <String, Lock>{};

  Future<QueryExecutor> openForUser(String userId) {
    final lock = _locks.putIfAbsent(userId, () => Lock());
    return lock.synchronized(() {
      return _instances.putIfAbsent(userId, () {
        return Platform.createDatabaseConnection(userId);
      });
    });
  }

  Future<void> closeForUser(String userId) async {
    final lock = _locks.putIfAbsent(userId, () => Lock());
    return lock.synchronized(() async {
      final executor = _instances.remove(userId);
      if (executor != null) {
        await executor.close();
        logDebug('Closed database connection for user: $userId',
            source: this);
      }
    });
  }

  @disposeMethod
  Future<void> close() async {
    logDebug('Closing all database connections', source: 'DatabaseFactory');
    for (final executor in _instances.values) {
      await executor.close();
    }
    _instances.clear();
    _locks.clear();
  }
}
