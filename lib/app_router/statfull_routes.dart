import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true,

  // 1) Public routes (onboarding)
  routes: [
    GoRoute(path: '/splash',   builder: (_, __) => SplashScreen()),
    GoRoute(path: '/login',    builder: (_, __) => LoginScreen()),
    GoRoute(path: '/tutorial', builder: (_, __) => TutorialScreen()),

    // 2) Authenticated shell with Bottom Navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(child: navigationShell);
      },
      branches: [
        // Dashboard Tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              name: 'dashboard',
              builder: (_, __) => DashboardScreen(),
              routes: [
                // Notifications overlay
                GoRoute(
                  path: 'notifications',
                  name: 'notifications',
                  builder: (_, __) => NotificationsOverlay(),
                ),
              ],
            ),
          ],
        ),

        // Assignments Tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/assignments',
              name: 'assignments',
              builder: (_, __) => AssignmentListScreen(),
              routes: [
                GoRoute(
                  path: ':assignmentId',
                  name: 'assignmentDetail',
                  builder: (context, state) {
                    final id = state.params['assignmentId']!;
                    return AssignmentDetailScreen(assignmentId: id);
                  },
                ),
              ],
            ),
          ],
        ),

        // Teams Tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/teams',
              name: 'teams',
              builder: (_, __) => TeamsOverviewScreen(),
              routes: [
                GoRoute(
                  path: ':teamId',
                  name: 'teamDetail',
                  builder: (context, state) {
                    final id = state.params['teamId']!;
                    return TeamDetailScreen(teamId: id);
                  },
                ),
              ],
            ),
          ],
        ),

        // Forms Tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/forms',
              name: 'forms',
              builder: (_, __) => FormListScreen(),
              routes: [
                GoRoute(
                  path: ':formId',
                  name: 'formEntry',
                  builder: (context, state) {
                    final id = state.params['formId']!;
                    return FormEntryScreen(formId: id);
                  },
                ),
              ],
            ),
          ],
        ),

        // Settings Tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              name: 'settings',
              builder: (_, __) => SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],

  // 3) Redirects: send unauthenticated users to login, first-timers through tutorial
  redirect: (state) {
    final loggedIn = AuthGuard.isLoggedIn(); // your auth check
    final isSplash = state.subloc == '/splash';
    final isOnboarding = state.subloc == '/login' || state.subloc == '/tutorial';

    if (!loggedIn && !isOnboarding) return '/login';
    if (loggedIn && isOnboarding)    return '/dashboard';
    return null;
  },

  // 4) Error page (404)
  errorBuilder: (context, state) => NotFoundScreen(),
);


