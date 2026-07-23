# Production Code Path Map

Generated: 2026-07-10
Reconciled: 2026-07-24 against production `v6.0.0+50`

Scope: map active production paths before refactoring. This treats docs, names, comments, and stale-looking code as evidence only. Classifications below are based on live imports, route registration, DI registration, and call sites found in this scan.

Use the strict comment-out classification in `05-classification-reconciliation.md`. A reached support helper or registered resource is not automatically `ACTIVE-CORE`.

## 1. Main app entrypoints

`ACTIVE-CORE` entry/navigation path, except where qualified:

- `android/app/src/main/kotlin/org/datarun/app/MainActivity.kt` is the Android native shell entrypoint and extends `FlutterActivity`.
- `lib/main.dart` defines `main()`.
- `ACTIVE-SUPPORT`: `lib/main.dart` wraps startup in `SentryFlutter.init`; removing telemetry alone would not disable core data collection.
- `lib/main.dart` calls `configureDependencies()`.
- `lib/main.dart` runs the app inside `ProviderScope`.
- `lib/main.dart` defines `App extends ConsumerWidget`.
- `lib/main.dart` uses `StackedRouter().onGenerateRoute`.
- `lib/main.dart` sets `Routes.splashView` as the initial route.
- `lib/app/stacked/app.dart` registers current Stacked routes: `HomeWrapperPage`, `LoginView`, `SplashView`, `SettingsView`, `SyncResourcesView`, `FormSubmissionScreen`, `FormFlowBootstrapper`, and `TableScreen`. Repeat row editing is opened directly from the active table and is not a generated route.
- `lib/features/startup/application/startup_coordinator.dart` routes authenticated users to sync or home, and unauthenticated users to login.
- `lib/features/home/presentation/home_wrapper_page.dart` shows `ActivityListView` as the home body.
- `lib/features/activity/presentation/activity_list_view.dart` opens `AssignmentScreen` from an activity card through a direct Flutter `MaterialPageRoute`; it is active but not in the generated Stacked route list.

Obsolete-looking or inactive:

- The older `lib/app/app_routes/*` experiment was removed after confirming it had no active importer. Current `MaterialApp` uses the Stacked router in `lib/main.dart`.
- `lib/app/stacked/app.router.dart` is active generated route code, but should not be edited manually.

## 2. Former SDK entrypoints and current app consumption

Active:

- `pubspec.yaml` now declares the database, datasource, and utility dependencies directly; there is no local `d_sdk` package dependency.
- `lib/app/di/injection.dart` configures app dependencies, then calls `registerDatabaseDependencies(appLocator)`.
- `lib/di/injection.dart` owns the single application locator and explicitly registers the root `DatabaseFactory` dependency.
- `lib/core/auth/auth_manager.dart` creates the per-user app scope, opens the Drift database, registers `AppDatabase` as the single user-database owner, then calls `registerUserConfigurationDatasources(appLocator)`.
- `lib/di/init_active_session_scope.dart` registers the runtime configuration datasource list for the user session, from projects through assignments. Submission pull is excluded; registration alone does not prove every stored table has a core reader.
- The zero-behavior `DSdk` and `DbManager` facades were removed. Active consumers resolve the scoped `AppDatabase` directly.
- `lib/database/db_factory/database_factory.dart` and `lib/database/db_factory/platform_app.dart` open per-user Drift database files.

The former generated SDK root/session registration alternative was removed after
registration checks. Obsolete form/sync/query utilities and unregistered datasources were removed
after import, DI, sync-registration, and test closure checks. Form
versions continue through `DataFormTemplateDatasource`.

## 3. Active form-loading path

Active high-level path:

1. A user opens or creates a local submission from a table or assignment detail.
2. Navigation goes to `FormFlowBootstrapper`.
3. The bootstrapper creates or loads a `DataInstance`.
4. It loads the exact form template/version JSON from local Drift tables.
5. It builds the root control graph and the full `FormElementInstance` tree. Stored repeat rows receive lightweight map controls; their field controls are materialized only while edited.
6. It registers `FormTemplateRepository` and `FormInstance` in a GetIt scope named by submission id.
7. It replaces the route with `FormSubmissionScreen`.

Active evidence:

- `lib/features/data_instance/presentation/table_screen.dart` creates a new submission by navigating to `FormFlowBootstrapper`.
- `lib/features/data_instance/presentation/table_widget.dart` edits an existing item by navigating to `FormFlowBootstrapper` with `submissionId`, `formId`, `versionId`, and `assignmentId`.
- `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` creates a draft via `_db.dataInstancesDao.createDraft(...)` when `submissionId == null`.
- `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` pushes a GetIt scope for the submission and registers `FormTemplateRepository` plus `FormInstance`.
- `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` loads template data through `FormTemplateRepository.create(versionUid: dataInstance.templateVersion)`.
- `lib/data/form_template_repository.dart` loads `FormTemplateModel`, options, and option sets.
- `lib/data/form_template_list_service.dart` fetches form templates through `formTemplateVersionsDao.selectFormTemplatesWithRefs(...)`.
- `lib/data/form_template_list_service.dart` loads a specific/latest `FormTemplateVersion` with `fields`, `sections`, and merged options.
- `lib/database/tables/form_template_versions.table.dart` stores `fields`, `sections`, and `options` as converted text columns. This is the active "form JSON all at once" source.
- `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` builds the root `FormGroup`.
- `lib/core/form/builder/form_element_control_builder.dart` creates repeat sections as `FormArray` instances with one map control per stored row, not an eager field-control subtree per row.
- `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` builds all form element instances.
- `lib/core/form/builder/form_element_builder.dart` builds a `RepeatSection` with all initial repeat rows.
- `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` routes into `FormSubmissionScreen`.

Active sync source for template JSON:

- `lib/datasource/remote_data_sources/form_template_datasource.dart` registers `DataFormTemplateDatasource`.
- `lib/datasource/remote_data_sources/form_template_datasource.dart` extracts form version rows as extra entities.
- `lib/datasource/remote_data_sources/form_template_datasource.dart` fetches `formTemplateVersions?paged=false` and maps them into `FormTemplateVersion`.
- `lib/datasource/base_datasource.dart` performs fetch, map, and batch upsert for registered configuration resources.

## 4. Active submission-save path

Active:

- `lib/features/form_submission/presentation/form_submission_screen.widget.dart` calls `appLocator<FormInstance>().saveFormData()` from the save action.
- `lib/features/form_submission/application/element/form_instance.dart` is the active whole-submission save method.
- `lib/features/form_submission/application/element/form_instance.dart` reads the current `DataInstance`.
- `lib/features/form_submission/application/element/form_instance.dart` reduces `formSection.value` into a full nested map.
- `lib/features/form_submission/application/element/form_instance.dart` merges the full form value into `formSubmission.formData`.
- `lib/features/form_submission/application/element/form_instance.dart` writes through `_db.dataInstancesDao.updateData(...)`.
- `lib/database/dao/data_submissions_dao.dart` overwrites `formData`, sets sync state to draft, and updates timestamps.
- `lib/database/tables/data_submissions.table.dart` stores `formData` as a nullable JSON text column through `NullAwareMapConverter`.
- `lib/database/converters/null_aware_map.converter.dart` converts the whole map to/from JSON.
- `lib/features/form_submission/application/element/form_instance.dart` marks a submission final through `dataInstancesDao.markFinal`.
- `lib/database/dao/data_submissions_dao.dart` marks final by changing sync state and timestamps, not by normalizing form values.

Inactive or obsolete-looking:

- The fully commented per-field `submission_capture_repository` path was removed. Active capture remains whole-form JSON through `FormInstance` and `DataInstancesDao`.
- The fully commented Riverpod `FormInstance` provider experiment was removed; the active `FormInstance` is registered in GetIt scope by the bootstrapper.

## 5. Active repeat-rendering/editing path

Active render path:

- `lib/features/form_submission/presentation/form_entry_view_silver.widget.dart` renders root elements from `appLocator<FormInstance>()`.
- `lib/features/form_submission/presentation/section/section.widget.dart` recursively renders nested `Section`, `RepeatSection`, and `FieldInstance`.
- `lib/features/form_submission/presentation/section/repeat_table_sliver.dart` wraps a `RepeatTable` in a sliver/sticky header.
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart` defines active `RepeatTable`.
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart` uses `PaginatedDataTable`.
- `lib/features/form_submission/presentation/section/repeat_table_rows_source.dart` provides rows from in-memory `RepeatItemInstance` objects.

Active add/edit/delete path:

- `lib/features/form_submission/application/element/form_instance.dart` adds a lightweight repeat row, materializes its field controls while edited, and removes/restores exact rows in both the element list and `FormArray`.
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart` opens `EditRowScreen` on a context-owned `MaterialPageRoute`, waits for that route to finish leaving the overlay, owns persistence callbacks, and applies the typed save/discard result.
- `lib/features/form_submission/application/repeat_row_edit_session.dart` owns the opening snapshot and pristine/changed/new/valid decision state.
- `lib/features/form_submission/presentation/section/edit_row_screen.dart` renders the row `ReactiveForm` and returns a `RepeatRowEditResult`; it does not own persistence or row restoration.

The active repeat table constructs `EditRowScreen` on a local `MaterialPageRoute`. The uncalled generated `navigateToEditRowScreen(...)` route registration was removed on 2026-07-23, leaving one row-editor entry path independent of Stacked/Get navigation.

Important active repeat data detail:

- `lib/features/form_submission/application/element/repeat_item_instance.dart` preserves or creates a row `_id` during reduction, and `FormInstance.saveFormData()` normalizes `_id`, `_index`, `_parentId`, and `_submissionUid` before whole-JSON persistence. Upload repeats the normalization as a compatibility guard.

## 6. State management libraries found

Active:

- Riverpod/Hooks:
  - `lib/main.dart` wraps the app in `ProviderScope` and uses `ConsumerWidget`.
  - Active providers own app preferences, activity/assignment projection, form availability, submission edit access, submission-table filters/selection/commands, and supporting display state.
  - Active screens/widgets use hooks and Riverpod for presentation state; field values and validity are not stored in Riverpod.
- Stacked:
  - `lib/app/stacked/app.dart` defines Stacked routes.
  - The generated Stacked router and navigation/dialog services remain active.
  - No hand-written active screen now extends `StackedView` or a Stacked viewmodel; routed widgets remain registered through the generated router.
- Configuration sync presentation:
  - `lib/features/sync/application/sync_resources.controller.dart` subscribes to `SyncManager.progressStream`, projects per-resource/global status through an auto-dispose Riverpod notifier, records completion metadata, and navigates home.
- GetIt/Stacked locator:
  - `lib/app/di/injection.dart` sets `appLocator`.
  - `lib/core/auth/auth_manager.dart` manages per-user database scope.
  - `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` manages per-submission scope.
  - Active form widgets repeatedly read `appLocator<FormInstance>()`.
- Reactive Forms:
  - `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` creates the root `FormGroup`.
  - `lib/core/form/builder/form_element_control_builder.dart` creates repeat `FormArray`s.
  - Field widgets and row edit screens use `ReactiveForm` and `ReactiveFormField`.
- RxDart/streams:
  - `lib/features/form_submission/application/element/form_element.dart` uses `BehaviorSubject` for element property changes.
  - `lib/features/form_submission/application/element/repeat_section.dart` uses `BehaviorSubject` for repeat collection changes.

Inactive or obsolete-looking:

- The commented Riverpod form-instance/element/provider experiments were removed.
- The remaining unused core `FormState`/provider/repository model was removed with its isolated element-state tree.
- The entirely commented `lib/features/form/application/form/form_state/` experiment was removed; active form state remains under `features/form_submission`.

## 7. Form-related DB tables/code paths that appear inactive or incomplete

Active:

- `data_instances`: active submission table. Evidence: `DataInstancesDao.createDraft`, `updateData`, `markFinal`, list queries, and sync upload.
- `form_templates` and `form_template_versions`: active form metadata/template source. Evidence: `DataFormTemplateDatasource`, `FormTemplateListService`, `FormTemplateRepository`.
- `data_options` and `data_option_sets`: active option display and form option merging.

Inactive or incomplete-looking:

- `data_elements`: obsolete and removed in schema 6 after its write-only datasource was removed. Form rendering parses field metadata from cached template JSON; no runtime table read was found outside generated Drift code.
- `repeat_instances` and `data_values`: obsolete normalized persistence tables, DAOs, datasources, and callers were removed. Schema migration 5 drops populated legacy tables while preserving active `data_instances.formData`; schema 3 and 4 upgrade fixtures cover the transition.
- `metadata_submissions` table/datasource artifacts were removed. `lib/data/metadata_submission_update.provider.dart` remains reachable from reference-field UI but returns `[]`; classify that UI/data path as incomplete until a production form proves the field type is used.
- The alternate `FormTemplateVersionDatasource` was removed. Versions are loaded through `DataFormTemplateDatasource.extractExtraEntities`.

## 8. Candidate duplicated services/functions

Closed observations:

- Template tree construction now has one canonical `FormTemplateModel.elementTree` reused by `FormTemplateRepository`.
- Form instance construction now has one active owner in `FormFlowBootstrapperController`.
- Generated-only/obsolete form-list and template services were removed; `FormTemplateListService` remains the active cached template/version lookup.
- Submission table behavior now has one active owner: user-scoped `SubmissionTableService` fetches/counts paginated rows, resolves selected/syncable rows, deletes selected rows through `DataInstancesDao`, and delegates upload to `SubmissionUploadService`. The misleading `FormInstanceService` and duplicate `TableRepository`/`DriftTableRepository` abstractions were removed without changing DAO or upload behavior.
- `submissionEditStatusProvider` has the narrow form-edit-access responsibility; table filters, selection, delete, and sync commands are owned by the scoped `TableController`. These are no longer competing submission-list stores.
- Repeat row editing uses `EditRowScreen`; the unreachable dialog/panel path was removed.
- Value/display mapping has multiple layers:
  - `MapValueToDisplay`, `ValueTypeValueDisplay`, `SubmissionTableCell`, `DisplayValueLookup`, and field-level user-friendly value helpers overlap in responsibility.

## 9. Risk map for large forms with 200-300 repeat rows

High risk:

- Full upfront form construction:
  - `FormElementControlBuilder.formDataControls` retains one map control per dormant repeat row; only an open editor owns that row's field controls.
  - `FormElementBuilder.buildRepeatSection` builds `RepeatItemInstance` objects for every repeat row.
  - `Section.resolveDependencies()` and `Section.evaluate()` traverse the full tree at bootstrap.
  - Impact: element/dependency memory and evaluation still grow with repeat rows multiplied by fields, while the previously multiplicative field-control/stream retention is closed.
- Whole-submission save:
  - `FormInstance.saveFormData()` reduces `formSection.value` for the whole tree, merges it, and writes the entire JSON column.
  - A top-level repeat-row save checkpoints the whole form; nested row editors defer persistence to their enclosing row session.
  - Impact: editing one row can serialize and write all 200-300 rows.
- Whole JSON column storage:
  - `data_instances.formData` is one JSON text column. Large repeat lists make SQLite writes, JSON encode/decode, sync payloads, and conflict handling larger.
- Stream/subscription pressure:
  - Each element has a `BehaviorSubject`.
  - `FieldWidget` subscriptions explicitly cancel on disposal; listener leakage is not the current static concern. Mounted listener/rebuild volume and eager element streams still scale with active form complexity.

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
  - The active form is a GetIt scope keyed by submission id, and route disposal is the single tested closure owner.
  - Impact: future navigation changes must preserve route-owned scope disposal and bootstrap replacement of an existing same-submission scope.

Uncertain risk:

- Background DB connection helps database IO, but JSON map reduction and serialization appear to happen in app code before/around the DAO call. Runtime profiling is needed to confirm UI-thread cost.
- `FormInstance.saveFormData()` has no shared form-level in-flight serialization owner; active UI callers await it, but overlapping independent callers and process death during a write remain uncharacterized.

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
- `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart`
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
- `lib/features/data_instance/application/submission_table_service.dart`
- `lib/features/data_instance/presentation/table_screen.dart`
- `lib/features/data_instance/presentation/table_widget.dart`

Also do not delete `lib/core/element_instance/display_value_lookup.dart` until its active display-only consumers are understood.

## Current Follow-Up

The broad entrypoint map is reconciled. Use `06-large-repeat-hang-data-loss.md` for current repeat measurements and the next evidence-driven performance slice, and `09-production-boundaries-and-work-strategy.md` for the ordered repository roadmap.
