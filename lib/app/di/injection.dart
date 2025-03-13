import 'package:datarunmobile/modular/account/user_model.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked_annotations.dart';
import 'injection.config.dart';

final stackedLocator = StackedLocator.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: false, // default
  asExtension: false, // default
)
Future<GetIt> configureDependencies() => init(stackedLocator.locator);

void registerUser(UserModel user) {
  stackedLocator.registerSingleton<UserModel>(user);
}

void unregisterLogin() {
  stackedLocator.unregister<UserModel>();
}
