import 'package:datarunmobile/app/app_environment.dart';
import 'package:datarunmobile/app/app_environment_instance.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

@module
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;

  @lazySingleton
  DialogService get dialogService;

  @lazySingleton
  SnackbarService get snackbarService;

  @lazySingleton
  BottomSheetService get bottomSheetService;

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  AppEnvironmentInstance get appEnvironmentInstance => AppEnvironmentInstance(
      envLabel: AppEnvironment.envLabel,
      apiBaseUrl: AppEnvironment.apiBaseUrl,
      defaultLocale: AppEnvironment.defaultLocale,
      apiRequestSentTimeout: AppEnvironment.apiRequestSentTimeout,
      secureCache: AppEnvironment.secureCache,
      secureDatabase: AppEnvironment.secureDatabase,
      encryptionKey: AppEnvironment.encryptionKey);
//// SDK Configuration
//   final appDir = await getApplicationDocumentsDirectory();
//   final db = await AppDatabase.connect(p.join(appDir.path, 'db.sqlite'));
//   final apiClient = ApiClient(baseUrl: 'https://api.example.com');

// encrypt db
// final database = AppDatabase(Platform.createDatabaseConnection('sample'));
}
