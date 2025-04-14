// import 'package:auto_route/auto_route.dart';
// import 'package:d_sdk/auth/auth_manager.dart';
// import 'package:d_sdk/auth/auth_state.dart';
// import 'package:datarunmobile/app_routing/app_routing.dart';
//
// class AuthGuard extends AutoRouteGuard {
//   AuthGuard(this._authManager);
//
//   final AuthManager _authManager;
//
//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) {
//     if (_authManager.currentState is AuthAuthenticatedState) {
//       resolver.next(true);
//     } else {
//       resolver.redirectUntil(
//         const LoginRoute(
//
//             /// this part is optional if you're not using reevaluateListenable as this method will
//             /// be called again and if the condition is satisfied the resolver will be completed
//             // onResult: (didLogin) {
//             //   /// stop re-pushing any pending routes after current
//             //   resolver.resolveNext(didLogin, reevaluateNext: false);
//             // },
//             ),
//       );
//       // resolver.redirect(const LoginRoute());
//     }
//   }
// }
