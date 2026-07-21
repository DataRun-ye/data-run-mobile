# Classification Reconciliation Pass

Generated: 2026-07-10

Scope: reconcile `01-production-code-path-map.md`, `02-form-flow.md`, `03-config-fetching.md`, and `04-state-di-runtime-map.md` under a stricter active-code definition. This document is an overlay on the earlier maps: it does not invalidate their evidence, but it supersedes older classifications where later scans proved a narrower label.

Update 2026-07-21: this reconciliation preserves the earlier `repeatUid` finding as mobile-side evidence only. The backend-validated contract is repeat metadata with `_id`, `_index`, `_parentId`, and `_submissionUid`; see `07-repeat-uid-contract.md`.

## Strict Legend

- ACTIVE: commenting/removing the path without replacement would break app startup/auth/navigation, sync/offline cache, assignment/form access, form load/render/repeat/edit/save, or submission table behavior.
- SUPPORTING-USED: referenced by reachable production UI or helper flows, but core app/forms/sync/data-collection would still run if the feature were removed intentionally.
- INACTIVE: not referenced by the active runtime flow found in static scans.
- INCOMPLETE: reachable or plausible code exists, but the implementation is unfinished, placeholder-based, or returns empty/no-op data.
- LEGACY-RISK: old, duplicate, registered-only, or conceptually related code that could be mistaken for active, but is not proven to be required by the current core flow.
- UNKNOWN: static evidence cannot prove whether the path is required.

Strict comment-out test: ACTIVE is not assigned just because a file compiles, is generated, appears in DI, is imported by another non-core file, has a form-looking/table-looking name, or is reachable only through stale/commented code. A path is ACTIVE only when removing it would break the running app or a current core data-collection feature.

## Main Finding

Yes, the earlier passes contain some over-classifications. The largest source is `01-production-code-path-map.md`, whose legend used "reachable through entrypoints, DI, imports, routes, or direct call sites" as active evidence. That was useful for first mapping, but too broad for demotion/removal planning.

The second source is `03-config-fetching.md`, where "ACTIVE" sometimes means "registered in the bulk sync datasource list" and sometimes means "required by offline consumers." Those are different. Under the strict test, a datasource can be active as part of the sync loop while the table it fills may still be supporting, conditional, or unproven for a specific form feature.

`02-form-flow.md` is mostly aligned for the form/repeat/save path, but a few rows should be read more narrowly: active widget use is not the same as active generated route registration, and display/summary helpers are not the same as form load/save core.

`04-state-di-runtime-map.md` already introduced the stricter test. This pass adds one correction to it: `DialogService` is ACTIVE, while `SnackbarService` and Stacked `BottomSheetService` remain unproven.

## Reconciled Corrections

| Earlier map area | Earlier label | Reconciled label | Evidence and correction |
| --- | --- | --- | --- |
| `01` status legend | Active if reachable/imported/registered/routed | Use this document's strict labels | The old label is too broad for cleanup. Treat `01` "Active" as "reachable evidence" unless confirmed by `02`, `03`, `04`, or this document. |
| Generated Stacked router and locator | Active generated code | ACTIVE | `lib/main.dart` uses `StackedRouter().onGenerateRoute`; active navigation uses `NavigationService`. Generated route/locator output is required, but should not be edited manually. |
| Stacked `SettingsView` and about/version UI | Active route/UI | SUPPORTING-USED | Settings is routed, but removing settings/about display would not break startup, sync, form capture, repeat edit, save, or submission table behavior. |
| Stacked `DialogService` | UNKNOWN in `04` | ACTIVE | `DExceptionReporter` uses `appLocator<DialogService>().showDialog(...)`; login/startup/form-template error paths call the reporter. |
| Stacked `SnackbarService` | Registered/generated | UNKNOWN | Static scan found registration but no required core call site. Do not classify active from generated registration alone. |
| Stacked `BottomSheetService` | Registered/generated | UNKNOWN | Active form completion uses Flutter `showModalBottomSheet`, not Stacked `BottomSheetService`. Generated registration alone is not enough. |
| `EditRowScreen` widget | ACTIVE in `02` | ACTIVE | Repeat edit constructs `EditRowScreen` through `NavigationService.navigateToView(...)`; commenting the widget would break active repeat editing. |
| `EditRowScreen` generated Stacked route | ACTIVE in `02` | LEGACY-RISK | The generated `navigateToEditRowScreen` route was not proven required because the active repeat edit path constructs the widget through `navigateToView(...)`. |
| `EditRowPanel` and dialog repeat edit path | LEGACY-RISK in `02` | OBSOLETE-REMOVED | The active path always navigated to `EditRowScreen`; the unreachable `if (true)` alternative, `showEditDialog(...)`, and panel widget were removed. |
| Riverpod as a library | ACTIVE | ACTIVE | Root `ProviderScope` and many providers are active, but every provider still needs per-provider evidence. Generated `*.provider.g.dart` files are not active unless their provider is watched by a core path. |
| Old team `StateNotifierProvider` files | Active-looking Riverpod state | OBSOLETE-REMOVED | The only screen used hard-coded demo data, had no active route, and was referenced only by a comment-only dashboard. Active assignment filtering remains in `lib/data/teams.provider.dart`. |
| `SyncCoordinator`, `SyncExecutor`, `SyncProgressNotifier` | Registered injectables | OBSOLETE-REMOVED | Generated DI was their only outside reference. The duplicate stack and private progress models were removed; active sync remains `SyncResourcesViewModel` plus `SyncManager`. |
| `syncServiceProvider` and NMC worker providers | Provider exists | OBSOLETE-REMOVED | No active watcher/worker registration existed; `performSync` did not perform the real download. The unused facade, worker models, and dependent legacy session service were removed. |
| SDK `initActiveSessionContextScope(...)` | Generated active session scope | LEGACY-RISK | Generated typed datasource registration exists, but active auth calls manual `registerUserSdkDeps(appLocator)`. Do not refactor the generated scope assuming production uses it. |
| `UserDatasource` | Mixed/uncertain in `03` | LEGACY-RISK | It is registered as concrete `UserDatasource`, not collected by `SyncManager.getAll<AbstractDatasource>()`; active profile fetch is `AuthApi.getUserProfile`. |
| Abandoned manifest service / party persistence attempt | INCOMPLETE in `03` | OBSOLETE-REMOVED | No runtime consumer, incomplete persistence, placeholder resolver, and no tables in the Play schema-3 database. Removed from active DI/schema declarations; no table-drop migration is performed. |
| Bulk `AbstractDatasource` list | ACTIVE | ACTIVE | The 10 raw `AbstractDatasource` registrations in `init_active_session_scope.dart` are core to current config sync because `SyncManager` collects them. Submission pull is intentionally excluded. |
| `DataElementDatasource` | ACTIVE in `01`/`03` | ACTIVE | The datasource is in the `AbstractDatasource` sync loop. |
| `data_elements` table as form-render source | ACTIVE in `01`/`03` | SUPPORTING-USED | Direct form rendering mainly uses `form_template_versions` JSON; `data_elements` supports display/value metadata and older data-value paths. |
| `UserFormAccessesDatasource` | ACTIVE in `03` | ACTIVE | The datasource is in the `AbstractDatasource` sync loop. |
| `user_form_permissions` as access gate | ACTIVE in `03` | UNKNOWN | Active form access checks found in later passes rely mostly on `assignment_forms`; direct production use of `user_form_permissions` was not proven. |
| `assignment_forms` | ACTIVE | ACTIVE | Used by available forms, assignment detail access, edit permissions, and form list filtering. This is the active form-access table. |
| `sync_summaries` | ACTIVE in `03` | SUPPORTING-USED | `BaseDataSource` writes summaries. The unreachable `SyncSummaryCard` UI was removed; core sync completion uses progress/global state and SharedPreferences flags. |
| `DisplayValueLookup` display helper | Partially active in `01`, LEGACY-RISK in `02` | SUPPORTING-USED | `DisplayValueLookup` is used by `MapValueToDisplay`; its naming and API now expose that it is display support, not capture persistence. |
| `data_values` table as capture storage | Previously partially active/LEGACY-RISK | OBSOLETE-REMOVED | DAO/datasource/CRUD callers and table are removed; migration 5 preserves active whole submission JSON. |
| `repeat_instances` table | Previously LEGACY-RISK | OBSOLETE-REMOVED | DAO/datasource/table are removed; migration 5 preserves repeats in nested submission JSON. |
| `metadata_submissions` and `systemMetadataSubmissionsProvider` | Inactive/incomplete in `01`/`03`, incomplete in `04` | INCOMPLETE | The comment-only SDK table/datasource artifacts were removed. Reference widgets can still watch the provider, but it currently returns `[]` after commented DB logic. Production use depends on forms containing `ValueType.Reference`. |
| `partyResolverProvider` and party/manifest tables | Mixed/uncertain in `03`, INCOMPLETE in `04` | INCOMPLETE | Provider contains placeholder user/team/party IDs and no static production consumer was found. |
| Form route/load/save/repeat core in `02` | ACTIVE | ACTIVE | `FormFlowBootstrapperVm`, `FormTemplateRepository`, `FormElementControlBuilder`, `FormElementBuilder`, `FormInstance`, repeat models/widgets, and `DataInstancesDao.updateData` pass the strict test. |
| Form summary utilities | ACTIVE in `02` | ACTIVE | `FormDataUtil`/`FormDataAggregator` are active through submission table summaries, but not part of form load/save/repeat persistence. |
| `CodeGenerator` | ACTIVE in `02` | ACTIVE | Active for submission IDs and referenced by old repeat UID UI code. Backend validation later proved mobile should write repeat metadata, not `repeatUid`; see `07-repeat-uid-contract.md`. |
| Example/debug `main()` functions inside helper files | Mentioned as examples | INACTIVE | Files like date-time demos or aggregator examples are not production entrypoints unless imported by `lib/main.dart` or routed production paths. |

## Strict Active Core To Carry Forward

These are the paths that should remain treated as core-active until runtime proves otherwise.

App/session/bootstrap:

- `lib/main.dart`
- `lib/app/di/injection.dart`
- `lib/app/di/injection.config.dart`
- `lib/app/di/third_party_services.module.dart`
- `lib/app/di/sdk_module.dart`
- `lib/app/stacked/app.dart`
- `lib/app/stacked/app.router.dart`
- `lib/app/stacked/app.locator.dart`
- `lib/core/auth/auth_manager.dart`
- `lib/core/auth/ref_extension.provider.dart`
- `lib/core/user_session/preference.provider.dart`

Sync/offline cache:

- `lib/features/sync/presentation/sync_resources_view.dart`
- `lib/features/sync/presentation/sync_resources_viewmodel.dart`
- `lib/core/sync_manager/sync_manager.dart`
- `packages/drun_sdk/lib/datasource/base_datasource.dart`
- `packages/drun_sdk/lib/di/init_active_session_scope.dart`
- Active `AbstractDatasource` implementations registered by `registerUserSdkDeps(...)`
- `packages/drun_sdk/lib/database/db_factory/database_factory.dart`
- `packages/drun_sdk/lib/database/db_factory/platform_app.dart`
- `packages/drun_sdk/lib/database/app_database.dart`

Assignment/form access and listing:

- `lib/features/assignment/application/assignment_model.provider.dart`
- `lib/features/assignment/application/assignment_filter.provider.dart`
- `lib/features/assignment/application/assignment_service_impl.dart`
- `lib/data/teams.provider.dart`
- `lib/data/form_template_list_service.dart`
- `lib/features/form/application/form_provider.dart`
- `packages/drun_sdk/lib/database/dao/assignments_dao.dart`
- `assignment_forms` table and access queries

Form/repeat/save:

- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart`
- `lib/data/form_template_repository.dart`
- `lib/core/form/builder/form_element_control_builder.dart`
- `lib/core/form/builder/form_element_builder.dart`
- `lib/features/form_submission/application/element/form_instance.dart`
- `lib/features/form_submission/application/element/form_element.dart`
- `lib/features/form_submission/application/element/section_instance.dart`
- `lib/features/form_submission/application/element/repeat_section.dart`
- `lib/features/form_submission/application/element/repeat_item_instance.dart`
- `lib/features/form_submission/application/element/field_instance.dart`
- `lib/features/form_submission/presentation/form_submission_screen.widget.dart`
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart`
- `lib/features/form_submission/presentation/section/repeat_table_rows_source.dart`
- `lib/features/form_submission/presentation/section/edit_row_screen.dart`
- `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart`
- `packages/drun_sdk/lib/database/tables/data_submissions.table.dart`
- `packages/drun_sdk/lib/database/extensions/data_submission.extension.dart`

Submission table:

- `lib/features/data_instance/application/table.providers.dart`
- `lib/features/data_instance/application/table_controller.provider.dart`
- `lib/features/data_instance/data/drift_table_repository.dart`
- `lib/features/data_instance/presentation/table_screen.dart`
- `lib/features/data_instance/presentation/table_widget.dart`
- `packages/drun_sdk/lib/core/data_instance/form_data_util.dart`

## Supporting Or Conditional Paths

These are used or plausible, but should not be treated as core-active without more proof.

| Path | Reconciled label | Reason |
| --- | --- | --- |
| `lib/data/app_about_info.provider.dart` | SUPPORTING-USED | Version/about display only. |
| Settings screens and appearance/preferences UI | SUPPORTING-USED | Reachable UI, but not core data-collection behavior. Preference provider itself remains ACTIVE because root app and table appearance use it. |
| `SyncSummaryCard` UI | OBSOLETE-REMOVED | It had no executable consumer; `sync_summaries` persistence remains supporting-used independently. |
| `DisplayValueLookup` | SUPPORTING-USED | Resolves org-unit/team/option labels only; inactive normalized value persistence was removed. |
| `data_elements` table | SUPPORTING-USED | Synced actively, used by display/older metadata helpers, but not the primary form JSON source. |
| `ValueType.Reference` widgets and metadata provider | INCOMPLETE | Field factory can route to reference widgets, but provider returns empty data and production form use is unconfirmed. |
| `UserFormAccessesDatasource` table output | UNKNOWN | Synced actively, but active access checks rely on `assignment_forms`. |
| `DialogService` custom info dialog | ACTIVE | Error reporting and a test upload dialog use it. |
| Stacked `SnackbarService` / `BottomSheetService` | UNKNOWN | Registered, but no core active call site found. |

## Demotion Candidates

Do not delete these yet, but they are strong candidates for demotion/removal after runtime confirmation.

- `lib/core/sync_manager/sync_service.provider.dart`
- `packages/drun_sdk/lib/di/injection.config.dart` generated `initActiveSessionContextScope(...)`
- `packages/drun_sdk/lib/datasource/remote_datasource_order_map.dart`
- `metadata_submissions` table/datasource
- `party`/manifest provider and tables, unless a future runtime pass proves production use

## Open Reconciliation Questions

1. Do real production forms contain `ValueType.Reference` fields? If yes, the reference widget path is reachable, but its provider still appears incomplete.
2. Are `user_form_permissions` ever used for active access decisions, or is `assignment_forms` the only active permission gate?
3. Does the generated SDK `initActiveSessionContextScope(...)` ever run after code generation or through tests, or is manual `registerUserSdkDeps(...)` the only production path?
4. Which synced resources are semantically required for current production forms, beyond being registered in the sync loop?
5. Are Stacked `SnackbarService` or `BottomSheetService` used by any runtime feature outside static Dart references?
6. Should `sync_summaries` remain a core table, or is it supporting/debug sync telemetry?

## Next Step

Before the next feature/refactor pass, update future maps to use this strict legend from the start. For existing maps, read this document as the label overlay:

- Use `01` mainly for broad entrypoint evidence and candidate surfaces.
- Use `02` as the strongest static source for active form/repeat/save behavior.
- Use `03` as the strongest static source for active sync fetch registration, but separate "synced resource" from "core offline consumer."
- Use `04` for state/DI ownership, with the DialogService correction recorded above.

The next runtime confirmation pass should focus on GetIt scope behavior, datasource registration order, real form JSON value types, repeat UID persistence, and whether supporting tables/providers are actually touched during normal production workflows.
