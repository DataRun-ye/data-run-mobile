import 'package:d_sdk/database/db_factory/database_factory.dart';
import 'package:get_it/get_it.dart';

GetIt rSdkLocator = GetIt.instance;

GetIt registerSdkRootDependencies(GetIt getIt) {
  getIt.registerLazySingleton<DatabaseFactory>(
    DatabaseFactory.new,
    dispose: (factory) => factory.close(),
  );
  return getIt;
}
