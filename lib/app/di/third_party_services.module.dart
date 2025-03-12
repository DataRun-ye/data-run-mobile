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
}
