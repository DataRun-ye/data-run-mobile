import 'package:datarunmobile/app/router/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

// final stackedLocator = StackedLocator.instance;
final appLocator = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: false, // default
  asExtension: false, // default
)
Future<GetIt> configureDependencies() async {
  appLocator.registerLazySingleton(() => AppRouter());
  // await setupSdkLocator();
  // await setupLocator(environment: null, environmentFilter: null);
  return init(appLocator);
}
