# Form Flow Code Map

Generated: 2026-07-10

Scope: evidence-based map for form JSON loading, form rendering, repeats, expression evaluation touching repeats, submission save/edit, repeat UID behavior, and local persistence before sync. This complements `01-production-code-path-map.md`; it intentionally does not remap the whole app entrypoint and SDK entrypoint surface.

Read mode: production source was scanned only. This document is the only new output.

Update 2026-07-21: rows that discuss `repeatUid` reflect the earlier mobile-only scan. Backend validation later proved the active server contract is repeat metadata with `_id`, `_index`, `_parentId`, and `_submissionUid`; see `07-repeat-uid-contract.md`.

Status legend:

- ACTIVE: used by reachable production runtime flow.
- INACTIVE: not referenced by active runtime flow found in this scan.
- INCOMPLETE: looks like unfinished feature work.
- LEGACY-RISK: old code that might still be called indirectly or reused accidentally.
- UNKNOWN: cannot prove either way from static references.

## Active Form Flow

| Area | Classification | File path | Evidence | Confidence | Why it matters for large repeats or repeat UIDs |
| --- | --- | --- | --- | --- | --- |
| Form route registration | ACTIVE | `lib/app/stacked/app.dart` | `MaterialRoute(page: EditRowScreen)`, `FormSubmissionScreen`, and `FormFlowBootstrapper` are registered at lines 25-27. Generated navigation exists in `lib/app/stacked/app.router.dart:103-111`, `599-667`, and `823-863`. | High | Repeat editing is route-backed. Any repeat edit performance issue can involve route creation, modal navigation, and generated Stacked route behavior. |
| Create/edit navigation from table | ACTIVE | `lib/features/data_instance/presentation/table_screen.dart` | New submission action calls `navigateToFormFlowBootstrapper` at line 93. | High | This is the active create path into form loading. Large repeat defaults would be loaded from this path if a draft already has form data. |
| Edit navigation from table rows | ACTIVE | `lib/features/data_instance/presentation/table_widget.dart` | Existing row edit calls `navigateToFormFlowBootstrapper` with `submissionId`, `formId`, `versionId`, and `assignmentId` at line 62. | High | This is a direct server/draft edit path into repeat rendering. It determines whether existing `formData` rows get rebuilt. |
| Assignment detail create path | ACTIVE | `lib/features/assignment_detail/presentation/assignment_detail_page.dart` | Calls `navigateToFormFlowBootstrapper` at line 140. | High | Confirms active production flow can create submissions without going through only the data instance table screen. |
| Bootstrapper view | ACTIVE | `lib/features/form_submission/presentation/form_flow_bootstrapper.dart` | The routed stateful loading view invokes `FormFlowBootstrapperController.bootstrapFlow(submissionId)` after its first frame and displays bootstrap errors. | High | The bootstrapper is the hard boundary where the form instance scope is created. |
| Draft/load bootstrap logic | ACTIVE | `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` | `createDraft` is called for new submissions; existing submissions are loaded through `dataInstancesDao.getById(submissionId)`. | High | Existing server-submitted records and local drafts converge here before the full form tree is built. |
| Per-submission DI scope | ACTIVE | `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` | Pushes a GetIt scope named by `dataInstance.id` and registers `FormTemplateRepository`/`FormInstance`. | High | Repeat state is held in a scoped in-memory `FormInstance`; stale scopes or scope lifetime bugs can affect edit/save behavior. |
| Template JSON load | ACTIVE | `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` | Calls `FormTemplateRepository.create(versionUid: dataInstance.templateVersion)`. | High | The active flow loads one template version as a whole before rendering; no lazy section/repeat load was found. |
| Form controls build | ACTIVE | `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` | Creates the full `FormGroup` from `FormElementControlBuilder.formDataControls(...)`. | High | For 200-300 repeat rows, all repeat row controls are allocated up front. |
| Form element tree build | ACTIVE | `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` | Calls `FormElementBuilder.buildFormElements(...)`, wraps it in a root `Section`, then calls `resolveDependencies()` and `evaluate(emitEvent: false)` before navigation. | High | Repeat trees, dependencies, and initial rule evaluation are all eager. |
| Form template repository | ACTIVE | `lib/data/form_template_repository.dart` | `create` loads template, options, and option sets at lines 18-27; `rootSection` builds a tree from template fields and sections. | High | Template flattening/tree construction is central to repeat path names and dependency lookup. |
| Template local query service | ACTIVE | `lib/data/form_template_list_service.dart` | `fetchByFilter` uses `formTemplateVersionsDao.selectFormTemplatesWithRefs(...)` at line 154; `getTemplateByVersionOrLatest` loads version data at lines 166-197. | High | This is the active local cache layer for form JSON before rendering. |
| Template storage table | ACTIVE | `lib/database/tables/form_template_versions.table.dart` | Stores `fields`, `sections`, and `options` as text columns with converters. | High | Confirms active form definition is stored as JSON-like blobs, not normalized per field table reads at render time. |
| Template sync datasource | ACTIVE | `lib/datasource/remote_data_sources/form_template_datasource.dart` | Injectable active datasource at lines 9-10; extracts `formTemplateVersions` at lines 18 and 35-49. | High | This is the sync path that populates the local template version JSON used by forms. |
| Form screen | ACTIVE | `lib/features/form_submission/presentation/form_submission_screen.widget.dart` | `FormSubmissionScreen` is active at line 23; watches `submissionEditStatusProvider` at lines 48-49; uses `FormInstanceEntryViewSliver` at line 114; save calls `appLocator<FormInstance>().saveFormData()` at line 211; final submit calls `markSubmissionAsFinal()` at line 275. | High | This is the main rendering/save host. It mixes Riverpod edit status with GetIt-held form instance state. |
| Root rendering sliver | ACTIVE | `lib/features/form_submission/presentation/form_entry_view_silver.widget.dart` | Reads `appLocator<FormInstance>()` and maps root elements to `SectionWidget`, `RepeatTableSliver`, or `FieldWidget` at lines 11-41. | High | Rendering starts by iterating all root elements. Repeats are rendered as tables, not virtualized row forms. |
| Section rendering | ACTIVE | `lib/features/form_submission/presentation/section/section.widget.dart` | Watches `element.propertiesChanged`; recursively renders `SectionWidget`, `RepeatTableSliver`, and `FieldWidget` at lines 13-85. | High | Hidden/visible rules and repeat nesting trigger rebuilds through `propertiesChanged`. |
| Field rendering | ACTIVE | `lib/features/form_submission/presentation/field/field.widget.dart` | `FieldWidget` subscribes to control value changes and renders `FieldFactory.fromType(element)`. Its hook cleanup returns `subscription.cancel`. | High | Every field inside every open repeat-row editor attaches value-change behavior; cancellation is explicit, but lifecycle churn remains relevant to performance. |
| Field widget factory | ACTIVE | `lib/features/form_submission/application/form_widget_factory.dart` | `FieldFactory` is called by `FieldWidget`; maps field `ValueType` to concrete reactive widgets. | High | Large repeat row cost depends on the number and type of fields created per row. |
| Repeat controls build | ACTIVE | `lib/core/form/builder/form_element_control_builder.dart` | Repeatable sections create a `FormArray<Map<String,Object?>>`; existing initial rows map through `createSectionFormGroup(...)` at lines 51-58. | High | All initial repeat rows become controls up front. This is a primary performance and memory pressure point. |
| Repeat element tree build | ACTIVE | `lib/core/form/builder/form_element_builder.dart` | `buildRepeatSection` maps every initial list row into a `RepeatItemInstance`; `buildRepeatItem` reads the row ID through `RepeatMetadataNormalizer`. | High | Client/server repeat identity depends on preserving the metadata read here. |
| Repeat section model | ACTIVE | `lib/features/form_submission/application/element/repeat_section.dart` | `RepeatSection` owns `BehaviorSubject<List<RepeatItemInstance>>`, `addAll`, `reduceValue`, `resolveDependencies`, and `evaluate`. | High | Repeat collection changes and rule evaluation are centralized here. Large repeats may emit and evaluate many rows. |
| Repeat row model | ACTIVE | `lib/features/form_submission/application/element/repeat_item_instance.dart` | Reads an existing row ID, prevents changing a non-null ID, generates a ULID when missing, and writes `_id` in `reduceValue()`. | High | Stable repeat identity is now part of the active reduced JSON rather than a UI-only `repeatUid` marker. |
| Add/remove repeat rows | ACTIVE | `lib/features/form_submission/application/element/form_instance.dart` | `onAddRepeatedItem` creates a new row control/tree and evaluates it; `onRemoveRepeatedItem` removes from model and `FormArray`. | High | Collection position still drives rendering and `_index`, while `_id` supplies stable identity across saves. |
| Repeat table sliver | ACTIVE | `lib/features/form_submission/presentation/section/repeat_table_sliver.dart` | Wraps `RepeatTable` and watches repeat properties. | High | This is the active repeat rendering bridge. |
| Repeat table | ACTIVE | `lib/features/form_submission/presentation/section/repeat_table.widget.dart` | Initializes `RepeatTableDataSource` at line 69; renders `PaginatedDataTable` at line 108; add calls `onAddRepeatedItem` at line 116; row edit opens `_showEditPanel`; save calls `formInstance.saveFormData()` at line 200. | High | Repeats are displayed through `PaginatedDataTable`, but the data source still holds all rows. Add/save inside row edit writes the whole form JSON. |
| Repeat row edit screen | ACTIVE | `lib/features/form_submission/presentation/section/edit_row_screen.dart` | Active routed widget; wraps the row `ReactiveForm` and assigns `CodeGenerator.generateUlid()` only when a row has no ID. | High | Existing row IDs are preserved; newly created rows receive a backend-compatible ULID before reduction. |
| Repeat table data source | ACTIVE | `lib/features/form_submission/presentation/section/repeat_table_rows_source.dart` | Extends `DataTableSource` at line 15; `updateItems` at line 38; `getRow` at line 62 iterates fields for a repeat row. | High | For large repeats, row rendering scans row fields. `updateItems` appears suspicious because its predicate compares `item.elementPath == item.elementPath`; runtime behavior should be verified before changing performance. |
| Form instance save | ACTIVE | `lib/features/form_submission/application/element/form_instance.dart` | `saveFormData` at line 85 reads existing submission, computes `formSection.value`, preserves metadata keys, and calls `_db.dataInstancesDao.updateData(...)`. | High | Every save writes one whole `formData` map. Repeat changes are not saved as separate row/value records. |
| Mark final | ACTIVE | `lib/features/form_submission/application/element/form_instance.dart` | `markSubmissionAsFinal` delegates to DAO at line 176. | High | Finalization changes sync eligibility after whole JSON save. |
| Submission edit status | ACTIVE | `lib/features/form_submission/application/submission_edit_access.dart`, `submission_list.provider.dart` | `submissionEditStatusProvider` and form bootstrap both delegate to the same `canEditSubmission(...)` query. Focused tests cover local submissions and synced submissions with and without server edit permission. | High for local rule, medium for final product policy | Determines whether synced server submissions can be edited again without allowing bootstrap and screen state to diverge. |
| Data instance table | ACTIVE | `lib/database/tables/data_submissions.table.dart` | `formData` is a single nullable text column mapped through `NullAwareMapConverter` at lines 39-40; `syncState` and `isToUpdate` are also stored. | High | Confirms active submission persistence is whole JSON per submission. |
| JSON map converter | ACTIVE | `lib/database/converters/null_aware_map.converter.dart` | Converts maps through JSON encode/decode. | High | Repeat rows are persisted inside one encoded map; partial repeat row persistence is not active here. |
| Draft creation | ACTIVE | `lib/database/dao/data_submissions_dao.dart` | `createDraft` starts at line 162, creates a submission id with `CodeGenerator.generateUid()` at line 171, sets `syncState: draft` and `isToUpdate: false`. | High | Submission id generation is separate from repeat row UID generation. |
| Whole JSON update | ACTIVE | `lib/database/dao/data_submissions_dao.dart` | `updateData` starts at line 198 and writes `syncState: draft`, `formData`, timestamps, and client update time. | High | Editing a synced record likely rewrites it as draft while keeping existing `isToUpdate`; confirm server update semantics at runtime. |
| Final sync upload | ACTIVE | `lib/database/dao/data_submissions_dao.dart` | `upload` starts at line 51; payload is `submissions.map((s) => s.toUpload())` at line 68; success sets `syncState: synced` and `isToUpdate: true` at lines 93-96. | High | Sync sends the whole JSON payload, including repeats as nested data. |
| Upload payload shape | ACTIVE | `lib/database/extensions/data_submission.extension.dart` | `toUpload()` includes `formData` directly at line 19 plus submission metadata. | High | No separate repeat row payload was found in active upload path. |
| Remote submission import | INACTIVE | The dormant `DataInstanceDatasource`, duplicate DAO sync mixin, and unused submission `fromApiJson` parser were removed after confirming they had no runtime caller or DI registration. | High | Production synchronization is push-only. |
| Submission table summaries | ACTIVE | `lib/database/dao/data_submissions_dao.dart` | `selectable` starts at line 562 and extracts display field values with `FormDataUtil.extractTemplateValue(...)` at lines 641-642. | High | Large repeat values can also affect list/table display, because summary extraction walks nested form data. |
| Summary form data utility | ACTIVE | `lib/core/data_instance/form_data_util.dart` | `extractTemplateValue` reads nested form data and aggregates values. | High | Repeat-heavy submissions can have display cost before opening the form. |
| Summary aggregation | ACTIVE | `lib/core/data_instance/form_data_aggregator.dart` | Used by `FormDataUtil`; contains example/debug main code too. | Medium | Active through summary extraction, but example code in the file is not evidence of runtime behavior. |
| Rule action evaluation | ACTIVE | `lib/features/form_submission/application/element/form_element.dart` | `elementRuleActions` are derived from template rules at line 61; `evaluate` starts at line 243; `resolveDependencies` starts at line 397. | High | Dependency resolution/evaluation can run for every element in every repeat row. |
| Dependency lookup in repeats | ACTIVE | `lib/features/form_submission/application/element/element_dependency.extension.dart` | Builds `evalContext` at line 4, normalizes values at line 11, notifies dependents at line 72, and resolves dependency names from parent sections at line 77. | High | Repeat correctness depends on resolving dependencies to the current repeat row/section rather than another row or global field. |
| Section rule traversal | ACTIVE | `lib/features/form_submission/application/element/section_instance.dart` | `resolveDependencies` and `evaluate` recurse children at lines 49-71. | High | Eager recursive traversal can be costly on large nested repeat forms. |
| Repeat rule traversal | ACTIVE | `lib/features/form_submission/application/element/repeat_section.dart` | `resolveDependencies` and `evaluate` recurse through each repeat item. | High | Large repeat rows multiply rule evaluation cost. |
| Field choice filters | ACTIVE | `lib/features/form_submission/application/element/field_instance.dart` | `filterDependencies` at line 27; `evaluate` calls `choiceFilter!.evaluate(evalContext)` at lines 76-99. | High | Choice filtering inside repeats can reevaluate option visibility per row. |
| Rule parsing | ACTIVE | `lib/core/form/rule/rule_parse_extension.dart` | Extracts dependencies, visibility rules, filter dependencies, and calculation dependencies. | High | Determines which fields subscribe to which other fields, including repeat-local dependencies. |
| Rule expression evaluation | ACTIVE | `lib/core/form/rule/action.dart` and `choice_filter.dart` | `RuleAction.evaluate` is at line 90; `ChoiceFilter.evaluate` is at line 18. | High | Runtime expression cost increases with dependency graph size and repeat row count. |
| UID generation helper | ACTIVE | `lib/core/code_generator.dart` | Used for submission ids and referenced by repeat UID code. | High | Any repeat UID fix must separate submission id behavior from repeat row identity behavior. |

## Inactive, Incomplete, Or Legacy-Risk Form-Looking Files

| Classification | File path | Evidence | Confidence | Why it matters for large repeats or repeat UIDs |
| --- | --- | --- | --- | --- |
| OBSOLETE-REMOVED | Commented Riverpod form-instance, element-state, and table-state provider experiments | Their implementations were entirely commented and had no executable references. Active form state remains scoped GetIt `FormInstance` plus `reactive_forms`. | High | These alternate state sketches can no longer be mistaken for repeat rendering or persistence paths. |
| OBSOLETE-REMOVED | Commented element-properties/submission-creation providers and popup/org-unit/repeat-edit widgets | The files contained only commented implementations and had no executable consumers. | High | Active element rebuilding, draft creation, org-unit fields, and repeat editing use different paths mapped above. |
| OBSOLETE-REMOVED | Former per-field `submission_capture_repository` interface/implementation | Both had no active implementation/caller and were removed. | High | Active save ownership is the whole-JSON `FormInstance`/DAO path. |
| OBSOLETE-REMOVED | Unrouted submission-list demos, the replaced assignment-detail submissions table, alternate repeat dialog/panel paths, and other unreachable UI experiments | None had an incoming production import, route, navigation call, DI registration, or test consumer. The active assignment detail now opens `TableScreen`; repeat editing uses `EditRowScreen`. | High | These alternate form and repeat screens can no longer distort the active rendering/edit map. |
| SUPPORTING-USED | `lib/core/element_instance/display_value_lookup.dart` | Registered in DI and used by `MapValueToDisplay` to resolve org-unit, team, and option labels. It has no form-capture persistence methods. | High | This is display-only lookup support and must not be mistaken for submission or repeat storage. |
| OBSOLETE-REMOVED | Legacy `lib/core/form` repository/value-store, alternate evaluation engine, UI model/intent, dependency graph, scan helper, and commented builder trees | No production source imported these closed trees, no active DI registration existed, and the sole external data-integrity provider had no consumers. They were removed after analyzer and form-test validation. | High | These alternate form, validation, and expression implementations can no longer be confused with the active whole-JSON form engine. |
| OBSOLETE-REMOVED | Duplicate standalone expression engine and other unimported form/session/UI leaf libraries | No imports, exports, route/DI/provider registrations, or external symbol consumers were found. | High | Their names no longer compete with the active rule engine, user session, repeat validation, or UI paths. |
| OBSOLETE-REMOVED | Normalized `repeat_instances` persistence path | No runtime read/write remained. Table, DAO, and datasource were removed; schema migration 5 drops populated legacy tables from schema 3/4. | High | Repeat rows are persisted only inside whole submission JSON. |
| OBSOLETE-REMOVED | Repeat-instance datasource | It had no active annotation, order registration, import, or consumer and was removed. | High | Repeat instance sync is not part of the active whole-JSON capture path. |
| OBSOLETE-REMOVED | Normalized `data_values` persistence path | No runtime read/write remained. Table, DAO, datasource, and inactive CRUD facade were removed; schema migration 5 covers schema 3/4. | High | Field values are persisted only inside whole submission JSON. |
| OBSOLETE-REMOVED | Former data-value and metadata-submission datasource/table artifacts | No active registration or persistence path existed, and the source artifacts were removed. | High | They cannot be mistaken for active local capture or sync. The reference-field provider remains separately incomplete. |
| OBSOLETE-REMOVED | Alternate form-template-version datasource | It had no registration or consumer and was removed. Active template sync remains in `DataFormTemplateDatasource`. | High | It can no longer be mistaken for the active form JSON sync path. |
| INCOMPLETE | `lib/features/form_submission/application/element/field_instance.dart` | `CalculatedFieldInstance.evaluate` contains commented calculation assignment logic at lines 135-143. | High | Calculated fields may declare dependencies but not update values, which matters inside repeat rows. |
| ACTIVE | `lib/core/data_instance/repeat_metadata_normalizer.dart`, `repeat_item_instance.dart`, `form_instance.dart`, `data_submissions_dao.dart` | Existing `_id`/legacy `repeatUid` values are preserved, new rows receive ULIDs, full metadata is normalized before save, and upload normalizes old local data as a compatibility guard. | High | This is the current repeat identity contract; server round-trip editing remains a separate product-policy validation. |

## Repeat UID Behavior Map

Observed active behavior:

1. `FormElementBuilder` reads `_id` and accepts legacy `_uid`/`repeatUid` values for compatibility.
2. New rows receive a 26-character ULID; an existing non-null row ID cannot be changed by `RepeatItemInstance.setUid()`.
3. `RepeatItemInstance.reduceValue()` writes `_id` into the row map.
4. `FormInstance.saveFormData()` normalizes `_id`, `_index`, `_parentId`, and `_submissionUid` before persisting the whole `formData` JSON object.
5. `SubmissionUploadService.upload()` asks `DataInstancesDao.prepareUpload()` to normalize older local JSON, persist compatibility additions, and mark eligible rows uploading before POST.

Classification: ACTIVE for local create/save/upload identity behavior. Synced server-record editing remains product-incomplete and requires a round-trip smoke before production enablement.

Confidence: high for code paths and characterization tests; medium for future server round-trip editing behavior.

## Synced Local Record Edit Map

Active path:

1. A locally created submission is uploaded through `SubmissionUploadService.upload()`; the DAO retains all local persistence and sync-state transitions.
2. A successful upload leaves the local row in `synced` state with `isToUpdate: true`.
3. Edit routes load that existing local `DataInstance` by `submissionId`.
4. `FormFlowBootstrapperController` builds the form from existing `instance.formData`.
5. `FormSubmissionScreen` checks `submissionEditStatusProvider`.
6. `FormInstance.saveFormData()` writes the edited whole JSON back through `dataInstancesDao.updateData`.
7. `markSubmissionAsFinal()` makes it eligible for another upload.
8. Upload sends one whole payload and marks successful records synced/updateable.

Classification: ACTIVE.

Confidence: high for the local save/upload path; medium for edit permissions and server update semantics, which still need runtime confirmation with a synced local record. There is no active server-submission pull path.

Why this matters: editing a synced repeat-heavy record can rebuild and resave all repeat rows. If repeat UIDs are missing from saved JSON, update matching may be unstable on the server.

## Local Persistence And Cache Before Sync

Active local layers:

- Form definitions: `form_template_versions` table stores JSON-like `fields`, `sections`, and `options`; loaded through `FormTemplateListService` and `FormTemplateRepository`.
- Submission data: `data_instances`/`data_submissions` table stores one `formData` JSON map per submission.
- Sync flags: `syncState` and `isToUpdate` live on `DataInstance`.
- Summary display cache behavior: table summaries extract from nested `formData` through `FormDataUtil` and `FormDataAggregator`; this is derived from saved JSON, not separately captured repeat rows.

Inactive or not active for capture:

- the removed metadata-submission table/datasource artifacts; the reference-field provider remains incomplete and returns no records.
- The removed `FormValueStore` and `FormRepositoryImpl` capture path was not active.

## Large Repeat Risk Map

| Risk | Evidence | Classification | Confidence | Impact for 200-300 repeat rows |
| --- | --- | --- | --- | --- |
| Eager control creation | `FormElementControlBuilder.createRepeatFormArray` maps every initial row into a `FormGroup`. | ACTIVE | High | Opening a large repeat form allocates controls for every row before user interaction. |
| Eager element tree creation | `FormElementBuilder.buildRepeatSection` maps every row into `RepeatItemInstance`. | ACTIVE | High | Memory and startup time scale with row count times field count. |
| Recursive initial dependency evaluation | Bootstrapper calls root `resolveDependencies()` and `evaluate(emitEvent: false)` after full tree build. | ACTIVE | High | Rule setup/evaluation scales across all elements, including repeats. |
| Repeat-local dependency lookup ambiguity | `findElementInParentSection` walks parent sections then falls back to full tree. | ACTIVE | Medium | Cross-row or same-name fields may resolve unexpectedly; runtime tests needed for nested repeats. |
| Choice filters per row | `FieldInstance.evaluate` reevaluates choice filters from `evalContext`. | ACTIVE | High | Option-heavy fields inside repeats can multiply expression cost. |
| Paginated UI with full data source | `RepeatTable` uses `PaginatedDataTable`, but `RepeatTableDataSource` holds all row instances. | ACTIVE | High | Pagination may reduce visible rows but not build/load memory cost. |
| Whole JSON save on row edit | Repeat row save calls `formInstance.saveFormData()`. | ACTIVE | High | Editing one row serializes and writes the whole form object. |
| Repeat identity server round trip | Local save/upload preserves backend metadata, but synced editing is not a validated production workflow. | REACHABLE-INCOMPLETE | Medium | Enabling synced edits requires proof that existing IDs survive and only new nested rows receive new IDs. |
| Suspicious data source update predicate | `RepeatTableDataSource.updateItems` uses a self-comparison predicate. | UNKNOWN | Medium | Row updates may be broader or less precise than intended; verify behavior before optimizing. |
| Field subscription churn | `FieldWidget` subscribes to `control.valueChanges` and explicitly cancels from hook cleanup. | ACTIVE | Medium | Leaking is no longer the static concern, but many simultaneously mounted fields still create listener and rebuild cost. |
| Submission edit-status ownership | RESOLVED | Bootstrap and `submissionEditStatusProvider` delegate to `submission_edit_access.dart`. | High | The temporary permission rule now has one executable owner; the final synced-edit product policy is still open. |

## Smallest Set To Understand Before Changing Repeat Performance Or Repeat UID Behavior

Treat these as the minimum "do not touch until understood" set for repeat performance or repeat UID work:

- `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart`
- `lib/core/form/builder/form_element_control_builder.dart`
- `lib/core/form/builder/form_element_builder.dart`
- `lib/features/form_submission/application/element/form_instance.dart`
- `lib/features/form_submission/application/element/form_element.dart`
- `lib/features/form_submission/application/element/element_dependency.extension.dart`
- `lib/features/form_submission/application/element/section_instance.dart`
- `lib/features/form_submission/application/element/repeat_section.dart`
- `lib/features/form_submission/application/element/repeat_item_instance.dart`
- `lib/features/form_submission/application/element/field_instance.dart`
- `lib/features/form_submission/presentation/form_submission_screen.widget.dart`
- `lib/features/form_submission/presentation/form_entry_view_silver.widget.dart`
- `lib/features/form_submission/presentation/section/section.widget.dart`
- `lib/features/form_submission/presentation/section/repeat_table_sliver.dart`
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart`
- `lib/features/form_submission/presentation/section/repeat_table_rows_source.dart`
- `lib/features/form_submission/presentation/section/edit_row_screen.dart`
- `lib/features/form_submission/presentation/field/field.widget.dart`
- `lib/features/form_submission/application/form_widget_factory.dart`
- `lib/features/form_submission/application/submission_list.provider.dart`
- `lib/data/form_template_repository.dart`
- `lib/data/form_template_list_service.dart`
- `lib/database/tables/data_submissions.table.dart`
- `lib/database/dao/data_submissions_dao.dart`
- `lib/database/extensions/data_submission.extension.dart`
- `lib/database/converters/null_aware_map.converter.dart`
- `lib/core/form/rule/action.dart`
- `lib/core/form/rule/choice_filter.dart`
- `lib/core/form/rule/rule_parse_extension.dart`
- `lib/core/data_instance/form_data_util.dart`
- `lib/core/data_instance/form_data_aggregator.dart`

## Questions Requiring Runtime Confirmation

1. Does a server round trip preserve existing repeat metadata when synced editing is eventually enabled, including nested repeats and newly added rows?
2. Should finalized and failed-but-unsynced records remain editable under the current `not synced` rule, or should editability distinguish each submission state?
3. Does `RepeatTableDataSource.updateItems` behave correctly despite the self-comparison predicate?
4. For nested repeats or repeated field names, does `findElementInParentSection` resolve dependencies to the intended row-local field every time?
5. How long does bootstrap take on a real form with 200-300 repeat rows and representative choice filters/calculated fields?
6. Does `PaginatedDataTable` create only visible row widgets, or do row/cell builders still cause expensive traversal across all repeat elements during refresh?
7. Are calculated fields expected to work in production forms, given that `CalculatedFieldInstance.evaluate` calculation writeback is commented?

## Next Investigation Step

Run one instrumented manual/runtime pass with a real example form containing repeats:

1. Use a server-submitted fixture when synced editing is enabled, edit one existing row, add one nested row, save/finalize/upload, and compare metadata before and after.
2. Record bootstrap time, number of repeat rows, number of field instances, and mounted listener counts during row edit navigation.
3. Exercise nested visibility, mandatory, and expression dependencies against a representative large form.

Do this before any refactor or optimization so the static map can be corrected with runtime facts.
