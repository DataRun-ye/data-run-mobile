# Production Code Path Map

Generated: 2026-07-10

Scope: map active production paths before refactoring. This treats docs, names, comments, and stale-looking code as evidence only. Classifications below are based on live imports, route registration, DI registration, and call sites found in this scan.

Update 2026-07-21: rows that mention `repeatUid` reflect the original mobile-only scan. Backend validation later proved the active server contract is repeat metadata with `_id`, `_index`, `_parentId`, and `_submissionUid`; see `07-repeat-uid-contract.md`.

Status legend:

- Active: reachable through current app entrypoints, DI, imports, routes, or direct call sites.
- Inactive: present but not found in current call paths.
- Uncertain: has some references, but production reachability was not proven.
- Obsolete-looking: mostly commented, generated-but-unused, or superseded by another active path.

## 1. Main app entrypoints

Active:

- `android/app/src/main/kotlin/org/datarun/app/MainActivity.kt:5` is the Android native shell entrypoint and extends `FlutterActivity`.
- `lib/main.dart:25` defines `main()`.
- `lib/main.dart:28` wraps app startup in `SentryFlutter.init`.
- `lib/main.dart:70` calls `configureDependencies()`.
- `lib/main.dart:93` runs the app inside `ProviderScope`.
- `lib/main.dart:101` defines `App extends ConsumerWidget`.
- `lib/main.dart:174` uses `StackedRouter().onGenerateRoute`.
- `lib/main.dart:180` sets `Routes.splashView` as the initial route.
- `lib/app/stacked/app.dart:19-29` registers current Stacked routes: `HomeWrapperPage`, `LoginView`, `SplashView`, `SettingsView`, `SyncResourcesView`, `AssignmentScreen`, `EditRowScreen`, `FormSubmissionScreen`, `FormFlowBootstrapper`, and `TableScreen`.
- `lib/features/startup/presentation/splash_viewmodel.dart:20-25` routes authenticated users to sync or home, and unauthenticated users to login.
- `lib/features/home/presentation/home_wrapper_page.dart:19` shows `ActivityListView` as the home body.
- `lib/features/activity/presentation/activity_list_view.dart:38` opens `AssignmentScreen` from an activity card.

Obsolete-looking or inactive:

- The older `lib/app/app_routes/*` experiment was removed after confirming it had no active importer. Current `MaterialApp` uses the Stacked router in `lib/main.dart`.
- `lib/app/stacked/app.router.dart` is active generated route code, but should not be edited manually.

## 2. SDK entrypoints and app consumption

Active:

- `pubspec.yaml:17-18` consumes `d_sdk` as a local path dependency: `./packages/drun_sdk`.
- `lib/app/di/injection.dart:18-32` configures app dependencies, then calls `setupSdkLocator()`.
- `packages/drun_sdk/lib/di/injection.dart:23` initializes SDK GetIt registrations.
- `lib/core/auth/auth_manager.dart:144-163` creates the per-user app scope, opens the SDK Drift database, registers `AppDatabase`, registers `DbManager`, then calls `registerUserSdkDeps(appLocator)`.
- `packages/drun_sdk/lib/di/init_active_session_scope.dart:33-60` registers active SDK data sources for the user session. Registered resources include projects, activities, org units, option sets, data elements, form templates, teams, user form access, assignments, and data submissions.
- `packages/drun_sdk/lib/d_sdk.dart:9` exposes the `DSdk` facade over `DbManager`; app code uses `DSdk.db` and DAO accessors in form and submission flows.
- `packages/drun_sdk/lib/database/db_factory/database_factory.dart` and `packages/drun_sdk/lib/database/db_factory/platform_app.dart` open per-user Drift database files.

Uncertain:

- `packages/drun_sdk/lib/di/injection.config.dart:69` defines `initActiveSessionContextScope`, but this scan only found app calls to `registerUserSdkDeps` and `setupSdkLocator`.

Obsolete-looking:

- `packages/drun_sdk/lib/datasource/remote_data_sources/form_template_version_datasource.dart:6-7` has inactive/commented Injectable annotations. Form versions are loaded by `DataFormTemplateDatasource` instead.

## 3. Active form-loading path

Active high-level path:

1. A user opens or creates a submission from a table or assignment detail.
2. Navigation goes to `FormFlowBootstrapper`.
3. The bootstrapper creates or loads a `DataInstance`.
4. It loads the form template/version JSON from local Drift tables.
5. It builds a full in-memory `FormGroup` and full `FormElementInstance` tree.
6. It registers `FormTemplateRepository` and `FormInstance` in a GetIt scope named by submission id.
7. It replaces the route with `FormSubmissionScreen`.

Active evidence:

- `lib/features/data_instance/presentation/table_screen.dart:93` creates a new submission by navigating to `FormFlowBootstrapper`.
- `lib/features/data_instance/presentation/table_widget.dart:62` edits an existing item by navigating to `FormFlowBootstrapper` with `submissionId`, `formId`, `versionId`, and `assignmentId`.
- `lib/features/assignment_detail/presentation/details_submissions_table.dart:201` also edits by navigating to `FormFlowBootstrapper`.
- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:47` creates a draft via `_db.dataInstancesDao.createDraft(...)` when `submissionId == null`.
- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:60-68` pushes a GetIt scope for the submission and registers `FormTemplateRepository` plus `FormInstance`.
- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:65` loads template data through `FormTemplateRepository.create(versionUid: dataInstance.templateVersion)`.
- `lib/data/form_template_repository.dart:21-27` loads `FormTemplateModel`, options, and option sets.
- `lib/data/form_template_list_service.dart:154` fetches form templates through `formTemplateVersionsDao.selectFormTemplatesWithRefs(...)`.
- `lib/data/form_template_list_service.dart:166-197` loads a specific/latest `FormTemplateVersion` with `fields`, `sections`, and merged options.
- `packages/drun_sdk/lib/database/tables/form_template_versions.table.dart:11-17` stores `fields`, `sections`, and `options` as converted text columns. This is the active "form JSON all at once" source.
- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:103` builds the full `FormGroup`.
- `lib/core/form/builder/form_element_control_builder.dart:51` creates repeat sections as full `FormArray` instances from the entire initial repeat list.
- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:107` builds all form element instances.
- `lib/core/form/builder/form_element_builder.dart:79` builds a `RepeatSection` with all initial repeat rows.
- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:72` routes into `FormSubmissionScreen`.

Active sync source for template JSON:

- `packages/drun_sdk/lib/datasource/remote_data_sources/form_template_datasource.dart:9-10` registers `DataFormTemplateDatasource`.
- `packages/drun_sdk/lib/datasource/remote_data_sources/form_template_datasource.dart:18-21` extracts form version rows as extra entities.
- `packages/drun_sdk/lib/datasource/remote_data_sources/form_template_datasource.dart:35-49` fetches `formTemplateVersions?paged=false` and maps them into `FormTemplateVersion`.
- `packages/drun_sdk/lib/datasource/base_datasource.dart` performs fetch, map, and batch upsert for active SDK sync resources.

## 4. Active submission-save path

Active:

- `lib/features/form_submission/presentation/form_submission_screen.widget.dart:211` calls `appLocator<FormInstance>().saveFormData()` from the save action.
- `lib/features/form_submission/application/element/form_instance.dart:85-103` is the active whole-submission save method.
- `lib/features/form_submission/application/element/form_instance.dart:87` reads the current `DataInstance`.
- `lib/features/form_submission/application/element/form_instance.dart:88` reduces `formSection.value` into a full nested map.
- `lib/features/form_submission/application/element/form_instance.dart:97-100` merges the full form value into `formSubmission.formData`.
- `lib/features/form_submission/application/element/form_instance.dart:103` writes through `_db.dataInstancesDao.updateData(...)`.
- `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart:198-207` overwrites `formData`, sets sync state to draft, and updates timestamps.
- `packages/drun_sdk/lib/database/tables/data_submissions.table.dart:39-40` stores `formData` as a nullable JSON text column through `NullAwareMapConverter`.
- `packages/drun_sdk/lib/database/converters/null_aware_map.converter.dart:6-18` converts the whole map to/from JSON.
- `lib/features/form_submission/application/element/form_instance.dart:177` marks a submission final through `dataInstancesDao.markFinal`.
- `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart:210-218` marks final by changing sync state and timestamps, not by normalizing form values.

Inactive or obsolete-looking:

- `lib/features/form_submission/application/repository/submission_capture_repository_impl.dart` is fully commented and references old DHIS/D2 style APIs.
- The fully commented Riverpod `FormInstance` provider experiment was removed; the active `FormInstance` is registered in GetIt scope by the bootstrapper.

## 5. Active repeat-rendering/editing path

Active render path:

- `lib/features/form_submission/presentation/form_entry_view_silver.widget.dart` renders root elements from `appLocator<FormInstance>()`.
- `lib/features/form_submission/presentation/section/section.widget.dart` recursively renders nested `Section`, `RepeatSection`, and `FieldInstance`.
- `lib/features/form_submission/presentation/section/repeat_table_sliver.dart` wraps a `RepeatTable` in a sliver/sticky header.
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart:17` defines active `RepeatTable`.
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart:108` uses `PaginatedDataTable`.
- `lib/features/form_submission/presentation/section/repeat_table_rows_source.dart` provides rows from in-memory `RepeatItemInstance` objects.

Active add/edit/delete path:

- `lib/features/form_submission/application/element/form_instance.dart:134-149` adds a repeated row by creating a child `FormGroup`, adding it to the parent `FormArray`, building a `RepeatItemInstance`, resolving dependencies, and evaluating the row.
- `lib/features/form_submission/application/element/form_instance.dart:153-157` removes a repeated row from both the element list and the `FormArray`.
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart:116` calls `formInstance.onAddRepeatedItem(...)`.
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart:60` calls `formInstance.onRemoveRepeatedItem(...)`.
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart:181-191` opens `EditRowScreen` via `NavigationService.navigateToView(...)`.
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart:200` saves the whole submission after a repeat row save.
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart:264` does the same from the dialog/panel path.
- `lib/features/form_submission/presentation/section/edit_row_screen.dart:17` defines the row editing screen.
- `lib/features/form_submission/presentation/section/edit_row_screen.dart:114` wraps the row controls in `ReactiveForm`.

Uncertain:

- `lib/app/stacked/app.dart:25` registers `EditRowScreen` as a Stacked route, and generated route code exists. The active repeat table call site uses `navigateToView(...)`, not the generated `navigateToEditRowScreen(...)` helper.

Important active repeat data detail:

- `lib/features/form_submission/application/element/repeat_item_instance.dart:24-32` has a row uid field, but `reduceValue()` has the `repeatUid` write commented out. The saved form JSON appears to identify repeat rows by list position, not stable row id.

## 6. State management libraries found

Active:

- Riverpod/Hooks:
  - `lib/main.dart:93` wraps the app in `ProviderScope`.
  - `lib/main.dart:101` uses `ConsumerWidget`.
  - Active providers include `preferenceProvider`, `authProvider`, `dataInstanceFilterProvider`, `totalItemsStreamProvider`, `selectedItemsProvider`, `submissionEditStatusProvider`, and form/template display providers.
  - Active screens/widgets include `HookConsumerWidget`, `StatefulHookConsumerWidget`, and `ConsumerStatefulWidget` under form and table UI.
- Stacked:
  - `lib/app/stacked/app.dart:19-29` defines Stacked routes.
  - `lib/features/startup/presentation/splash_view.dart` and `lib/features/form_submission/presentation/form_flow_bootstrapper.dart` are `StackedView`s.
  - `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:21` uses `BaseViewModel`.
  - `lib/features/sync/presentation/sync_resources_viewmodel.dart:13` uses `StreamViewModel`.
- GetIt/Stacked locator:
  - `lib/app/di/injection.dart` sets `appLocator`.
  - `lib/core/auth/auth_manager.dart:144-163` manages per-user database scope.
  - `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:60-68` manages per-submission scope.
  - Active form widgets repeatedly read `appLocator<FormInstance>()`.
- Reactive Forms:
  - `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:103` creates the root `FormGroup`.
  - `lib/core/form/builder/form_element_control_builder.dart:51` creates repeat `FormArray`s.
  - Field widgets and row edit screens use `ReactiveForm` and `ReactiveFormField`.
- RxDart/streams:
  - `lib/features/form_submission/application/element/form_element.dart:42-47` uses `BehaviorSubject` for element property changes.
  - `lib/features/form_submission/application/element/repeat_instance.dart:14-17` uses `BehaviorSubject` for repeat collection changes.

Inactive or obsolete-looking:

- The commented Riverpod form-instance/element/provider experiments were removed.
- `lib/core/form/form_state/form_state.provider.dart` remains a commented/incomplete alternate form-state approach.
- Several `StateProvider`/`StateNotifier` form-state files under `lib/features/form/application/form/form_state/` look experimental or commented.

## 7. Form-related DB tables/code paths that appear inactive or incomplete

Active:

- `data_instances`: active submission table. Evidence: `DataInstancesDao.createDraft`, `updateData`, `markFinal`, list queries, and sync upload.
- `form_templates` and `form_template_versions`: active form metadata/template source. Evidence: `DataFormTemplateDatasource`, `FormTemplateListService`, `FormTemplateRepository`.
- `data_elements`: active metadata/value display support and active sync resource. Evidence: `DataElementDatasource` is registered; display logic resolves data element metadata.
- `data_options` and `data_option_sets`: active option display and form option merging.

Inactive or incomplete-looking:

- `repeat_instances`:
  - Table and DAO exist: `packages/drun_sdk/lib/database/app_database.dart:23,50`, `packages/drun_sdk/lib/database/tables/repeat_instances.table.dart:6`.
  - App repeat rendering/editing does not use the table; repeats are stored inside `DataInstance.formData` as nested JSON lists.
  - `packages/drun_sdk/lib/datasource/remote_data_sources/repeat_instance_datasource.dart:6-8` has commented `@Order` and `@Injectable`.
  - `packages/drun_sdk/lib/datasource/remote_datasource_order_map.dart:43` comments out `repeatInstance`.
  - Classification: inactive/incomplete-looking for current capture flow.
- `data_values`:
  - Table and DAO exist: `packages/drun_sdk/lib/database/app_database.dart:24,49`, `packages/drun_sdk/lib/database/tables/data_values.table.dart:4`.
  - Active capture save does not write `data_values`; it writes `data_instances.formData`.
  - `lib/core/element_instance/data_value_repository.dart` can read/write `db.dataValues`, but current form capture does not call it.
  - `packages/drun_sdk/lib/datasource/remote_data_sources/data_value_datasource.dart:6-8` has commented `@Order` and `@Injectable`, and it is not registered in `registerUserSdkDeps`.
  - Classification: not active for capture/save; partially active for display/value mapping support through `DataValueRepository`.
- `metadata_submissions`:
  - `packages/drun_sdk/lib/database/tables/metadata_submissions.table.dart:6` is commented out.
  - `packages/drun_sdk/lib/database/tables/tables.dart` exports it, but `AppDatabase` does not include an active `MetadataSubmissions` table.
  - `lib/data/metadata_submission_update.provider.dart:13` has the old DB query commented out and currently returns `[]`.
  - `packages/drun_sdk/lib/datasource/remote_data_sources/metadata_submission_datasource.dart` is fully commented.
  - Classification: obsolete-looking/incomplete.
- `FormTemplateVersionDatasource`:
  - Present but inactive-looking because its Injectable annotations are commented and versions are loaded via `DataFormTemplateDatasource.extractExtraEntities`.

## 8. Candidate duplicated services/functions

Observations only:

- Template tree construction appears duplicated:
  - `packages/drun_sdk/lib/database/shared/form_template_model.dart:22,33` builds a tree in `FormTemplateModel`.
  - `lib/data/form_template_repository.dart:53,101` builds another tree/cache for runtime rendering.
- Form instance construction appears duplicated:
  - Active: `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:103-127`.
  - The commented old Riverpod construction path was removed.
- Template services overlap:
  - Active list/detail service: `lib/data/form_template_list_service.dart`.
  - Active DI service: `lib/features/form/application/form_template_service_impl.dart`.
  - Old/commented service: `lib/data/form_template_service.dart`.
- Submission table/query responsibilities overlap:
  - `lib/features/form_submission/application/form_instance_service_impl.dart` fetches/counts paginated submissions through `DataInstancesDao.selectable/countSubmissions`.
  - `lib/features/data_instance/data/drift_table_repository.dart` also builds table queries and counts through `DataInstancesDao.getFilterQuery`.
  - `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart` has both `selectSubmissions` and `selectable`, plus count methods.
- Submission list state overlaps:
  - `lib/features/form_submission/application/submission_list.provider.dart` manages form submissions and update/sync operations.
  - `lib/features/data_instance/application/table.providers.dart` and `table_controller.provider.dart` manage current table filters, selection, delete, and sync.
- Repeat row UI has both screen and dialog/panel paths:
  - `EditRowScreen` is active.
  - `EditRowPanel` and `showEditDialog` are still present; `showEditPanel` currently uses `EditRowScreen` inside `navigateToView`.
- Value/display mapping has multiple layers:
  - `MapValueToDisplay`, `ValueTypeValueDisplay`, `SubmissionTableCell`, `DataValueRepository`, and field-level user-friendly value helpers overlap in responsibility.

## 9. Risk map for large forms with 200-300 repeat rows

High risk:

- Full upfront form construction:
  - `FormElementControlBuilder.formDataControls` and `createRepeatFormArray` build controls for every repeat row.
  - `FormElementBuilder.buildRepeatInstance` builds `RepeatItemInstance` objects for every repeat row.
  - `Section.resolveDependencies()` and `Section.evaluate()` traverse the full tree at bootstrap.
  - Impact: startup/render latency and memory grow with repeat rows multiplied by fields per row.
- Whole-submission save:
  - `FormInstance.saveFormData()` reduces `formSection.value` for the whole tree, merges it, and writes the entire JSON column.
  - Repeat row save calls `formInstance.saveFormData()` immediately.
  - Impact: editing one row can serialize and write all 200-300 rows.
- Whole JSON column storage:
  - `data_instances.formData` is one JSON text column. Large repeat lists make SQLite writes, JSON encode/decode, sync payloads, and conflict handling larger.
- Stream/subscription pressure:
  - Each element has a `BehaviorSubject`.
  - `FieldWidget` subscribes to `control.valueChanges`; the cleanup currently returns a function that returns the subscription object, not a call to cancel it. That should be verified before changing anything.

Medium risk:

- Repeat table UI:
  - `PaginatedDataTable` displays pages, but `RepeatTableDataSource` still holds all row instances in memory.
  - Wide repeat sections render one column per immediate child field, which can create very wide tables.
- Dependency evaluation:
  - Dependency resolution walks parent sections and can fall back to walking the full tree.
  - Rule evaluation notifies dependents on value/status changes.
  - Impact depends on number of calculated/visibility/filter dependencies inside repeat rows.
- Row identity:
  - `RepeatItemInstance.uid` exists, but `repeatUid` persistence is commented out in `reduceValue()`.
  - Impact: row identity is index/list-position based unless something else preserves identity outside this path.
- Scope lifetime:
  - The active form is a GetIt scope keyed by submission id. Back/save flows drop scopes in several places.
  - Impact: multiple open form routes or unusual navigation could leave stale `FormInstance`/registry state if scope transitions are wrong.

Uncertain risk:

- Background DB connection helps database IO, but JSON map reduction and serialization appear to happen in app code before/around the DAO call. Runtime profiling is needed to confirm UI-thread cost.
- `RepeatTableDataSource.updateItems` uses a predicate that appears self-comparing. It should be inspected before relying on table refresh behavior for large repeat edits.

## 10. Do not touch until understood

Treat these as high-risk files until the active paths above are fully understood:

- `lib/main.dart`
- `lib/app/di/injection.dart`
- `lib/app/stacked/app.dart`
- `lib/app/stacked/app.router.dart` (generated; do not edit directly)
- `lib/core/auth/auth_manager.dart`
- `packages/drun_sdk/lib/di/injection.dart`
- `packages/drun_sdk/lib/di/init_active_session_scope.dart`
- `packages/drun_sdk/lib/database/app_database.dart`
- `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart`
- `packages/drun_sdk/lib/database/tables/data_submissions.table.dart`
- `packages/drun_sdk/lib/database/converters/null_aware_map.converter.dart`
- `packages/drun_sdk/lib/datasource/base_datasource.dart`
- `packages/drun_sdk/lib/datasource/remote_data_sources/form_template_datasource.dart`
- `packages/drun_sdk/lib/datasource/remote_datasource_order_map.dart`
- `lib/data/form_template_repository.dart`
- `lib/data/form_template_list_service.dart`
- `lib/core/form/builder/form_element_control_builder.dart`
- `lib/core/form/builder/form_element_builder.dart`
- `lib/features/form_submission/presentation/form_flow_bootstrapper.dart`
- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart`
- `lib/features/form_submission/presentation/form_submission_screen.widget.dart`
- `lib/features/form_submission/application/element/form_instance.dart`
- `lib/features/form_submission/application/element/form_element.dart`
- `lib/features/form_submission/application/element/section_instance.dart`
- `lib/features/form_submission/application/element/repeat_instance.dart`
- `lib/features/form_submission/application/element/repeat_item_instance.dart`
- `lib/features/form_submission/presentation/form_entry_view_silver.widget.dart`
- `lib/features/form_submission/presentation/section/section.widget.dart`
- `lib/features/form_submission/presentation/section/repeat_table_sliver.dart`
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart`
- `lib/features/form_submission/presentation/section/repeat_table_rows_source.dart`
- `lib/features/form_submission/presentation/section/edit_row_screen.dart`
- `lib/features/form_submission/presentation/field/field.widget.dart`
- `lib/features/form_submission/application/submission_list.provider.dart`
- `lib/features/data_instance/application/table.providers.dart`
- `lib/features/data_instance/application/table_controller.provider.dart`
- `lib/features/data_instance/presentation/table_screen.dart`
- `lib/features/data_instance/presentation/table_widget.dart`
- `lib/features/data_instance/data/drift_table_repository.dart`
- `lib/features/data_instance/data/table_repository.dart`

Also do not delete these until their old/partial roles are explicitly resolved:

- `lib/core/form/form_state/form_state.provider.dart`
- `lib/core/element_instance/data_value_repository.dart`
- `packages/drun_sdk/lib/database/tables/data_values.table.dart`
- `packages/drun_sdk/lib/database/tables/repeat_instances.table.dart`
- `packages/drun_sdk/lib/database/tables/metadata_submissions.table.dart`
- `packages/drun_sdk/lib/datasource/remote_data_sources/data_value_datasource.dart`
- `packages/drun_sdk/lib/datasource/remote_data_sources/repeat_instance_datasource.dart`
- `packages/drun_sdk/lib/datasource/remote_data_sources/metadata_submission_datasource.dart`

## Suggested next investigation step

Run a focused runtime trace on one real example form with a large repeat section:

1. Seed or load a submission with 200-300 repeat rows from `example/`.
2. Instrument only timings and sizes around:
   - `FormFlowBootstrapperVm.bootstrapFlow`
   - `FormElementControlBuilder.formDataControls`
   - `FormElementBuilder.buildFormElements`
   - `Section.resolveDependencies`
   - `Section.evaluate`
   - `FormInstance.saveFormData`
   - `DataInstancesDao.updateData`
3. Record:
   - build time
   - row edit save time
   - JSON payload size
   - widget rebuild count if possible
   - memory before/after opening and closing the form

Do this before refactoring or introducing normalized repeat/data-value storage.
