import 'package:flutter/material.dart';

// // --- Router Configuration ---
// final GoRouter router = GoRouter(
//   initialLocation: '/',
//   routes: [
//     // 1) Splash
//     GoRoute(
//       path: '/',
//       name: 'splash',
//       builder: (context, state) => SplashPage(),
//     ),
//
//     // 3) Protected App Shell under /home
//     ShellRoute(
//       builder: (BuildContext context, GoRouterState state, Widget child) {
//         return HomeWrapperPage(child: child);
//       },
//       routes: [
//         GoRoute(
//           path: '/home',
//           name: 'home.wrapper',
//           pageBuilder: (context, state) => NoTransitionPage(
//             child: RouterOutlet(),
//           ),
//           routes: [
//             // Dashboard (default /home)
//             GoRoute(
//               path: '',
//               name: 'home.dashboard',
//               builder: (context, state) => HomePage(),
//             ),
//             // Profile
//             GoRoute(
//               path: 'profile',
//               name: 'home.profile',
//               builder: (context, state) => ProfilePage(),
//             ),
//
//             // Settings (tabbed)
//             ShellRoute(
//               builder: (context, state, child) =>
//                   SettingsWrapperPage(child: child),
//               routes: [
//                 GoRoute(
//                   path: 'settings/user',
//                   name: 'settings.user',
//                   builder: (context, state) => SettingsUserPage(),
//                 ),
//                 GoRoute(
//                   path: 'settings/appearance',
//                   name: 'settings.appearance',
//                   builder: (context, state) => SettingsAppearancePage(),
//                 ),
//                 GoRoute(
//                   path: 'settings/sync',
//                   name: 'settings.sync',
//                   builder: (context, state) => SettingsSyncPage(),
//                 ),
//               ],
//             ),
//
//             // Assignments
//             GoRoute(
//               path: 'assignments',
//               name: 'assignments.list',
//               builder: (context, state) => AssignmentsWrapper(),
//               routes: [
//                 GoRoute(
//                   path: ':id',
//                   name: 'assignments.detail',
//                   builder: (context, state) {
//                     final id = state.pathParameters['id']!;
//                     return AssignmentDetailPage(id: id);
//                   },
//                 ),
//               ],
//             ),
//
//             // Activities
//             GoRoute(
//               path: 'activities',
//               name: 'activities.list',
//               builder: (context, state) => ActivitiesWrapper(),
//               routes: [
//                 GoRoute(
//                   path: ':id',
//                   name: 'activities.detail',
//                   builder: (context, state) {
//                     final id = state.pathParameters['id']!;
//                     return ActivityDetailPage(id: id);
//                   },
//                 ),
//               ],
//             ),
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
//               builder: (context, state) => SubmissionHistoryPage(),
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
//           ],
//         ),
//       ],
//     ),
//     GoRoute(
//       path: '/404',
//       builder: (BuildContext context, GoRouterState state) {
//         return NotFoundScreen(uri: state.extra as String? ?? '');
//       },
//     ),
//   ],
// );

// --- Bootstrapper Widget ---
class FormFlowBootstrapper extends StatefulWidget {
  const FormFlowBootstrapper({Key? key, required this.submissionId})
      : super(key: key);
  final String submissionId;

  @override
  _FormFlowBootstrapperState createState() => _FormFlowBootstrapperState();
}

class _FormFlowBootstrapperState extends State<FormFlowBootstrapper> {
  @override
  void initState() {
    super.initState();
    _bootstrapFlow();
  }

  Future<void> _bootstrapFlow() async {
    // final id = widget.submissionId;
    //     // if (id == 'new') {
    //     //   final draft = await SubmissionRepository.createDraft();
    //     //   context.replace('/home/forms/${draft.id}/main');
    //     // } else {
    //     //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     //     context.replace('/home/forms/$id/main');
    //     //   });
    //     // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

// --- Placeholder Pages & Wrappers ---
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(body: Center(child: Text('Splash')));
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(body: Center(child: Text('Login')));
}

class AuthGuard extends StatelessWidget {
  const AuthGuard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext c) {
    // TODO: check auth, redirect if needed
    return child;
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text('Profile')));
}

class AssignmentsWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text('Assignments List')));
}

class AssignmentDetailPage extends StatelessWidget {
  AssignmentDetailPage({required this.id});

  final String id;

  @override
  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text('Assignment $id')));
}

class ActivitiesWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text('Activities List')));
}

class ActivityDetailPage extends StatelessWidget {
  ActivityDetailPage({required this.id});

  final String id;

  @override
  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text('Activity $id')));
}

class TeamsWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text('Teams List')));
}

class TeamDetailPage extends StatelessWidget {
  TeamDetailPage({required this.id});

  final String id;

  @override
  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text('Team $id')));
}


class FormEntryMainPage extends StatelessWidget {
  const FormEntryMainPage({Key? key, required this.submissionId})
      : super(key: key);
  final String submissionId;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Form Main - $submissionId')),
    body: Center(child: Text('Main Form Entry')),
  );
}

class FormEntryPage extends StatelessWidget {
  const FormEntryPage({Key? key, required this.submissionId}) : super(key: key);
  final String submissionId;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Form Entry - $submissionId')),
    body: Center(child: Text('Detailed Form Entry')),
  );
}

/// The not found screen
class NotFoundScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const NotFoundScreen({super.key, required this.uri});

  /// The uri that can not be found.
  final String uri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Text("Can't find a page for: $uri"),
      ),
    );
  }
}
