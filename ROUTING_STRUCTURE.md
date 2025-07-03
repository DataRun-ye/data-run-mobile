## Datarun Routing Hierarchy
### Route Tree (Logical Outline)
```text
/ (SplashPage) [initial]
├─ /login (LoginPage)
└─ /home (HomeWrapperPage - requires Auth)
      ├─ (Dashboard) /home (HomePage)
      ├─ /home/profile (ProfilePage)
      ├─ /home/settings (SettingsWrapperPage)
      │     ├─ /home/settings/user (SettingsUserPage)
      │     ├─ /home/settings/appearance (SettingsAppearancePage)
      │     └─ /home/settings/about (SettingsAboutPage)
      ├─ /home/assignments (AssignmentsWrapper - list)
      │     └─ /home/assignments/:id (AssignmentDetailPage)
      ├─ /home/activities (ActivitiesWrapper - list)
      │     └─ /home/activities/:id (ActivityDetailPage)
      ├─ /home/teams (TeamsWrapper - list)
      │     └─ /home/teams/:id (TeamDetailPage)
      └─ /home/forms (FormsWrapper - list)
            ├─ /home/forms/new (FormEntryPage)
            └─ /home/forms/history (SubmissionHistoryPage)
```

### Route Table

| **Path**                    | **Page/Route**             | **Guard**     | **Description**                                                    |
|-----------------------------|----------------------------|---------------|--------------------------------------------------------------------|
| `/`                         | SplashPage                 | –             | Initial splash; checks auth and redirects (to `/login` or `/home`) |
| `/login`                    | LoginPage                  | – (or UnAuth) | Login screen                                                       |
| `/home`                     | HomeWrapperPage (Scaffold) | AuthGuard     | Main app shell with drawer; requires login                         |
| `/home` (child `''`)        | HomePage (Dashboard)       | AuthGuard     | Dashboard (default)                                                |
| `/home/profile`             | ProfilePage                | AuthGuard     | User profile                                                       |
| `/home/settings`            | SettingsWrapperPage (Tabs) | AuthGuard     | Settings with nested tabs                                          |
| `/home/settings/user`       | SettingsUserPage           | AuthGuard     | Settings → User tab                                                |
| `/home/settings/appearance` | SettingsAppearancePage     | AuthGuard     | Settings → Appearance tab                                          |
| `/home/settings/about`      | SettingsAboutPage          | AuthGuard     | Settings → About tab                                               |
| `/home/assignments`         | AssignmentsWrapperPage     | AuthGuard     | Assignments list                                                   |
| `/home/assignments/:id`     | AssignmentDetailPage       | AuthGuard     | Assignment detail view                                             |
| `/home/activities`          | ActivitiesWrapperPage      | AuthGuard     | Activities list                                                    |
| `/home/activities/:id`      | ActivityDetailPage         | AuthGuard     | Activity detail                                                    |
| `/home/teams`               | TeamsWrapperPage           | AuthGuard     | Teams list                                                         |
| `/home/teams/:id`           | TeamDetailPage             | AuthGuard     | Team detail                                                        |
| `/home/forms`               | FormsWrapperPage           | AuthGuard     | Forms listing                                                      |
| `/home/forms/new`           | FormEntryPage              | AuthGuard     | New form entry                                                     |
| `/home/forms/history`       | SubmissionHistoryPage      | AuthGuard     | Submission history                                                 |

*(Note: Depending on preference, you may alias `/home/...` routes to top-level paths (`/settings`, `/assignments`, etc.) via `RedirectRoute` or by moving those routes to root with the same wrapper. The above structure uses `/home` as the shell root. Deep-linking is automatically supported by AutoRoute via the defined paths.)*
