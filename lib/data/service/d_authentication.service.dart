// import 'package:d_sdk/core/datarun/exception/d_error.dart';
// import 'package:d_sdk/core/exception/exception.dart';
// import 'package:d_sdk/core/logging/new_app_logging.dart';
// import 'package:d_sdk/d2_remote.dart';
// import 'package:d_sdk/modules/datarun_shared/utilities/authenticated_user.dart';
// import 'package:datarunmobile/commons/constants.dart';
// import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
// import 'package:datarunmobile/core/network/connectivy_service.dart';
// import 'package:datarunmobile/core/services/user_session_manager.service.dart';
// import 'package:datarunmobile/data/service/authentication_service.dart';
// import 'package:flutter/material.dart';
// import 'package:injectable/injectable.dart';
//
// // @Injectable(as: AuthenticationService)
// class DAuthenticationService implements AuthenticationService {
//   DAuthenticationService(this._sessionManager);
//
//   final UserSessionService _sessionManager;
//
//   @override
//   bool userLoggedIn() {
//     return _sessionManager.isAuthenticated;
//   }
//
//   @override
//   Future<AuthenticationResult> login(String username, String password,
//       [String serverUrl = kApiBaseUrl]) async {
//     WidgetsFlutterBinding.ensureInitialized();
//     AuthenticationResult result = const AuthenticationResult(
//       success: false,
//       sessionUser: null,
//     );
//     try {
//       await throwIfFirstTimeAndNoActiveNetwork();
//
//       final authResult = await D2Remote.authenticate(
//           username: username, password: password, url: serverUrl);
//
//       if (authResult.success) {
//         await _sessionManager.saveUserCredentials(
//             serverUrl: authResult.sessionUser!.baseUrl,
//             username: authResult.sessionUser!.username!,
//             pass: authResult.sessionUser!.password!);
//
//         // return successful result
//         return result.copyWith(
//             success: true, sessionUser: authResult.sessionUser);
//       }
//       // return unsuccessful result
//       // won't reach this case , authenticate would through
//       // an exception in most cases including invalid credentials.
//     } catch (e) {
//       DExceptionReporter.instance.report(e);
//       rethrow;
//     }
//     return result;
//   }
//
//   Future<void> throwIfFirstTimeAndNoActiveNetwork() async {
//     final networkAvailable =
//         await ConnectivityService.instance.isNetworkAvailable();
//     if (_sessionManager.isFirstSession && !networkAvailable) {
//       logDebug('First time login user needs an active network');
//       throw DError(
//           errorCode: DRunErrorCode.noAuthenticatedUser,
//           errorComponent: DErrorComponent.SDK,
//           message: 'First time login user needs an active network');
//     }
//   }
// }
