// import 'package:datarunmobile/app/app_routes/app_router.dart';
// import 'package:datarunmobile/core/auth/auth_manager.dart';
// import 'package:datarunmobile/features/assignment/presentation/assignment_screen.dart';
// import 'package:datarunmobile/features/assignment_detail/presentation/assignment_detail_view.dart';
// import 'package:datarunmobile/features/form_submission/presentation/submission_history_screen.dart';
// import 'package:datarunmobile/features/home/presentation/home_wrapper_page.dart';
// import 'package:datarunmobile/features/login/presentation/login_screen.dart';
// import 'package:datarunmobile/features/settings/presentation/user_settings_tab_view.dart';
// import 'package:datarunmobile/features/startup/presentation/loading_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:injectable/injectable.dart';
//
// final GlobalKey<NavigatorState> _rootNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'root');
//
// @singleton
// class AppRouter {
//   AppRouter(AuthManager authManager) : _authService = authManager;
//   final AuthManager _authService;
//
//   late final GoRouter router = GoRouter(
//     navigatorKey: _rootNavigatorKey,
//     refreshListenable: _authService,
//     initialLocation: '/',
//     routes: [
//       GoRoute(
//         path: '/',
//         name: 'splash',
//         builder: (context, state) => const SplashScreen(),
//       ),
//       GoRoute(
//         path: '/login',
//         name: 'login',
//         builder: (context, state) => const LoginScreen(),
//       ),
//       GoRoute(
//           path: '/home',
//           name: 'home',
//           builder: (context, state) => const HomeWrapperPage(),
//           routes: [
//             // Settings (tabbed)
//             GoRoute(
//               path: 'settings',
//               name: 'settings',
//               builder: (context, state) => UserSettingsTabView(),
//             ),
//             // Assignments
//             GoRoute(
//               path: 'assignments',
//               name: 'assignments.list',
//               builder: (context, state) => AssignmentScreen(),
//               routes: [
//                 GoRoute(
//                   path: ':id',
//                   name: 'assignments.detail',
//                   builder: (context, state) {
//                     final id = state.pathParameters['id']!;
//                     return AssignmentDetailView(assignmentId: id);
//                   },
//                 ),
//               ],
//             ),
//
//             // // Activities
//             // GoRoute(
//             //   path: 'activities',
//             //   name: 'activities.list',
//             //   builder: (context, state) => ActivitiesWrapper(),
//             //   routes: [
//             //     GoRoute(
//             //       path: ':id',
//             //       name: 'activities.detail',
//             //       builder: (context, state) {
//             //         final id = state.pathParameters['id']!;
//             //         return ActivityDetailPage(id: id);
//             //       },
//             //     ),
//             //   ],
//             // ),
//
//             // Teams
//             GoRoute(
//               path: 'teams',
//               name: 'teams.list',
//               builder: (context, state) => TeamsWrapper(),
//               routes: [
//                 GoRoute(
//                   path: ':id',
//                   name: 'teams.detail',
//                   builder: (context, state) {
//                     final id = state.pathParameters['id']!;
//                     return TeamDetailPage(id: id);
//                   },
//                 ),
//               ],
//             ),
//
//             // Forms: history + single ID flow
//             GoRoute(
//               path: 'forms/history',
//               name: 'forms.history',
//               builder: (context, state) => SubmissionHistoryScreen(form: 'form'),
//             ),
//             GoRoute(
//               path: 'forms/:submissionId',
//               name: 'forms.flow',
//               pageBuilder: (context, state) {
//                 final sid = state.pathParameters['submissionId']!;
//                 return NoTransitionPage(
//                   child: FormFlowBootstrapper(submissionId: sid),
//                 );
//               },
//               routes: [
//                 GoRoute(
//                   path: 'main',
//                   name: 'forms.flow.main',
//                   builder: (context, state) {
//                     final id = state.pathParameters['submissionId']!;
//                     return FormEntryMainPage(submissionId: id);
//                   },
//                 ),
//                 GoRoute(
//                   path: 'entry',
//                   name: 'forms.flow.entry',
//                   builder: (context, state) {
//                     final id = state.pathParameters['submissionId']!;
//                     return FormEntryPage(submissionId: id);
//                   },
//                 ),
//               ],
//             ),
//           ]),
//     ],
//     redirect: (BuildContext context, GoRouterState state) {
//       final bool loggedIn = _authService.isAuthenticated();
//       final bool loggingIn = state.matchedLocation == '/login';
//       final bool onSplash = state.matchedLocation == '/';
//
//       // If we are on the splash screen and auth status is known, redirect
//       if (onSplash && _authService.status != AuthStatus.unknown) {
//         return loggedIn ? '/home' : '/login';
//       }
//
//       // If not logged in and not on the login page, go to login
//       if (!loggedIn &&
//           !loggingIn &&
//           _authService.status != AuthStatus.unknown) {
//         return '/login';
//       }
//
//       // If logged in and trying to go to login, redirect to home
//       if (loggedIn && loggingIn) {
//         return '/home';
//       }
//
//       // If the user is on the splash screen and the auth status is still unknown,
//       // stay on the splash screen.
//       if (onSplash && _authService.status == AuthStatus.unknown) {
//         return null; // Keep on splash
//       }
//
//       // No redirect needed
//       return null;
//     },
//     errorBuilder: (context, state) => Scaffold(
//       appBar: AppBar(title: const Text('Error')),
//       body: Center(
//         child: Text('Page not found: ${state.uri.path}'),
//       ),
//     ),
//   );
// }
//
// /// A page that fades in an out.
// class FadeTransitionPage extends CustomTransitionPage<void> {
//   /// Creates a [FadeTransitionPage].
//   FadeTransitionPage({
//     required LocalKey super.key,
//     required super.child,
//   }) : super(
//             transitionsBuilder: (BuildContext context,
//                     Animation<double> animation,
//                     Animation<double> secondaryAnimation,
//                     Widget child) =>
//                 FadeTransition(
//                   opacity: animation.drive(_curveTween),
//                   child: child,
//                 ));
//
//   static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
// }
