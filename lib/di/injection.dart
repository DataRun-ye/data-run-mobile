import 'package:d_sdk/di/injection.dart';
import 'package:datarunmobile/di/injection.config.dart';
import 'package:datarunmobile/modular/account/user_model.dart';
import 'package:datarunmobile/stacked/app.bottomsheets.dart';
import 'package:datarunmobile/stacked/app.dialogs.dart';
import 'package:datarunmobile/stacked/app.locator.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked_annotations.dart';

// final appLocator = GetIt.instance;
final appLocator = StackedLocator.instance.locator;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: false, // default
  asExtension: false, // default
)
Future<GetIt> configureDependencies() async {
  // stacked
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  //
  // app
  final getIt = await init(appLocator);

  // sdk
  setupSdkLocator();
  return getIt;
}

void registerUser(UserModel user) {
  appLocator.registerSingleton<UserModel>(user);
}

void unregisterLogin() {
  appLocator.unregister<UserModel>();
}
