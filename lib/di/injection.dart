import 'package:datarunmobile/app_router/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final appLocator = GetIt.instance;

@InjectableInit(
    initializerName: 'init', preferRelativeImports: false, asExtension: false)
Future<GetIt> configureDependencies() async {
  // appLocator.registerLazySingleton(() => AppRouter());
  appLocator.registerLazySingleton(() => AppRouter());
  // await setupSdkLocator();
  // await setupLocator(environment: null, environmentFilter: null);
  return init(appLocator);
}
