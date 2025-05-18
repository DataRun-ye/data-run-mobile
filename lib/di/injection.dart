import 'package:d_sdk/user_session/session_repository.dart';
import 'package:datarunmobile/app_routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection.config.dart';

final appLocator = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: false,
  asExtension: false
)
Future<GetIt> configureDependencies() async {
  appLocator.registerLazySingleton(() => AppRouter());
  // await setupSdkLocator();
  // await setupLocator(environment: null, environmentFilter: null);
  return init(appLocator);
}
