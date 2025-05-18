// import 'package:auto_route/auto_route.dart';
// import 'package:d_sdk/auth/auth_manager.dart';
// import 'package:datarunmobile/app_routes/app_router.gr.dart';
// import 'package:datarunmobile/di/injection.dart';
//
// class AuthGuard extends AutoRouteGuard {
//   final AuthManager _authManager = appLocator<AuthManager>();
//
//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) async {
//     if (await _authManager.isAuthenticated()) {
//       resolver.next(true);
//     } else {
//       await resolver.redirectUntil(
//         LoginRoute(
//           // this part is optional if you're not using reevaluateListenable as this method will
//           // be called again and if the condition is satisfied the resolver will be completed
//           onResult: (didLogin, context) {
//             // stop re-pushing any pending routes after current
//             resolver.next(didLogin);
//             // resolver.resolveNext(didLogin);
//           },
//         ),
//       );
//     }
//   }
// }
