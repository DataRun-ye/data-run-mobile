import 'package:mass_pro/data_run/screens/view/view_base.dart';

mixin HomeScreenView implements ViewBase {
  void renderUsername(String username);

  void openDrawer(int gravity);

  void showGranularSync();

  void goToLogin(int accountsCount, {bool isDeletion = false});

  bool hasToNotSync();
}
