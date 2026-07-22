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

## 2. Former SDK entrypoints and current app consumption

Active:

- `pubspec.yaml` now declares the database, datasource, and utility dependencies directly; there is no local `d_sdk` package dependency.
- `lib/app/di/injection.dart` configures app dependencies, then calls `registerDatabaseDependencies(appLocator)`.
- `lib/di/injection.dart` owns the single application locator and explicitly registers the root `DatabaseFactory` dependency.
- `lib/core/auth/auth_manager.dart` creates the per-user app scope, opens the Drift database, registers `AppDatabase` as the single user-database owner, then calls `registerUserConfigurationDatasources(appLocator)`.
- `lib/di/init_active_session_scope.dart` registers active configuration data sources for the user session, from projects through assignments. Submission pull is excluded.
- The zero-behavior `DSdk` and `DbManager` facades were removed. Active consumers resolve the scoped `AppDatabase` directly.
- `lib/database/db_factory/database_factory.dart` and `lib/database/db_factory/platform_app.dart` open per-user Drift database files.

The former generated SDK root/session registration alternative was removed after
registration checks. Obsolete form/sync/query utilities and unregistered datasources were removed
after import, DI, sync-registration, and test closure checks. Form
versions continue through `DataFormTemplateDatasource`.

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
- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:47` creates a draft via `_db.dataInstancesDao.createDraft(...)` when `submissionId == null`.
- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:60-68` pushes a GetIt scope for the submission and registers `FormTemplateRepository` plus `FormInstance`.
- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:65` loads template data through `FormTemplateRepository.create(versionUid: dataInstance.templateVersion)`.
- `lib/data/form_template_repository.dart:21-27` loads `FormTemplateModel`, options, and option sets.
- `lib/data/form_template_list_service.dart:154` fetches form templates through `formTemplateVersionsDao.selectFormTemplatesWithRefs(...)`.
- `lib/data/form_template_list_service.dart:166-197` loads a specific/latest `FormTemplateVersion` with `fields`, `sections`, and merged options.
- `lib/database/tables/form_template_versions.table.dart:11-17` stores `fields`, `sections`, and `options` as converted text columns. This is the active "form JSON all at once" source.
- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:103` builds the full `FormGroup`.
- `lib/core/form/builder/form_element_control_builder.dart:51` creates repeat sections as full `FormArray` instances from the entire initial repeat list.
- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:107` builds all form element instances.
- `lib/core/form/builder/form_element_builder.dart:79` builds a `RepeatSection` with all initial repeat rows.
- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:72` routes into `FormSubmissionScreen`.

Active sync source for template JSON:

- `lib/datasource/remote_data_sources/form_template_datasource.dart:9-10` registers `DataFormTemplateDatasource`.
- `lib/datasource/remote_data_sources/form_template_datasource.dart:18-21` extracts form version rows as extra entities.
- `lib/datasource/remote_data_sources/form_template_datasource.dart:35-49` fetches `formTemplateVersions?paged=false` and maps them into `FormTemplateVersion`.
- `lib/datasource/base_datasource.dart` performs fetch, map, and batch upsert for active SDK sync resources.

## 4. Active submission-save path

Active:

- `lib/features/form_submission/presentation/form_submission_screen.widget.dart:211` calls `appLocator<FormInstance>().saveFormData()` from the save action.
- `lib/features/form_submission/application/element/form_instance.dart:85-103` is the active whole-submission save method.
- `lib/features/form_submission/application/element/form_instance.dart:87` reads the current `DataInstance`.
- `lib/features/form_submission/application/element/form_instance.dart:88` reduces `formSection.value` into a full nested map.
- `lib/features/form_submission/application/element/form_instance.dart:97-100` merges the full form value into `formSubmission.formData`.
- `lib/features/form_submission/application/element/form_instance.dart:103` writes through `_db.dataInstancesDao.updateData(...)`.
- `lib/database/dao/data_submissions_dao.dart:198-207` overwrites `formData`, sets sync state to draft, and updates timestamps.
- `lib/database/tables/data_submissions.table.dart:39-40` stores `formData` as a nullable JSON text column through `NullAwareMapConverter`.
- `lib/database/converters/null_aware_map.converter.dart:6-18` converts the whole map to/from JSON.
- `lib/features/form_submission/application/element/form_instance.dart:177` marks a submission final through `dataInstancesDao.markFinal`.
- `lib/database/dao/data_submissions_dao.dart:210-218` marks final by changing sync state and timestamps, not by normalizing form values.

Inactive or obsolete-looking:

- The fully commented per-field `submission_capture_repository` path was removed. Active capture remains whole-form JSON through `FormInstance` and `DataInstancesDao`.
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

- `lib/features/form_submission/application/element/repeat_item_instance.dart` preserves or creates a row `_id` during reduction, and `FormInstance.saveFormData()` normalizes `_id`, `_index`, `_parentId`, and `_submissionUid` before whole-JSON persistence. Upload repeats the normalization as a compatibility guard.

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
  - `lib/features/form_submission/application/element/repeat_section.dart:14-17` uses `BehaviorSubject` for repeat collection changes.

Inactive or obsolete-looking:

- The commented Riverpod form-instance/element/provider experiments were removed.
- The remaining unused core `FormState`/provider/repository model was removed with its isolated element-state tree.
- The entirely commented `lib/features/form/application/form/form_state/` experiment was removed; active form state remains under `features/form_submission`.

## 7. Form-related DB tables/code paths that appear inactive or incomplete

Active:

- `data_instances`: active submission table. Evidence: `DataInstancesDao.createDraft`, `updateData`, `markFinal`, list queries, and sync upload.
- `form_templates` and `form_template_versions`: active form metadata/template source. Evidence: `DataFormTemplateDatasource`, `FormTemplateListService`, `FormTemplateRepository`.
- `data_elements`: active metadata/value display support and active sync resource. Evidence: `DataElementDatasource` is registered; display logic resolves data element metadata.
- `data_options` and `data_option_sets`: active option display and form option merging.

Inactive or incomplete-looking:

- `repeat_instances` and `data_values`: obsolete normalized persistence tables, DAOs, datasources, and callers were removed. Schema migration 5 drops populated legacy tables while preserving active `data_instances.formData`; schema 3 and 4 upgrade fixtures cover the transition.
- `metadata_submissions` table/datasource artifacts were removed. `lib/data/metadata_submission_update.provider.dart` remains reachable from reference-field UI but returns `[]`; classify that UI/data path as incomplete until a production form proves the field type is used.
- The alternate `FormTemplateVersionDatasource` was removed. Versions are loaded through `DataFormTemplateDatasource.extractExtraEntities`.

## 8. Candidate duplicated services/functions

Observations only:

- Template tree construction appears duplicated:
  - `lib/database/shared/form_template_model.dart:22,33` builds a tree in `FormTemplateModel`.
  - `lib/data/form_template_repository.dart:53,101` builds another tree/cache for runtime rendering.
- Form instance construction appears duplicated:
  - Active: `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:103-127`.
  - The commented old Riverpod construction path was removed.
- Template services overlap:
  - Active list/detail service: `lib/data/form_template_list_service.dart`.
  - Active DI service: `lib/features/form/application/form_template_service_impl.dart`.
  - Old/commented service: `lib/data/form_template_service.dart`.
- Submission table reads now have one active path: `FormInstanceServiceImpl` fetches/counts paginated submissions through `DataInstancesDao.selectable/countSubmissions`. The uncalled alternate repository query API, generic filter framework, and duplicate `selectSubmissions/getFilterQuery` DAO path were removed. `DriftTableRepository` retains only selected-row delete/upload operations.
- Submission list state overlaps:
  - `lib/features/form_submission/application/submission_list.provider.dart` manages form submissions and update/sync operations.
  - `lib/features/data_instance/application/table.providers.dart` and `table_controller.provider.dart` manage current table filters, selection, delete, and sync.
- Repeat row editing uses `EditRowScreen`; the unreachable dialog/panel path was removed.
- Value/display mapping has multiple layers:
  - `MapValueToDisplay`, `ValueTypeValueDisplay`, `SubmissionTableCell`, `DisplayValueLookup`, and field-level user-friendly value helpers overlap in responsibility.

## 9. Risk map for large forms with 200-300 repeat rows

High risk:

- Full upfront form construction:
  - `FormElementControlBuilder.formDataControls` and `createRepeatFormArray` build controls for every repeat row.
  - `FormElementBuilder.buildRepeatSection` builds `RepeatItemInstance` objects for every repeat row.
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
  - `RepeatItemInstance.reduceValue()` persists `_id`, and whole-form normalization supplies the remaining backend metadata while preserving existing IDs.
  - Impact: future synced-edit enablement must prove IDs survive server round trips and that only newly created rows receive new IDs.
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
- `lib/di/injection.dart`
- `lib/di/init_active_session_scope.dart`
- `lib/database/app_database.dart`
- `lib/database/dao/data_submissions_dao.dart`
- `lib/database/tables/data_submissions.table.dart`
- `lib/database/converters/null_aware_map.converter.dart`
- `lib/datasource/base_datasource.dart`
- `lib/datasource/remote_data_sources/form_template_datasource.dart`
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
- `lib/features/form_submission/application/element/repeat_section.dart`
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

Also do not delete `lib/core/element_instance/display_value_lookup.dart` until its active display-only consumers are understood.

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
