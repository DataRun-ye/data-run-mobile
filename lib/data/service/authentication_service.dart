import 'package:d2_remote/modules/datarun_shared/utilities/authenticated_user.dart';

abstract class AuthenticationService {
  bool userLoggedIn();

  Future<AuthenticationResult> login(String username, String password);
}
