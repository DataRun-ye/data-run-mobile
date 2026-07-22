# State, DI, And Runtime Registration Map

Generated: 2026-07-10

Scope: active and inactive-looking state management, dependency injection, generated registrations, runtime scopes, route registration, and service registration. This complements `01-production-code-path-map.md`, `02-form-flow.md`, and `03-config-fetching.md`; it does not remap form rendering or config sync internals except where those depend on runtime state/DI.

Status legend:

- ACTIVE: used by reachable production runtime flow such that commenting/removing it would break app startup/auth/navigation, sync/offline cache, assignment/form access, form load/render/repeat/edit/save, or submission table behavior.
- SUPPORTING-USED: referenced by reachable production UI, but not required for the core app/forms/sync/data-collection flows to keep working.
- INACTIVE: not referenced by active runtime flow found in this scan.
- INCOMPLETE: looks like unfinished feature work.
- LEGACY-RISK: old or duplicate-looking code that could still be mistaken for active or could be called indirectly.
- UNKNOWN: cannot prove either way from static references.

Strict active test used in this document: a file is not ACTIVE just because it compiles, is generated, has an injectable/provider annotation, has a form-related name, or is reachable only through stale/commented code. ACTIVE means the currently running production app or a core data-collection flow would fail, lose behavior, or stop building if that path were commented without replacement.

## Executive Map

Active app runtime is a hybrid:

1. `lib/main.dart` is the production entrypoint.
2. `main()` calls `configureDependencies()` before `runApp(...)`.
3. `configureDependencies()` registers Stacked services, app-level injectable services, and the explicit root database dependency.
4. `runApp(...)` wraps the app with a root Riverpod `ProviderScope`.
5. `MaterialApp` uses generated Stacked routing from `lib/app/stacked/app.router.dart`.
6. `AuthManager` creates a per-user GetIt scope after login/session restore.
7. Configuration datasource registrations are added to the active user scope by `registerUserConfigurationDatasources(...)`.
8. Opening a form creates a per-submission GetIt scope containing `FormTemplateRepository` and `FormInstance`.
9. Form widgets use Riverpod for widget-level async/selection/preference state, but active form state is held in `FormInstance`, `reactive_forms` controls, and scoped GetIt.

Core risk: the app does not have one state system. Riverpod, ChangeNotifier, GetIt scopes, generated injectable registrations, `reactive_forms`, and Stacked routing/services all participate in the active runtime for startup/auth/sync/forms/submissions. Hand-written Stacked viewmodels have now been removed from the active surface.

## Runtime Boot Path

| Step | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| Production entrypoint | ACTIVE | `lib/main.dart` | `main()` initializes Sentry, calls `configureDependencies()`, then `runApp(SentryWidget(child: ProviderScope(child: App(...))))`. | High | Any DI or provider change must preserve this order. |
| App root state bridge | ACTIVE | `lib/main.dart` | `App extends ConsumerWidget` and watches `authNotifierProvider` plus preference providers for language/theme. | High | Riverpod is active at the root; it is not only feature-local. |
| Generated Stacked routing | ACTIVE | `lib/main.dart`, `lib/app/stacked/app.router.dart` | `MaterialApp.onGenerateRoute` is `StackedRouter().onGenerateRoute`; initial route is `Routes.splashView`. | High | Route registration determines reachability more strongly than file names. |
| Stacked app registration | ACTIVE | `lib/app/stacked/app.dart` | `@StackedApp` lists routed pages: `HomeWrapperPage`, `LoginView`, `SplashView`, `SettingsView`, `SyncResourcesView`, `EditRowScreen`, `FormSubmissionScreen`, `FormFlowBootstrapper`, and `TableScreen`. | High | Screens not in this route list need separate proof of reachability, such as `AssignmentScreen`'s direct `MaterialPageRoute`. |
| Dependency bootstrap | ACTIVE | `lib/app/di/injection.dart` | `configureDependencies()` calls `setupLocator()`, `setupDialogUi()`, `setupBottomSheetUi()`, `setupGlobalDependencies(appLocator)`, then `registerDatabaseDependencies(appLocator)`. | High | This is the production DI order. |
| App locator | ACTIVE | `lib/di/injection.dart`, `lib/app/di/injection.dart` | `appLocator = GetIt.instance` is defined once and re-exported through the existing app DI entrypoint; a focused test asserts identity. | High | Runtime service lookups and nested user/form scopes use one locator. |

## State And Runtime Libraries Found

| Library/pattern | Classification | Evidence | Confidence | Notes |
| --- | --- | --- | --- | --- |
| `flutter_riverpod`, `hooks_riverpod`, `riverpod_annotation` | ACTIVE | Declared in `pubspec.yaml`; root `ProviderScope` in `lib/main.dart`; active `@riverpod` providers are used by startup/auth shell, assignment lists, submission tables, form list lookups, and form/submission permissions. | High | Riverpod is active, but each provider still needs separate reachability evidence. |
| `flutter_hooks` | ACTIVE | Declared in `pubspec.yaml`; active screens/widgets such as `FormSubmissionScreen`, repeat widgets, table screens, assignment screens import hooks. | High | Hook lifecycle interacts with form widgets and scroll/controllers. |
| `stacked`, `stacked_services`, `stacked_generator` | ACTIVE | Declared in `pubspec.yaml`; `@StackedApp`, generated routing, and generated navigation/dialog services remain active. No hand-written active viewmodel pair remains. | High | Do not remove Stacked while the generated router and services still own navigation. |
| `get_it`, `injectable`, `injectable_generator` | ACTIVE | Declared in the root `pubspec.yaml`; `appLocator`, generated app `injection.config.dart`, explicit database registration, user scopes, and form scopes are active. | High | Core services, DB, datasources, and form instances are runtime-located through GetIt. |
| `reactive_forms` | ACTIVE | Declared in `pubspec.yaml`; login form and form submission form use `FormGroup`, `FormArray`, `FormControl`, `ReactiveForm`, and reactive field widgets. | High | Active form value state and repeat rows live in reactive controls. |
| `ChangeNotifier` | ACTIVE | `AuthManager extends ChangeNotifier`; `LocaleService extends ChangeNotifier`; `ref_extension.provider.dart` wraps them for Riverpod. | High | Changing notifier ownership can break root auth/locale updates. |
| `StateNotifierProvider` / `StateProvider` old Riverpod style | OBSOLETE-REMOVED for team management | The isolated team-management state and hard-coded demo screen were removed after confirming they had no active route or consumer. | High | This does not classify other legacy Riverpod providers; each still requires consumer evidence. |
| Old `go_router` path | OBSOLETE-REMOVED | The unimported `lib/app/app_routes/` experiment was removed; production `lib/main.dart` uses the generated Stacked router. | High | Navigation evidence must come from the active Stacked route registration and callers. |
| `rxdart` `BehaviorSubject` sync progress stack | OBSOLETE-REMOVED | `SyncProgressNotifier`, `SyncExecutor`, and `SyncCoordinator` were wired only to each other by generated DI and had no runtime retrieval. | High | Active synchronization continues through `SyncManager` and SDK progress events. |

## Active DI And Scope Map

### Global App Scope

| Registration area | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| Stacked navigation service | ACTIVE | `lib/app/stacked/app.locator.dart` | Generated `setupLocator()` registers `NavigationService`; startup, login, sync, form bootstrap, drawer sync, tables, and assignment detail call `appLocator<NavigationService>()`. | High | Removing it breaks active navigation paths. |
| Stacked dialog/snackbar/bottom-sheet services | UNKNOWN | `lib/app/stacked/app.locator.dart`, `lib/app/stacked/app.dart` | Generated setup registers `DialogService`, `SnackbarService`, and `BottomSheetService`; exact core use sites were not mapped in this pass. | Medium | Registration exists, but strict ACTIVE requires proving a core path uses each service. |
| App injectables | ACTIVE | `lib/app/di/injection.config.dart` | `setupGlobalDependencies(...)` registers SharedPreferences, storage, Auth APIs/storage, sync services, repositories, form services, table services, `Dio`, `AuthManager`, and network adapters. | High | This is the main singleton/factory registration source. Form-only field keys are no longer global. |
| Third-party module | ACTIVE | `lib/app/di/third_party_services.module.dart` | Provides `Dio`, `SharedPreferences`, `FlutterSecureStorage`, and Android device info for injectable registrations. | High | API, auth storage, preferences, and form metadata depend on it. |
| Storage bridge module | ACTIVE | `lib/app/di/sdk_module.dart` | Provides `StorageService` and `TokenStorage` using secure storage or SharedPreferences depending on platform/config. | High | Token/session behavior depends on this bridge; the filename retains former SDK terminology. |
| `FieldContextRegistry` | ACTIVE | `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart`, `field_context_registry.dart` | Registered and disposed in the named submission scope; form widgets and `FormInstance` resolve/use that scoped instance for focus and scroll behavior. | High | Field keys cannot leak between consecutive forms or imply app-wide ownership. |
| `FormMetadataService` factory param | ACTIVE | `lib/app/di/injection.config.dart`, `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` | Registered with `factoryParam<FormMetadataService, FormMetadata, dynamic>`; form bootstrap resolves it with `param1: formMetadata`. | High | Form metadata/attributes depend on factory-parameter DI. |

### Root Database Scope

| Registration area | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| Explicit database factory | ACTIVE | `lib/di/injection.dart` | `registerDatabaseDependencies(...)` registers `DatabaseFactory` as a lazy singleton with disposal. | High | Per-user DB opening depends on this registration. The former generated root/session registration files were removed. |

### User Scope

| Registration area | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| Per-user scope creation | ACTIVE | `lib/core/auth/auth_manager.dart` | `_activateUserSession(...)` calls `appLocator.pushNewScopeAsync(scopeName: username, init: ...)`. | High | User-scoped DB and configuration datasources live under this scope. |
| Multiple datasource registration | ACTIVE | `lib/core/auth/auth_manager.dart` | Scope init calls `getIt.enableRegisteringMultipleInstancesOfOneType()`. | High | Required because many datasources register as the same abstract type. |
| User DB registration | ACTIVE | `lib/core/auth/auth_manager.dart` | Opens `DatabaseFactory.openForUser(username)` and registers one scoped `AppDatabase`. | High | Offline config/form data resolves directly through this owner. The former `DSdk`/`DbManager` wrapper chain was removed. |
| Active user session | ACTIVE | `lib/core/auth/auth_manager.dart` | Registers `UserSession` with instance name `'activeUser'`. | High | Services/widgets rely on active user context. |
| Configuration datasource dependencies | ACTIVE | `lib/core/auth/auth_manager.dart`, `lib/di/init_active_session_scope.dart` | After pushing the scope, `AuthManager` calls `registerUserConfigurationDatasources(appLocator)`. | High | This is the active datasource registration path for sync. |
| Locale service | ACTIVE | `lib/core/auth/auth_manager.dart`, `lib/core/auth/ref_extension.provider.dart` | `LocaleService` is registered after user activation and exposed via Riverpod `localeNotifier`. | High | Root locale resolution depends on this user-scoped service after login. |
| User scope disposal | ACTIVE | `lib/core/auth/auth_manager.dart` | Login/logout use `popScopesTill(username)` when a matching scope exists. | Medium | Scope pop behavior should be runtime-confirmed before changing login/logout or multi-user support. |

### Active Configuration Datasource Registrations

`lib/di/init_active_session_scope.dart` registers these as `AbstractDatasource<dynamic>` factories:

1. `ProjectDatasource`
2. `ActivityDatasource`
3. `OuLevelDatasource`
4. `OrgUnitDatasource`
5. `OptionSetDatasource`
6. `DataElementDatasource`
7. `DataFormTemplateDatasource`
8. `TeamDatasource`
9. `UserFormAccessesDatasource`
10. `AssignmentDatasource`

Evidence: `SyncManager` builds its resource map from `appLocator.getAll<AbstractDatasource<dynamic>>()`; `SyncResourcesController` calls `SyncManager.syncAll()`.

Why it matters: datasource registration order and type shape affect config fetching and offline tables. The manual raw `AbstractDatasource` list is now the sole registration path; its membership and order are covered by `test/dev/active_session_sync_registration_test.dart`.

### Form Submission Scope

| Registration area | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| Per-submission scope creation | ACTIVE | `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` | `bootstrapFlow(...)` creates or loads a `DataInstance`, then `pushNewScopeAsync(scopeName: dataInstance.id, init: ...)`. | High | Each open form gets scoped form services. |
| `FormTemplateRepository` | ACTIVE | `form_flow_bootstrapper_controller.dart` | Registers `FormTemplateRepository.create(versionUid: dataInstance.templateVersion)` in the form scope. | High | Active form rendering uses the loaded flat template from this repository. |
| `FormInstance` | ACTIVE | `form_flow_bootstrapper_controller.dart` | Registers a built `FormInstance` with a GetIt disposer after creating controls, elements, section tree, metadata attributes, and edit status. | High | This is the active form state object and the owner of form-graph/control cleanup. |
| Scope replacement for same submission | ACTIVE | `form_flow_bootstrapper_controller.dart`, `form_scope.dart` | Bootstrap closes an existing current submission scope before creating a replacement, and closes a partially built scope on failure. | High | Repeat/edit changes can be affected by stale scoped state. |
| Route-owned form scope | ACTIVE | `lib/features/form_submission/presentation/form_submission_screen.widget.dart`, `lib/features/form_submission/application/form_scope.dart` | `FormSubmissionScreenState.dispose()` closes the named submission scope after child widgets unmount. GetIt invokes the registered `FormInstance` disposer, which recursively closes element/repeat streams, removes dependency links, disposes the root reactive form, and clears field keys. Focused tests cover route removal and nested repeats. | High | Back, save exit, read-only exit, route replacement, and external route removal share one lifecycle boundary without tearing down controls during transition. |

## Active Riverpod Surface

| Provider area | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| Auth provider bridge | ACTIVE | `lib/core/auth/ref_extension.provider.dart` | `authNotifierProvider` returns `appLocator<AuthManager>()` and notifies Riverpod from `ChangeNotifier`; watched in root `App`. | High | Auth is GetIt-owned but Riverpod-observed. |
| Locale provider bridge | ACTIVE | `lib/core/auth/ref_extension.provider.dart` | `localeNotifierProvider` wraps `appLocator<LocaleService>()`. | High | Locale is user-scope dependent. |
| Preferences | ACTIVE | `lib/core/user_session/preference.provider.dart` | Reads/writes `SharedPreferences` through `appLocator`; root app watches language/theme; table appearance and settings use it. | High | Shared preferences are Riverpod state and persistent storage at once. |
| Login password visibility | ACTIVE | `lib/data/password_visibility.provider.dart` | `LoginView` watches and toggles `passwordVisibilityProvider`; `LoginView` is in Stacked routes. | High | Small active UI state. |
| App about/version | SUPPORTING-USED | `lib/data/app_about_info.provider.dart` | Settings and drawer version item watch `appAboutInfoProvider`. | High | Referenced by reachable UI, but not required for startup/auth/sync/forms/submissions. |
| Activity selection context | ACTIVE | `lib/features/activity/application/activity_list.provider.dart`, `lib/features/activity/presentation/activity_list_view.dart`, assignment providers | Activity list items pass `activityId` directly into `AssignmentScreen`, and assignment providers are keyed by that ID. The former nested activity `ProviderScope`/override was removed. | High | Activity ownership is explicit and no longer depends on a route-local provider container. |
| Assignment list/filter | ACTIVE | `lib/features/assignment/application/assignment_model.provider.dart`, `assignment_filter.provider.dart`, `lib/features/activity/presentation/activity_list_view.dart` | Assignment widgets watch activity-keyed assignment/filter providers; `ActivityListView` reaches `AssignmentScreen` through a direct `MaterialPageRoute`. | High | Assignment state and form availability depend on these providers even though the screen is not a generated Stacked route. |
| Teams list for assignment filtering | ACTIVE | `lib/data/teams.provider.dart` | `filterAssignmentsProvider` awaits `teamsProvider().future`. | High | This provider is active through assignment filtering, separate from the old team management screen. |
| Form list/template providers | ACTIVE | `lib/features/form/application/form_provider.dart`, `lib/data/teams.provider.dart` | Form screens and assignment widgets watch `formListItemsProvider`, `formTemplateProvider`, and `userAvailableFormsProvider`. | High | Form availability and labels are active Riverpod lookups into GetIt services. The unconsumed `availableUserFormTemplatesProvider` was removed during package consolidation. |
| Submission edit/status providers | ACTIVE | `lib/features/form_submission/application/submission_edit_access.dart`, `submission_list.provider.dart` | `FormSubmissionScreen` and table edit cells watch `submissionEditStatusProvider`; both provider and form bootstrap delegate to one tested edit-access query. | High | Edit permissions and synced record behavior depend on this rule, while the final synced-edit product policy remains open. |
| Data instance table providers | ACTIVE | `lib/features/data_instance/application/table.providers.dart`, `table_controller.provider.dart` | `TableScreen`, `PaginatedItemsTable`, and action widgets watch pagination, selection, selected finalized items, appearance, and controller providers. | High | Bulk selection/edit/delete/sync table behavior depends on this state. |
| Reference-field metadata provider | INCOMPLETE | `lib/data/metadata_submission_update.provider.dart`, `q_reference_drop_down_search_field.widget.dart` | `ValueType.Reference` fields render `QReferenceDropDownSearchField`, which watches `systemMetadataSubmissionsProvider`; provider currently returns `[]` after commented metadata-submission logic. Production use depends on synced form JSON containing `ValueType.Reference`. | High for code state, low for runtime frequency | Do not classify as ACTIVE until a production form proves this field type is exercised. |
| User org unit provider | OBSOLETE-REMOVED | Its only found consumer was the removed comment-only org-unit widget; the provider and generated family were then removed. | High | Active org-unit metadata and display paths do not use this provider. |
| Party resolver provider | OBSOLETE-REMOVED | Former placeholder resolver and generated provider had no runtime consumer and were removed with the abandoned party/manifest persistence attempt. | High | Party naming no longer presents a false active access boundary. |
| Form integrity provider | UNKNOWN | `lib/data/form_integrity_check_notifier.provider.dart` | Generated provider exists; static usage found only generated code. | Medium | It may be intended for validation UI, but not proven active. |
| Old Riverpod sync service and NMC worker providers | OBSOLETE-REMOVED | No watcher, worker/plugin registration, or active call existed. The facade only checked connectivity and wrote preference flags. | High | Active config fetching remains `SyncResourcesController` plus `SyncManager`; the controller does not duplicate sync orchestration. |

## Active Stacked Surface

Stacked remains active as generated route and navigation/dialog service infrastructure. No hand-written runtime widget now extends `StackedView`, and no active app viewmodel extends `BaseViewModel`/`StreamViewModel`.

| Area | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| Route registry | ACTIVE | `lib/app/stacked/app.dart`, `app.router.dart` | Generated router contains route entries and navigation extension methods for every `@StackedApp` route. | High | Use this route list to judge active screens first. |
| Startup | ACTIVE | `lib/features/startup/presentation/splash_view.dart`, `lib/features/startup/application/startup_coordinator.dart` | Routed `SplashView` invokes the one-shot coordinator after its first frame; the coordinator initializes auth and routes to login, sync, or home. | High | Startup decides whether sync/config fetching runs, but no general presentation-state library is needed for this command. |
| Login | ACTIVE | `lib/features/login/presentation/login_view.dart`, `lib/features/login/application/login_controller.dart` | Routed `LoginView` owns and disposes a `LoginController`; `reactive_forms` owns field/validation state and Riverpod owns password visibility/connectivity. | High | Successful login still routes to initial configuration sync. |
| Sync resources | ACTIVE | `lib/features/sync/presentation/sync_resources_view.dart`, `lib/features/sync/application/sync_resources.controller.dart` | The routed view watches an auto-dispose Riverpod controller. The controller owns the `SyncManager` progress subscription, UI projection, completion metadata, and navigation; disposal cancels the subscription and pending delayed navigation. | High | Active config fetch UI path. |
| Form bootstrap | ACTIVE | `lib/features/form_submission/presentation/form_flow_bootstrapper.dart`, `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` | The routed stateful widget invokes a one-shot application controller; the controller owns creation of the per-submission GetIt scope. | High | Active form opening still uses generated Stacked navigation, but form bootstrap state no longer depends on a Stacked viewmodel. |
| Home/activity shell and drawer sync entry | ACTIVE | `home_wrapper_page.dart`, `app_drawer.dart`, `app_drawer_sync_item.dart`, `activity_list.provider.dart`, `activity_list_view.dart` | Activity loading is a Riverpod future projection over the scoped database; the stateless drawer sync item routes to `SyncResourcesView`. | Medium/High | This is part of reaching synced/offline data-collection flows. |
| Settings/about UI | SUPPORTING-USED | `settings_view.dart`, `user_settings_tab_view.dart`, `app_drawer_version_item.dart` | Settings is now stateless/Riverpod UI; logout still delegates to `AuthManager`. | Medium | Referenced by reachable UI, but not core form/sync/submission behavior under the strict active test. |
| Sync status badges | SUPPORTING-USED | `lib/features/sync_badges/sync_status_badges_view.dart` | A Riverpod auto-dispose stream provider watches `DataInstancesDao.selectStatusByLevel`; a widget test covers the scoped live count. | High | Removes one duplicate Stacked state owner while preserving live submission-status updates. |
| Dialogs/bottom sheets | UNKNOWN | `lib/app/stacked/app.dart`, generated dialogs/bottomsheets | `InfoAlertDialog` and `NoticeSheet` remain registered through Stacked services but are stateless widgets; exact core use sites were not mapped in this pass. | Medium | Registration alone is not enough to classify them ACTIVE under the strict test. |

## Inactive, Incomplete, Or Legacy-Risk State/DI Code

| Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- |
| OBSOLETE-REMOVED | Old `lib/app/app_routes/` experiment | No active importer; it contained commented routes and an isolated mock `DatarunAuth`. Production uses Stacked navigation and `AuthManager`. | High | The obsolete route names and mock auth can no longer be mistaken for production behavior. |
| OBSOLETE-REMOVED | Old `LoginScreen` and `LoginScreenViewmodel` | Only referenced each other and the commented router. The generated Stacked route uses `LoginView`. | High | The active development-only demo login remains in `LoginView`/`LoginController`. |
| OBSOLETE-REMOVED | Commented Riverpod form-instance/element/table state and completion-dialog providers | No executable references or generated companions existed. Active form state remains scoped GetIt `FormInstance` plus `reactive_forms`; active completion uses `ConfigureFormCompletionDialog`. | High | The removed sketches can no longer be mistaken for active form or completion state. |
| OBSOLETE-REMOVED | Old settings/org-unit picker providers | The settings controller was already removed; the remaining org-unit provider was entirely commented and had no consumer. | High | Active settings and org-unit metadata paths are separate. |
| OBSOLETE-REMOVED | Commented form-state adjunct providers/widgets | Element-properties, submission-creation, popup-section, old org-unit field, and the repeat panel widget had no executable consumer. The panel file retains only the active `EditActionType` contract. | High | Active draft creation, form rendering, org-unit fields, and repeat editing use separate paths. |
| OBSOLETE-REMOVED | Standalone date/time demo entrypoint | It had its own `runApp` and no production importer. | High | Active date/time fields continue through `CustomReactiveDateTimePicker`. |
| OBSOLETE-REMOVED | Old team-management feature and dashboard demo | The screen used hard-coded team summaries, had no route, and was referenced only by a comment-only dashboard. | High | Active assignment/team behavior continues through SDK team persistence and `lib/data/teams.provider.dart`. |
| OBSOLETE-REMOVED | Duplicate coordinator/executor/progress sync stack | Generated DI was its only outside reference; the stack and its private progress models were removed. `SyncScheduler` and `SyncMetadataRepository` remain active. | High | Sync ownership is now clearer without changing the active fetch path. |
| INCOMPLETE | `lib/data/metadata_submission_update.provider.dart` | Provider is used by Reference field widgets but currently returns empty list after commented metadata-submission lookup; production form JSON use of `ValueType.Reference` was not confirmed. | High | Reference fields are reachable by value type, but data backing is incomplete and not proven core-active. |

## Candidate Duplicate Runtime Paths

These are observations only; no removal is recommended yet.

| Area | Candidate duplicate paths | Current evidence |
| --- | --- | --- |
| Routing | `lib/app/stacked/*` vs `lib/app/app_routes/*` | Stacked is active; `app_routes` is commented/obsolete-looking. |
| Login UI | `LoginView` vs `LoginScreen` | `LoginView` is routed; `LoginScreen` is only self-referenced and commented old-router referenced. |
| Form instance state | Scoped GetIt `FormInstance`; obsolete Riverpod provider removed | Active screen uses `appLocator<FormInstance>()`. |
| Form/field state | Active `reactive_forms`/`FormInstance`; obsolete Riverpod provider sketches removed | Active form bootstrap builds `FormGroup` and `Section`. |
| Sync orchestration | `SyncManager`/`SyncResourcesController` | Routed sync uses this path; the controller only projects manager events and both alternate app-side sync implementations were removed. |
| Datasource registration | Explicit `registerUserConfigurationDatasources(...)` only | The unused generated alternative and unreachable concrete user datasource were removed; a registration test locks list membership and submission-pull exclusion. |
| Team state | `lib/data/teams.provider.dart`; obsolete demo state removed | Assignment-scoped team selection uses `lib/data/teams.provider.dart`. |

## Risk Map For Refactoring

| Risk area | Classification | Why it is risky | Files to understand first |
| --- | --- | --- | --- |
| Locator identity | RESOLVED | All active code resolves through the single `appLocator = GetIt.instance`; the app DI entrypoint re-exports it and a focused test asserts identity. | `lib/app/di/injection.dart`, `lib/di/injection.dart` |
| Scope nesting | ACTIVE | High risk: user scope and form submission scope are both GetIt scopes. A service lookup may resolve from current form scope, user scope, or root scope depending on current stack. | `lib/core/auth/auth_manager.dart`, `form_flow_bootstrapper_controller.dart`, `form_submission_screen.widget.dart` |
| Multiple registrations of same type | ACTIVE | High risk: datasources require `enableRegisteringMultipleInstancesOfOneType()` and explicit `AbstractDatasource<dynamic>` registrations. Registration type changes can alter `getAll(...)` results. | `auth_manager.dart`, `init_active_session_scope.dart`, `sync_manager.dart` |
| Form state ownership | ACTIVE | High risk: form widgets are Riverpod/Hook widgets, but active form data lives in `FormInstance` and `reactive_forms` controls from GetIt scope. | `form_flow_bootstrapper_controller.dart`, `form_instance.dart`, `field.widget.dart`, repeat widgets |
| Field key registry | RESOLVED | `FieldContextRegistry` is owned and disposed by the per-submission GetIt scope; the root injectable registration and screen-init clearing were removed. | `field_context_registry.dart`, `form_flow_bootstrapper_controller.dart`, `form_instance.dart` |
| Sync stack duplication | RESOLVED | Duplicate app-side injectable, Riverpod, and NMC worker stacks were removed. The active Riverpod controller is the single routed presentation adapter over `SyncManager`. | `sync_resources.controller.dart`, `sync_manager.dart` |
| Generated files | ACTIVE | High risk: Stacked, injectable, Riverpod, and Drift generated files influence runtime. Manual edits may be overwritten; stale generated code can mislead scans. | `app.router.dart`, `app.locator.dart`, `injection.config.dart`, active `*.provider.g.dart`, Drift generated DB files |
| Conditional provider paths | INCOMPLETE | Reference field metadata path is only exercised by forms containing `ValueType.Reference`; static route reachability alone cannot prove production usage frequency. | `form_widget_factory.dart`, `q_reference_drop_down_search_field.widget.dart`, `metadata_submission_update.provider.dart` |

## Do Not Touch Until Understood

Runtime bootstrap and registration:

- `lib/main.dart`
- `lib/app/di/injection.dart`
- `lib/app/di/injection.config.dart`
- `lib/app/di/third_party_services.module.dart`
- `lib/app/di/sdk_module.dart`
- `lib/app/stacked/app.dart`
- `lib/app/stacked/app.router.dart`
- `lib/app/stacked/app.locator.dart`
- `lib/di/injection.dart`
- `lib/di/init_active_session_scope.dart`

Session and DB scope:

- `lib/core/auth/auth_manager.dart`
- `lib/core/auth/ref_extension.provider.dart`
- `lib/core/user_session/preference.provider.dart`
- `lib/database/db_factory/database_factory.dart`
- `lib/database/db_factory/platform_app.dart`

Form/repeat state:

- `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart`
- `lib/features/form_submission/presentation/form_submission_screen.widget.dart`
- `lib/features/form_submission/application/element/form_instance.dart`
- `lib/features/form_submission/application/field_context_registry.dart`
- `lib/features/form_submission/application/form_widget_factory.dart`
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart`
- `lib/features/form_submission/presentation/section/repeat_table_sliver.dart`
- `lib/features/form_submission/presentation/section/edit_row_screen.dart`

Active Riverpod app state:

- `lib/features/assignment/application/assignment_model.provider.dart`
- `lib/features/assignment/application/assignment_filter.provider.dart`
- `lib/data/teams.provider.dart`
- `lib/features/form/application/form_provider.dart`
- `lib/features/form_submission/application/submission_list.provider.dart`
- `lib/features/data_instance/application/table.providers.dart`
- `lib/features/data_instance/application/table_controller.provider.dart`

Sync runtime ownership:

- `lib/core/sync_manager/sync_manager.dart`
- `lib/features/sync/application/sync_resources.controller.dart`

## Questions Requiring Runtime Confirmation

1. What is the exact scope stack after login, after opening a form, after saving, after back navigation, and after logout?
2. Does `GetIt.getAll<AbstractDatasource<dynamic>>()` return the explicit datasource registrations in the expected order after every login/session restore?
3. Do production forms contain `ValueType.Reference` fields, and if yes is the current empty metadata submission provider accepted behavior or a broken incomplete feature?
4. Do generated Riverpod/injectable/Stacked outputs still match this map after each ownership move?

## Next Investigation Step

The next useful pass should be a runtime verification pass, not a refactor: add temporary instrumentation or use debugger/logs to capture the GetIt scope stack and registered types during startup, login, sync, form open, repeat add/edit, save, and logout. That pass should update this document and the form-flow/config maps before any state-management cleanup starts.
