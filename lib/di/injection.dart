import 'package:datarunmobile/database/db_factory/database_factory.dart';
import 'package:get_it/get_it.dart';

final GetIt appLocator = GetIt.instance;

GetIt registerDatabaseDependencies(GetIt getIt) {
  getIt.registerLazySingleton<DatabaseFactory>(
    DatabaseFactory.new,
    dispose: (factory) => factory.close(),
  );
  return getIt;
}
