import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.bottomsheets.dart';
import 'package:datarunmobile/app/stacked/app.dialogs.dart';
import 'package:datarunmobile/app/stacked/app.locator.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:datarunmobile/app/di/injection.config.dart';

export 'package:datarunmobile/di/injection.dart' show appLocator;

@InjectableInit(
  initializerName: 'setupGlobalDependencies', // default
  preferRelativeImports: false, // default
  asExtension: false, // default
)
Future<GetIt> configureDependencies() async {
  // stacked
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  // app
  // Sets up global dependencies that persist throughout the app's lifecycle.
  // Register AuthService, and other global services  e.g., a global API client
  // that doesn't require user-specific tokens initially.
  final getIt = await setupGlobalDependencies(appLocator);
  //

  registerDatabaseDependencies(appLocator);
  return getIt;
}
