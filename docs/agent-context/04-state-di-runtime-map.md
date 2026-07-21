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
3. `configureDependencies()` registers Stacked services, app-level injectable services, and SDK-level injectable services.
4. `runApp(...)` wraps the app with a root Riverpod `ProviderScope`.
5. `MaterialApp` uses generated Stacked routing from `lib/app/stacked/app.router.dart`.
6. `AuthManager` creates a per-user GetIt scope after login/session restore.
7. SDK datasource registrations are added to the active user scope by `registerUserSdkDeps(...)`.
8. Opening a form creates a per-submission GetIt scope containing `FormTemplateRepository` and `FormInstance`.
9. Form widgets use Riverpod for widget-level async/selection/preference state, but active form state is held in `FormInstance`, `reactive_forms` controls, and scoped GetIt.

Core risk: the app does not have one state system. Riverpod, Stacked viewmodels, ChangeNotifier, GetIt scopes, generated injectable registrations, and `reactive_forms` all participate in the active runtime for startup/auth/sync/forms/submissions.

## Runtime Boot Path

| Step | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| Production entrypoint | ACTIVE | `lib/main.dart` | `main()` initializes Sentry, calls `configureDependencies()`, then `runApp(SentryWidget(child: ProviderScope(child: App(...))))`. | High | Any DI or provider change must preserve this order. |
| App root state bridge | ACTIVE | `lib/main.dart` | `App extends ConsumerWidget` and watches `authNotifierProvider` plus preference providers for language/theme. | High | Riverpod is active at the root; it is not only feature-local. |
| Generated Stacked routing | ACTIVE | `lib/main.dart`, `lib/app/stacked/app.router.dart` | `MaterialApp.onGenerateRoute` is `StackedRouter().onGenerateRoute`; initial route is `Routes.splashView`. | High | Route registration determines reachability more strongly than file names. |
| Stacked app registration | ACTIVE | `lib/app/stacked/app.dart` | `@StackedApp` lists routed pages: `HomeWrapperPage`, `LoginView`, `SplashView`, `SettingsView`, `SyncResourcesView`, `AssignmentScreen`, `EditRowScreen`, `FormSubmissionScreen`, `FormFlowBootstrapper`, and `TableScreen`. | High | Screens not in this route list need separate proof of reachability. |
| Dependency bootstrap | ACTIVE | `lib/app/di/injection.dart` | `configureDependencies()` calls `setupLocator()`, `setupDialogUi()`, `setupBottomSheetUi()`, `setupGlobalDependencies(appLocator)`, then `setupSdkLocator()`. | High | This is the production DI order. |
| App locator | ACTIVE | `lib/app/di/injection.dart` | `appLocator = StackedLocator.instance.locator`; old `GetIt.instance` line is commented. | High | Runtime service lookups use Stacked's locator facade. |
| SDK locator | ACTIVE | `packages/drun_sdk/lib/di/injection.dart` | `rSdkLocator = GetIt.instance`; `setupSdkLocator()` calls `$initSdkGetIt(rSdkLocator)`. | Medium | Static scan proves the SDK registers into `GetIt.instance`; runtime equivalence with `StackedLocator.instance.locator` should be confirmed before altering locator setup. |

## State And Runtime Libraries Found

| Library/pattern | Classification | Evidence | Confidence | Notes |
| --- | --- | --- | --- | --- |
| `flutter_riverpod`, `hooks_riverpod`, `riverpod_annotation` | ACTIVE | Declared in `pubspec.yaml`; root `ProviderScope` in `lib/main.dart`; active `@riverpod` providers are used by startup/auth shell, assignment lists, submission tables, form list lookups, and form/submission permissions. | High | Riverpod is active, but each provider still needs separate reachability evidence. |
| `flutter_hooks` | ACTIVE | Declared in `pubspec.yaml`; active screens/widgets such as `FormSubmissionScreen`, repeat widgets, table screens, assignment screens import hooks. | High | Hook lifecycle interacts with form widgets and scroll/controllers. |
| `stacked`, `stacked_services`, `stacked_generator` | ACTIVE | Declared in `pubspec.yaml`; `@StackedApp`, generated `app.router.dart`/`app.locator.dart`, Stacked `ViewModelBuilder`, `StackedView`, `BaseViewModel`, and `NavigationService` are active. | High | Navigation and several screen viewmodels depend on this stack. |
| `get_it`, `injectable`, `injectable_generator` | ACTIVE | Declared in app and SDK pubspecs; `appLocator`, generated `injection.config.dart`, SDK `injection.config.dart`, user scopes, and form scopes are active. | High | Core services, DB, SDK datasources, and form instances are runtime-located through GetIt. |
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
| App injectables | ACTIVE | `lib/app/di/injection.config.dart` | `setupGlobalDependencies(...)` registers SharedPreferences, storage, Auth APIs/storage, sync services, repositories, form services, table services, `FieldContextRegistry`, `Dio`, `AuthManager`, and network adapters. | High | This is the main singleton/factory registration source. |
| Third-party module | ACTIVE | `lib/app/di/third_party_services.module.dart` | Provides `Dio`, `SharedPreferences`, `FlutterSecureStorage`, and Android device info for injectable registrations. | High | API, auth storage, preferences, and form metadata depend on it. |
| SDK bridge module | ACTIVE | `lib/app/di/sdk_module.dart` | Provides SDK `StorageService` and `TokenStorage` using secure storage or SharedPreferences depending on platform/config. | High | Token/session behavior depends on this bridge. |
| `FieldContextRegistry` | ACTIVE | `lib/app/di/injection.config.dart`, `lib/features/form_submission/application/field_context_registry.dart` | Registered as lazy singleton; cleared on form screen init; used by `FormInstance` focus/scroll behavior. | High | It is global-looking but used by per-form UI state; repeat and field key changes are risky. |
| `FormMetadataService` factory param | ACTIVE | `lib/app/di/injection.config.dart`, `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart` | Registered with `factoryParam<FormMetadataService, FormMetadata, dynamic>`; form bootstrap resolves it with `param1: formMetadata`. | High | Form metadata/attributes depend on factory-parameter DI. |

### SDK Base Scope

| Registration area | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| SDK base injectables | ACTIVE | `packages/drun_sdk/lib/di/injection.dart`, `packages/drun_sdk/lib/di/injection.config.dart` | `setupSdkLocator()` registers `DatabaseFactory` and parameterized `UserFileManager`. | High | Per-user DB opening depends on this registration. |
| Generated active session scope | LEGACY-RISK | `packages/drun_sdk/lib/di/injection.config.dart` | Generated `initActiveSessionContextScope(...)` registers typed `AbstractDatasource<T>` instances under `'activeSessionContext'`, but static search found no call to it. | Medium | Looks intended, but active app calls manual `registerUserSdkDeps(...)` instead. |

### User Scope

| Registration area | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| Per-user scope creation | ACTIVE | `lib/core/auth/auth_manager.dart` | `_activateUserSession(...)` calls `appLocator.pushNewScopeAsync(scopeName: username, init: ...)`. | High | User-scoped DB and SDK datasources live under this scope. |
| Multiple datasource registration | ACTIVE | `lib/core/auth/auth_manager.dart` | Scope init calls `getIt.enableRegisteringMultipleInstancesOfOneType()`. | High | Required because many SDK datasources register as the same abstract type. |
| User DB registration | ACTIVE | `lib/core/auth/auth_manager.dart` | Opens `DatabaseFactory.openForUser(username)` and registers `AppDatabase` plus `DbManager`. | High | Offline config/form data resolves through the active user scope. |
| Active user session | ACTIVE | `lib/core/auth/auth_manager.dart` | Registers `UserSession` with instance name `'activeUser'`. | High | Services/widgets rely on active user context. |
| User SDK deps | ACTIVE | `lib/core/auth/auth_manager.dart`, `packages/drun_sdk/lib/di/init_active_session_scope.dart` | After pushing the scope, `AuthManager` calls `registerUserSdkDeps(appLocator)`. | High | This is the active datasource registration path for sync. |
| Locale service | ACTIVE | `lib/core/auth/auth_manager.dart`, `lib/core/auth/ref_extension.provider.dart` | `LocaleService` is registered after user activation and exposed via Riverpod `localeNotifier`. | High | Root locale resolution depends on this user-scoped service after login. |
| User scope disposal | ACTIVE | `lib/core/auth/auth_manager.dart` | Login/logout use `popScopesTill(username)` when a matching scope exists. | Medium | Scope pop behavior should be runtime-confirmed before changing login/logout or multi-user support. |

### Active SDK Datasource Registrations

`packages/drun_sdk/lib/di/init_active_session_scope.dart` registers these as untyped `AbstractDatasource` factories:

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

Evidence: `SyncManager` builds its resource map from `appLocator.getAll<AbstractDatasource<dynamic>>()`; `SyncResourcesViewModel` calls `SyncManager.syncAll()`.

Why it matters: datasource registration order and type shape affect config fetching and offline tables. The generated `initActiveSessionContextScope(...)` registers typed `AbstractDatasource<T>` instances, while the active manual function registers raw `AbstractDatasource`. Do not change one assuming it changes the other.

### Form Submission Scope

| Registration area | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| Per-submission scope creation | ACTIVE | `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart` | `bootstrapFlow(...)` creates or loads a `DataInstance`, then `pushNewScopeAsync(scopeName: dataInstance.id, init: ...)`. | High | Each open form gets scoped form services. |
| `FormTemplateRepository` | ACTIVE | `form_flow_bootstrapper_vm.dart` | Registers `FormTemplateRepository.create(versionUid: dataInstance.templateVersion)` in the form scope. | High | Active form rendering uses the loaded flat template from this repository. |
| `FormInstance` | ACTIVE | `form_flow_bootstrapper_vm.dart` | Registers a built `FormInstance` after creating controls, elements, section tree, metadata attributes, and edit status. | High | This is the active form state object. |
| Scope drop on same submission | ACTIVE | `form_flow_bootstrapper_vm.dart` | Drops existing scope when `appLocator.currentScopeName == dataInstance.id`. | High | Repeat/edit changes can be affected by stale scoped state. |
| Scope drop on save/exit | ACTIVE | `lib/features/form_submission/presentation/form_submission_screen.widget.dart` | `NotNow`/`MarkAsFinal` drop current submission scope; back flow calls `popScopesTill(submissionId)` in one branch. | Medium | Exact dispose behavior should be tested with navigation/back stack. |

## Active Riverpod Surface

| Provider area | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| Auth provider bridge | ACTIVE | `lib/core/auth/ref_extension.provider.dart` | `authNotifierProvider` returns `appLocator<AuthManager>()` and notifies Riverpod from `ChangeNotifier`; watched in root `App`. | High | Auth is GetIt-owned but Riverpod-observed. |
| Locale provider bridge | ACTIVE | `lib/core/auth/ref_extension.provider.dart` | `localeNotifierProvider` wraps `appLocator<LocaleService>()`. | High | Locale is user-scope dependent. |
| Preferences | ACTIVE | `lib/core/user_session/preference.provider.dart` | Reads/writes `SharedPreferences` through `appLocator`; root app watches language/theme; table appearance and settings use it. | High | Shared preferences are Riverpod state and persistent storage at once. |
| Login password visibility | ACTIVE | `lib/data/password_visibility.provider.dart` | `LoginView` watches and toggles `passwordVisibilityProvider`; `LoginView` is in Stacked routes. | High | Small active UI state. |
| App about/version | SUPPORTING-USED | `lib/data/app_about_info.provider.dart` | Settings and drawer version item watch `appAboutInfoProvider`. | High | Referenced by reachable UI, but not required for startup/auth/sync/forms/submissions. |
| Activity model override | ACTIVE | `lib/features/activity/application/activity.provider.dart` | `ActivityListView` creates nested `ProviderScope` overriding `activityModelProvider`; assignment providers depend on it. | High | Nested ProviderScopes are active and affect assignment filtering. |
| Assignment list/filter | ACTIVE | `lib/features/assignment/application/assignment_model.provider.dart`, `assignment_filter.provider.dart` | Assignment widgets watch `filterAssignmentsProvider`, `assignmentProvider`, and generated assignment providers; route `AssignmentScreen` is active. | High | Assignment state and form availability depend on these providers. |
| Teams list for assignment filtering | ACTIVE | `lib/data/teams.provider.dart` | `filterAssignmentsProvider` awaits `teamsProvider().future`. | High | This provider is active through assignment filtering, separate from the old team management screen. |
| Form list/template providers | ACTIVE | `lib/features/form/application/form_provider.dart` | Form screens and assignment detail/table widgets watch `formListItemsProvider`, `formTemplateProvider`, and `availableUserFormTemplatesProvider`. | High | Form availability and labels are active Riverpod lookups into GetIt services. |
| Submission edit/status providers | ACTIVE | `lib/features/form_submission/application/submission_list.provider.dart` | `FormSubmissionScreen` and table edit cells watch `submissionEditStatusProvider`. | High | Edit permissions and synced record behavior depend on this provider. |
| Data instance table providers | ACTIVE | `lib/features/data_instance/application/table.providers.dart`, `table_controller.provider.dart` | `TableScreen`, `PaginatedItemsTable`, and action widgets watch pagination, selection, selected finalized items, appearance, and controller providers. | High | Bulk selection/edit/delete/sync table behavior depends on this state. |
| Reference-field metadata provider | INCOMPLETE | `lib/data/metadata_submission_update.provider.dart`, `q_reference_drop_down_search_field.widget.dart` | `ValueType.Reference` fields render `QReferenceDropDownSearchField`, which watches `systemMetadataSubmissionsProvider`; provider currently returns `[]` after commented metadata-submission logic. Production use depends on synced form JSON containing `ValueType.Reference`. | High for code state, low for runtime frequency | Do not classify as ACTIVE until a production form proves this field type is exercised. |
| User org unit provider | OBSOLETE-REMOVED | Its only found consumer was the removed comment-only org-unit widget; the provider and generated family were then removed. | High | Active org-unit metadata and display paths do not use this provider. |
| Party resolver provider | INCOMPLETE | `lib/core/party/providers/party_resolver.provider.dart` | Generated provider exists; static usage found only generated code. Implementation contains placeholder principals and placeholder party IDs. | High | Party/manifest tables should not be treated as active assignment/form availability until runtime proves this provider is used. |
| Form integrity provider | UNKNOWN | `lib/data/form_integrity_check_notifier.provider.dart` | Generated provider exists; static usage found only generated code. | Medium | It may be intended for validation UI, but not proven active. |
| Old Riverpod sync service and NMC worker providers | OBSOLETE-REMOVED | No watcher, worker/plugin registration, or active call existed. The facade only checked connectivity and wrote preference flags. | High | Active config fetching remains `SyncResourcesViewModel` plus `SyncManager`. |

## Active Stacked Surface

| Area | Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- | --- |
| Route registry | ACTIVE | `lib/app/stacked/app.dart`, `app.router.dart` | Generated router contains route entries and navigation extension methods for every `@StackedApp` route. | High | Use this route list to judge active screens first. |
| Startup | ACTIVE | `lib/features/startup/presentation/splash_view.dart`, `splash_viewmodel.dart` | `SplashView` is routed; viewmodel routes to login, sync, or home. | High | Startup decides whether sync/config fetching runs. |
| Login | ACTIVE | `lib/features/login/presentation/login_view.dart`, `login_viewmodel.dart` | `LoginView` is routed and uses `ViewModelBuilder<LoginViewModel>.reactive`. | High | Old `LoginScreen` is not the routed login page. |
| Sync resources | ACTIVE | `lib/features/sync/presentation/sync_resources_view.dart`, `sync_resources_viewmodel.dart` | `SyncResourcesView` is routed; viewmodel owns `SyncManager` stream and completion navigation. | High | Active config fetch UI path. |
| Form bootstrap | ACTIVE | `lib/features/form_submission/presentation/form_flow_bootstrapper.dart`, `form_flow_bootstrapper_vm.dart` | Routed by `FormFlowBootstrapper`; extends `StackedView<FormFlowBootstrapperVm>`. | High | Owns creation of per-submission GetIt scope. |
| Home/activity shell and drawer sync entry | ACTIVE | `home_wrapper_page.dart`, `app_drawer.dart`, `app_drawer_sync_item.dart`, `activity_list_view.dart` | Routed/home paths use Stacked and Riverpod widgets; drawer sync item routes to `SyncResourcesView`. | Medium/High | This is part of reaching synced/offline data-collection flows. |
| Settings/about UI | SUPPORTING-USED | `settings_view.dart`, `user_settings_tab_view.dart`, `app_drawer_version_item.dart` | Settings route exists and widgets watch supporting providers. | Medium | Referenced by reachable UI, but not core form/sync/submission behavior under the strict active test. |
| Dialogs/bottom sheets | UNKNOWN | `lib/app/stacked/app.dart`, generated dialogs/bottomsheets | `InfoAlertDialog` and `NoticeSheet` are registered through Stacked generator, but exact core use sites were not mapped in this pass. | Medium | Registration alone is not enough to classify as ACTIVE under the strict test. |

## Inactive, Incomplete, Or Legacy-Risk State/DI Code

| Classification | File path | Evidence | Confidence | Why it matters |
| --- | --- | --- | --- | --- |
| OBSOLETE-REMOVED | Old `lib/app/app_routes/` experiment | No active importer; it contained commented routes and an isolated mock `DatarunAuth`. Production uses Stacked navigation and `AuthManager`. | High | The obsolete route names and mock auth can no longer be mistaken for production behavior. |
| OBSOLETE-REMOVED | Old `LoginScreen` and `LoginScreenViewmodel` | Only referenced each other and the commented router. The generated Stacked route uses `LoginView`. | High | The active development-only demo login remains in `LoginView`/`LoginViewModel`. |
| OBSOLETE-REMOVED | Commented Riverpod form-instance/element/table state and completion-dialog providers | No executable references or generated companions existed. Active form state remains scoped GetIt `FormInstance` plus `reactive_forms`; active completion uses `ConfigureFormCompletionDialog`. | High | The removed sketches can no longer be mistaken for active form or completion state. |
| OBSOLETE-REMOVED | Old settings/org-unit picker providers | The settings controller was already removed; the remaining org-unit provider was entirely commented and had no consumer. | High | Active settings and org-unit metadata paths are separate. |
| OBSOLETE-REMOVED | Commented form-state adjunct providers/widgets | Element-properties, submission-creation, popup-section, old org-unit field, and old repeat edit-panel files had no executable implementation or consumer. | High | Active draft creation, form rendering, org-unit fields, and repeat editing use separate paths. |
| OBSOLETE-REMOVED | Standalone date/time demo entrypoint | It had its own `runApp` and no production importer. | High | Active date/time fields continue through `CustomReactiveDateTimePicker`. |
| OBSOLETE-REMOVED | Old team-management feature and dashboard demo | The screen used hard-coded team summaries, had no route, and was referenced only by a comment-only dashboard. | High | Active assignment/team behavior continues through SDK team persistence and `lib/data/teams.provider.dart`. |
| OBSOLETE-REMOVED | Duplicate coordinator/executor/progress sync stack | Generated DI was its only outside reference; the stack and its private progress models were removed. `SyncScheduler` and `SyncMetadataRepository` remain active. | High | Sync ownership is now clearer without changing the active fetch path. |
| INCOMPLETE | `lib/core/party/providers/party_resolver.provider.dart` | Placeholder user/team/party IDs; generated provider exists but no static use outside generated file. | High | Party resolution appears not production-ready. |
| INCOMPLETE | `lib/data/metadata_submission_update.provider.dart` | Provider is used by Reference field widgets but currently returns empty list after commented metadata-submission lookup; production form JSON use of `ValueType.Reference` was not confirmed. | High | Reference fields are reachable by value type, but data backing is incomplete and not proven core-active. |
| LEGACY-RISK | `packages/drun_sdk/lib/di/injection.config.dart` generated `initActiveSessionContextScope(...)` | Generated typed datasource registration exists but no call was found; active user scope calls manual `registerUserSdkDeps(...)`. | Medium | Future DI regeneration could revive or alter this path. |

## Candidate Duplicate Runtime Paths

These are observations only; no removal is recommended yet.

| Area | Candidate duplicate paths | Current evidence |
| --- | --- | --- |
| Routing | `lib/app/stacked/*` vs `lib/app/app_routes/*` | Stacked is active; `app_routes` is commented/obsolete-looking. |
| Login UI | `LoginView` vs `LoginScreen` | `LoginView` is routed; `LoginScreen` is only self-referenced and commented old-router referenced. |
| Form instance state | Scoped GetIt `FormInstance`; obsolete Riverpod provider removed | Active screen uses `appLocator<FormInstance>()`. |
| Form/field state | Active `reactive_forms`/`FormInstance`; obsolete Riverpod provider sketches removed | Active form bootstrap builds `FormGroup` and `Section`. |
| Sync orchestration | `SyncManager`/`SyncResourcesViewModel` | Routed sync uses this path; both alternate app-side sync stacks were removed. |
| SDK datasource registration | Manual `registerUserSdkDeps(...)` vs generated `initActiveSessionContextScope(...)` | Active auth manager calls manual function; generated function not called by static refs. |
| Team state | `lib/data/teams.provider.dart`; obsolete demo state removed | Assignment-scoped team selection uses `lib/data/teams.provider.dart`. |

## Risk Map For Refactoring

| Risk area | Classification | Why it is risky | Files to understand first |
| --- | --- | --- | --- |
| Locator identity | UNKNOWN | App `appLocator` comes from `StackedLocator.instance.locator`; SDK uses `GetIt.instance`. They appear to cooperate in the current app, but static scan should be confirmed at runtime. | `lib/app/di/injection.dart`, `packages/drun_sdk/lib/di/injection.dart` |
| Scope nesting | ACTIVE | High risk: user scope and form submission scope are both GetIt scopes. A service lookup may resolve from current form scope, user scope, or root scope depending on current stack. | `lib/core/auth/auth_manager.dart`, `form_flow_bootstrapper_vm.dart`, `form_submission_screen.widget.dart` |
| Multiple registrations of same type | ACTIVE | High risk: datasources require `enableRegisteringMultipleInstancesOfOneType()` and raw `AbstractDatasource` registrations. Typed vs untyped changes can alter `getAll(...)` results. | `auth_manager.dart`, `init_active_session_scope.dart`, `sync_manager.dart` |
| Form state ownership | ACTIVE | High risk: form widgets are Riverpod/Hook widgets, but active form data lives in `FormInstance` and `reactive_forms` controls from GetIt scope. | `form_flow_bootstrapper_vm.dart`, `form_instance.dart`, `field.widget.dart`, repeat widgets |
| Field key registry | ACTIVE | High risk: `FieldContextRegistry` is app-level lazy singleton but cleared during form screen init and used by form instance focus/scroll. | `field_context_registry.dart`, `form_submission_screen.widget.dart`, `form_instance.dart` |
| Sync stack duplication | RESOLVED | Duplicate app-side injectable, Riverpod, and NMC worker stacks were removed. | `sync_resources_viewmodel.dart`, `sync_manager.dart` |
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
- `packages/drun_sdk/lib/di/injection.dart`
- `packages/drun_sdk/lib/di/injection.config.dart`
- `packages/drun_sdk/lib/di/init_active_session_scope.dart`

Session and DB scope:

- `lib/core/auth/auth_manager.dart`
- `lib/core/auth/ref_extension.provider.dart`
- `lib/core/user_session/preference.provider.dart`
- `packages/drun_sdk/lib/database/db_factory/database_factory.dart`
- `packages/drun_sdk/lib/database/db_factory/platform_app.dart`

Form/repeat state:

- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart`
- `lib/features/form_submission/presentation/form_submission_screen.widget.dart`
- `lib/features/form_submission/application/element/form_instance.dart`
- `lib/features/form_submission/application/field_context_registry.dart`
- `lib/features/form_submission/application/form_widget_factory.dart`
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart`
- `lib/features/form_submission/presentation/section/repeat_table_sliver.dart`
- `lib/features/form_submission/presentation/section/edit_row_screen.dart`
- `lib/features/form_submission/presentation/section/edit_row_panel.dart`

Active Riverpod app state:

- `lib/features/assignment/application/assignment_model.provider.dart`
- `lib/features/assignment/application/assignment_filter.provider.dart`
- `lib/data/teams.provider.dart`
- `lib/features/form/application/form_provider.dart`
- `lib/features/form_submission/application/submission_list.provider.dart`
- `lib/features/data_instance/application/table.providers.dart`
- `lib/features/data_instance/application/table_controller.provider.dart`

Sync/runtime duplication:

- `lib/core/sync_manager/sync_manager.dart`
- `lib/features/sync/presentation/sync_resources_viewmodel.dart`

## Questions Requiring Runtime Confirmation

1. Does `StackedLocator.instance.locator` resolve to the same underlying GetIt instance as SDK `GetIt.instance` on all supported platforms?
2. What is the exact scope stack after login, after opening a form, after saving, after back navigation, and after logout?
3. Does `GetIt.getAll<AbstractDatasource<dynamic>>()` return the manual raw datasource registrations in the expected order after every login/session restore?
4. Is generated `initActiveSessionContextScope(...)` ever called indirectly by generated code or build tooling, or is it fully dead?
5. Do production forms contain `ValueType.Reference` fields, and if yes is the current empty metadata submission provider accepted behavior or a broken incomplete feature?
6. Does form scope disposal always run when the user leaves a form through Android back, app backgrounding, route replacement, or completion dialog actions?
7. After the tooling branch is merged, do generated Riverpod/injectable/Stacked outputs still match this map?

## Next Investigation Step

The next useful pass should be a runtime verification pass, not a refactor: add temporary instrumentation or use debugger/logs to capture the GetIt scope stack and registered types during startup, login, sync, form open, repeat add/edit, save, and logout. That pass should update this document and the form-flow/config maps before any state-management cleanup starts.
