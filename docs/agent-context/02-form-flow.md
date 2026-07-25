# Form Flow Code Map

Generated: 2026-07-10
Reconciled: 2026-07-24 against production `v6.0.0+50`

Scope: evidence-based map for form JSON loading, form rendering, repeats, expression evaluation touching repeats, submission save/edit, repeat UID behavior, and local persistence before sync. This complements `01-production-code-path-map.md`; it intentionally does not remap the whole app entrypoint and SDK entrypoint surface.

This map is reconciled with the backend-compatible repeat contract in
`decisions/07-repeat-uid-contract.md`.

Status legend:

- ACTIVE: removing the path without replacement breaks form load/render/repeat/edit/save or submission persistence.
- SUPPORTING-USED: reached by form UI but not itself form capture authority.
- INACTIVE: not referenced by active runtime flow found in this scan.
- INCOMPLETE: reachable behavior exists but its product/data contract is unfinished.
- LEGACY-RISK: old code that might still be called indirectly or reused accidentally.
- UNKNOWN: cannot prove either way from static references.

## Active Form Flow

| Area | Classification | File path | Evidence | Confidence | Why it matters for large repeats or repeat UIDs |
| --- | --- | --- | --- | --- | --- |
| Form and row navigation | ACTIVE | `lib/app/stacked/app.dart`; `lib/features/form_submission/presentation/section/repeat_table.widget.dart` | `FormSubmissionScreen` and `FormFlowBootstrapper` are generated routes. Repeat editing has one separate entry path: the active table pushes a context-owned `MaterialPageRoute<RepeatRowEditResult>`, waits for route completion, then applies the result. | High | Repeat editor lifetime is owned by the table's materialize/navigate/result/dematerialize sequence. |
| Create/edit navigation from table | ACTIVE | `lib/features/data_instance/presentation/table_screen.dart` | New submission action calls `navigateToFormFlowBootstrapper(formId, assignmentId)`. | High | This is the active create path into form loading. |
| Edit navigation from table rows | ACTIVE | `lib/features/data_instance/presentation/table_widget.dart` | Existing row edit calls `navigateToFormFlowBootstrapper` with `submissionId`, `formId`, `versionId`, and `assignmentId`. | High | This is the local synced/unsynced edit path into repeat rendering. There is no active server-submission pull path. |
| Assignment detail create path | ACTIVE | `lib/features/assignment_detail/presentation/assignment_detail_page.dart` | Form selection calls `navigateToFormFlowBootstrapper(formId, assignmentId)`. | High | Confirms active production flow can create submissions without going through only the data instance table screen. |
| Bootstrapper view | ACTIVE | `lib/features/form_submission/presentation/form_flow_bootstrapper.dart` | The routed stateful loading view invokes `FormFlowBootstrapperController.bootstrapFlow(submissionId)` after its first frame and displays bootstrap errors. | High | The bootstrapper is the hard boundary where the form instance scope is created. |
| Draft/load bootstrap logic | ACTIVE | `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` | `createDraft` is called for new submissions; existing local submissions are loaded through `dataInstancesDao.getById(submissionId)`. | High | Local drafts, finals, and locally retained synced rows converge here before the full form tree is built. |
| Per-submission DI scope | ACTIVE | `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` | Pushes a GetIt scope named by `dataInstance.id` and registers `FieldContextRegistry`, `FormTemplateRepository`, and `FormInstance` with their disposers. | High | Repeat state and field keys are submission-scoped; element streams, dependency links, controls, and keys are released with the route-owned scope. |
| Template JSON load | ACTIVE | `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` | Calls `FormTemplateRepository.create(versionUid: dataInstance.templateVersion)`. | High | The active flow loads one template version as a whole before rendering; no lazy section/repeat load was found. |
| Form controls build | ACTIVE | `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart`; `lib/core/form/builder/form_element_control_builder.dart` | Creates the root `FormGroup`; each stored repeat row starts as one map control instead of a field-control subtree. `FormInstance.materializeRepeatItem(...)` swaps in a full row `FormGroup` while its editor is open and `dematerializeRepeatItem(...)` captures and disposes it on close. | High | The element/rule graph remains eager, but 200-300 dormant rows no longer retain thousands of field controls and streams. |
| Form element tree build | ACTIVE | `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` | Calls `FormElementBuilder.buildFormElements(...)`, wraps it in a root `Section`, then calls `resolveDependencies()` and `evaluate(emitEvent: false)` before navigation. | High | Repeat trees, dependencies, and initial rule evaluation are all eager. |
| Form template repository | ACTIVE | `lib/data/form_template_repository.dart` | `create` loads template, options, and option sets; `rootSection` exposes the canonical tree from template fields and sections. | High | Template tree construction is central to repeat path names and dependency lookup. |
| Template local query service | ACTIVE | `lib/data/form_template_list_service.dart` | `fetchByFilter` uses `formTemplateVersionsDao.selectFormTemplatesWithRefs(...)`; `getTemplateByVersionOrLatest` loads the requested or latest version. | High | This is the active local cache layer for form JSON before rendering. |
| Template storage table | ACTIVE | `lib/database/tables/form_template_versions.table.dart` | Stores `fields`, `sections`, and `options` as text columns with converters. | High | Confirms active form definition is stored as JSON-like blobs, not normalized per field table reads at render time. |
| Template sync datasource | ACTIVE | `lib/datasource/remote_data_sources/form_template_datasource.dart` | Registered in the active datasource list; fetches templates and extracts `formTemplateVersions` child rows. | High | This is the sync path that populates the local template version JSON used by forms. |
| Form screen | ACTIVE | `lib/features/form_submission/presentation/form_submission_screen.widget.dart` | Watches `submissionEditStatusProvider`, renders `FormInstanceEntryViewSliver`, awaits `FormInstance.saveFormData()`, and finalizes through `markSubmissionAsFinal()`. | High | This is the main rendering/save host. Riverpod owns edit-access projection while scoped `FormInstance` owns form state. |
| Root rendering sliver | ACTIVE | `lib/features/form_submission/presentation/form_entry_view_silver.widget.dart` | Reads `appLocator<FormInstance>()` and maps root elements to `SectionWidget`, `RepeatTableSliver`, or `FieldWidget`. | High | Rendering starts by iterating all root elements. Repeats are rendered as tables, not virtualized row forms. |
| Section rendering | ACTIVE | `lib/features/form_submission/presentation/section/section.widget.dart` | Watches `element.propertiesChanged` and recursively renders sections, repeat tables, and fields. | High | Hidden/visible rules and repeat nesting trigger rebuilds through `propertiesChanged`. |
| Field rendering | ACTIVE | `lib/features/form_submission/presentation/field/field.widget.dart` | `FieldWidget` subscribes to control value changes and renders `FieldFactory.fromType(element)`. Its hook cleanup returns `subscription.cancel`. | High | Every field inside every open repeat-row editor attaches value-change behavior; cancellation is explicit, but lifecycle churn remains relevant to performance. |
| Field widget factory | ACTIVE | `lib/features/form_submission/application/form_widget_factory.dart` | `FieldFactory` is called by `FieldWidget`; maps field `ValueType` to concrete reactive widgets. | High | Large repeat row cost depends on the number and type of fields created per row. |
| Repeat controls build | ACTIVE | `lib/core/form/builder/form_element_control_builder.dart`; `lib/features/form_submission/application/element/form_instance.dart` | Repeatable sections create a `FormArray<Map<String,Object?>>` of map controls. Opening a row materializes only that row's field controls; closing captures retained values and disposes the row `FormGroup`. Nested rows use the same lifecycle. | High | This removes the primary retained-control memory multiplier while preserving whole-JSON save, row validation, dependencies, and repeat identity. |
| Repeat element tree build | ACTIVE | `lib/core/form/builder/form_element_builder.dart` | `buildRepeatSection` maps every initial list row into a `RepeatItemInstance`; `buildRepeatItem` reads the row ID through `RepeatMetadataNormalizer`. | High | Client/server repeat identity depends on preserving the metadata read here. |
| Repeat section model | ACTIVE | `lib/features/form_submission/application/element/repeat_section.dart` | `RepeatSection` owns `BehaviorSubject<List<RepeatItemInstance>>`, `addAll`, `reduceValue`, `resolveDependencies`, and `evaluate`. | High | Repeat collection changes and rule evaluation are centralized here. Large repeats may emit and evaluate many rows. |
| Repeat row model | ACTIVE | `lib/features/form_submission/application/element/repeat_item_instance.dart` | Reads an existing row ID, prevents changing a non-null ID, generates a ULID when missing, and writes `_id` in `reduceValue()`. | High | Stable repeat identity is now part of the active reduced JSON rather than a UI-only `repeatUid` marker. |
| Add/remove repeat rows | ACTIVE | `lib/features/form_submission/application/element/form_instance.dart` | `onAddRepeatedItem` creates a lightweight row control plus element tree and evaluates it; the editor then materializes its field controls. `onRemoveRepeatedItem` removes the exact model/control row. | High | Collection position drives rendering and missing `_index` normalization, while `_id` supplies stable identity across saves. |
| Repeat table sliver | ACTIVE | `lib/features/form_submission/presentation/section/repeat_table_sliver.dart` | Wraps `RepeatTable` and watches repeat properties. | High | This is the active repeat rendering bridge. |
| Repeat table | ACTIVE | `lib/features/form_submission/presentation/section/repeat_table.widget.dart` | Owns `RepeatTableDataSource`, paginated rendering, add/edit/delete selection, row materialization, typed editor results, and persistence callbacks. | High | The data source retains all element rows even though only one page is rendered; top-level row save writes the whole form JSON. |
| Repeat row edit session and screen | ACTIVE | `lib/features/form_submission/application/repeat_row_edit_session.dart`; `lib/features/form_submission/presentation/section/edit_row_screen.dart`; `lib/features/form_submission/presentation/section/repeat_row_edit_result.dart` | The session snapshots retained row data and classifies pristine/changed/new/valid state. The screen renders commands and returns a typed save/discard result; `FormInstance` owns restoration and persistence. UID creation remains in repeat reduction/normalization, not navigation. | High | Existing and nested rows can close pristine, save valid changes, or restore exact values/collections without using UID or validity as a navigation proxy. |
| Repeat table data source | ACTIVE | `lib/features/form_submission/presentation/section/repeat_table_rows_source.dart` | Extends `DataTableSource`; keeps a private presentation snapshot replaced from authoritative `RepeatSection.elements`; `getRow` iterates fields for a repeat row. | High | For large repeats, row rendering still scans row fields, but the table no longer merges or retains detached row objects after restore/remove. |
| Form instance save | ACTIVE | `lib/features/form_submission/application/element/form_instance.dart` | `saveFormData` reads the existing submission, reduces `formSection.value`, normalizes repeat metadata, preserves submission metadata keys, and awaits `DataInstancesDao.updateData`. | High | Every save writes one whole `formData` map. Repeat changes are not saved as separate row/value records. |
| Mark final | ACTIVE | `lib/features/form_submission/application/element/form_instance.dart` | `markSubmissionAsFinal` delegates completion state/time to the DAO after a successful save. | High | Finalization changes sync eligibility after whole JSON save. |
| Completion action and exit | ACTIVE | `lib/features/form_submission/presentation/widgets/bottom_sheet.widget.dart`, `form_submission_screen.widget.dart`, `lib/features/form_submission/application/form_scope.dart` | The bottom sheet returns one typed action. Exit actions pop the route; `FormSubmissionScreenState.dispose()` then closes the submission scope. Focused tests prove typed sheet return, route-owned scope closure, and nested form-graph disposal. | High | Teardown follows actual route disposal, covering explicit exits and external route removal without disposing controls during a navigation transition. |
| Submission edit status | ACTIVE | `lib/features/form_submission/application/submission_edit_access.dart`, `submission_list.provider.dart` | `submissionEditStatusProvider` and form bootstrap both delegate to the same `canEditSubmission(...)` query. Focused tests cover local submissions and synced submissions with and without server edit permission. | High for local rule, medium for final product policy | Determines whether synced server submissions can be edited again without allowing bootstrap and screen state to diverge. |
| Data instance table | ACTIVE | `lib/database/tables/data_submissions.table.dart` | `formData` is a single nullable text column mapped through `NullAwareMapConverter`; `syncState` and `isToUpdate` are stored on the same row. | High | Confirms active submission persistence is whole JSON per submission. |
| JSON map converter | ACTIVE | `lib/database/converters/null_aware_map.converter.dart` | Converts maps through JSON encode/decode. | High | Repeat rows are persisted inside one encoded map; partial repeat row persistence is not active here. |
| Draft creation | ACTIVE | `lib/database/dao/data_submissions_dao.dart` | `createDraft` generates an 11-character submission UID and writes `syncState: draft`, `isToUpdate: false`, and the selected template/assignment metadata. | High | Submission identity generation is separate from repeat row identity. |
| Whole JSON update | ACTIVE | `lib/database/dao/data_submissions_dao.dart` | `updateData` writes the complete `formData`, draft state, and client update timestamps while leaving unrelated persisted identity/update columns intact. | High | Local synced editing can make a row draft again; final server update policy remains incomplete. |
| Final sync upload | ACTIVE | `lib/features/data_instance/application/submission_upload_service.dart`; `lib/database/dao/data_submissions_dao.dart` | The service asks `prepareUpload` to normalize/mark eligible rows, posts `toUpload()` payloads, then calls `applyUploadResult` or `markUploadFailed`. | High | Sync sends whole nested JSON and every prepared row leaves `uploading` as synced or typed failure. |
| Upload payload shape | ACTIVE | `lib/database/extensions/data_submission.extension.dart` | `toUpload()` includes `formData` directly with submission metadata. | High | No separate repeat-row payload is active. |
| Remote submission import | INACTIVE | The dormant `DataInstanceDatasource`, duplicate DAO sync mixin, and unused submission `fromApiJson` parser were removed after confirming they had no runtime caller or DI registration. | High | Production synchronization is push-only. |
| Submission table summaries | ACTIVE | `lib/database/dao/data_submissions_dao.dart` | `selectable` projects display fields with `FormDataUtil.extractTemplateValue(...)`. | High | Large repeat values can also affect list/table display because summary extraction walks nested form data. |
| Summary form data utility | ACTIVE | `lib/core/data_instance/form_data_util.dart` | `extractTemplateValue` reads nested form data and aggregates values. | High | Repeat-heavy submissions can have display cost before opening the form. |
| Summary aggregation | ACTIVE with SOURCE-DEAD fragment | `lib/core/data_instance/form_data_aggregator.dart` | Aggregation methods are used by `FormDataUtil`; the same file also contains an uncalled debug/example `main()` and `print` statements. | High | Keep the aggregation owner; remove the debug fragment separately so agents do not treat it as a runtime entrypoint. |
| Rule action evaluation | ACTIVE | `lib/features/form_submission/application/element/form_element.dart` | Template rule actions are parsed once, dependencies are registered, and `evaluate` applies each reached rule through the control/presentation boundary. | High | Dependency evaluation can run for every affected element in repeat rows. |
| Dependency lookup in repeats | ACTIVE | `lib/features/form_submission/application/element/element_dependency.extension.dart` | Builds normalized `evalContext`, notifies dependents, and resolves names from row/parent/root context. | High | Repeat correctness depends on resolving dependencies to the intended row or outside field. |
| Section rule traversal | ACTIVE | `lib/features/form_submission/application/element/section_instance.dart` | `resolveDependencies` and `evaluate` recurse through child elements. | High | Eager recursive traversal can be costly on large nested repeat forms. |
| Repeat rule traversal | ACTIVE | `lib/features/form_submission/application/element/repeat_section.dart` | `resolveDependencies` and `evaluate` recurse through each repeat item. | High | Large repeat rows multiply rule evaluation cost. |
| Field choice filters | REACHABLE-SUPPORTING | `lib/features/form_submission/application/element/field_instance.dart`, `lib/core/form/rule/choice_filter.dart` | `FieldInstance.dependencies` includes the filter's dependencies and `evaluate()` projects `ChoiceFilter.evaluate(evalContext)` into `FieldElementState.visibleOptions`. The 19 form versions captured from the live tablet database on 2026-07-22 contain no field-level `choiceFilter`. | High for code path, medium for production use outside the captured assignments | Choice filtering is tested and row-local when configured, but is not proven core-active for the captured production form set. |
| Rule dependency parsing | ACTIVE | `lib/core/form/rule/rule_parse_extension.dart`, `lib/core/form/rule/choice_filter.dart` | Template rule and calculation dependencies are parsed by `rule_parse_extension.dart`; choice-filter normalization and dependency extraction are owned by `ChoiceFilter`. | High | Keeping dependency ownership explicit prevents filters and rule actions from registering different graphs for the same expression. |
| Rule expression evaluation | ACTIVE | `lib/core/form/rule/action.dart`, `lib/core/form/rule/choice_filter.dart` | `RuleAction` owns rule-action expression evaluation; `ChoiceFilter` owns option-filter expression evaluation. | High | Runtime expression cost increases with dependency graph size and repeat row count. |
| UID generation helper | ACTIVE | `lib/core/code_generator.dart` | Used for submission ids and referenced by repeat UID code. | High | Any repeat UID fix must separate submission id behavior from repeat row identity behavior. |

## Active Form State Ownership Contract

This is the current ownership boundary after removing the duplicate rule-effect path and duplicate field-value state. Do not add field values or control validity back to element state.

This table describes the active implementation; it is not a requirement to preserve the current dual graph or `reactive_forms` control lifetime forever. A replacement may move value or validation ownership when it defines one authority, explicit editor commit/cancel behavior, and equivalent persisted JSON, identity, rule, validation, and offline behavior. Do not preserve implementation debt by calling it an invariant.

| Component | Sole responsibility | Explicitly not owned here |
| --- | --- | --- |
| Form template JSON | Declarative field, section, rule, calculation, and choice-filter intent. | Runtime value, validity, visibility, or persistence state. |
| `FormElementState` | Presentation/rule projection for one element: hidden, read-only, mandatory indicator, warning, and rule errors. | Field value, enabled state, validator installation, control errors, or form validity. |
| `FieldElementState` | `FormElementState` plus the currently visible choice options produced by `ChoiceFilter`. | Selected value or selection validity. |
| `reactive_forms` `FormControl`/`FormGroup`/`FormArray` | Authoritative field values, enabled/disabled state, installed validators, control errors, and validity. These controls are reduced into submission JSON. | Rule dependency graph or presentation-only warnings. |
| `FormElementInstance` tree | Runtime element hierarchy, dependency links, rule-action application, element-state projection, and notifications to dependent elements. Rule actions update both the projection and corresponding control behavior through this boundary. | A second value or validity store. |
| `FieldInstance` | Exact control binding, dependency notification bridge, and choice-filter projection for a field. | Independent field-value storage; `reduceValue()` reads the bound control. |
| `Section`/`RepeatSection`/`RepeatItemInstance` | Section and repeat hierarchy, repeat-row lifecycle, traversal, reduction, and repeat metadata preservation. | Per-field value or validation authority. |
| `FormInstance` | Per-submission form lifecycle, repeat add/remove orchestration, whole-form reduction, and persistence. | Per-widget presentation state or a parallel form-value store. |
| Form widgets | Render controls and element-state projections and forward raw user control changes into dependency notification. | Durable form state or business-rule authority. |

The removed `RuleEffectStateFactory` path and former `FieldElementState.value` storage are obsolete and must not be recreated. Calculated fields are unsupported/incomplete and are not part of this established ownership contract.

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
| UNSUPPORTED-INCOMPLETE | `lib/features/form_submission/application/element/field_instance.dart`, `lib/core/form/rule/calculated_Expression.dart` | `CalculatedFieldInstance.evaluate` contains commented calculation assignment logic, and calculated widgets render no input. None of the 19 form versions captured from the live tablet database on 2026-07-22 uses `ValueType.Calculated`. | High | A calculated field introduced by configuration would be accepted by parsing but would not calculate. Do not advertise or depend on this type until a separate product contract and implementation are approved. |
| ACTIVE | `lib/core/form/rule/validation_rule.dart`, `lib/core/form/rule/rule_parse_extension.dart`, `lib/features/form_submission/application/element/field_instance.dart` | `validationRule` dependencies are registered and evaluated through the control-validator error channel. When present, it is the sole expression-validation authority and the generated compatibility Error action is ignored. Live malaria age proves the authoritative threshold is `<= 0` or `> 100`, not the stale compatibility threshold `> 150`. | High | Keep this one-authority contract when simplifying expressions or changing server compatibility output. `test/dev/form_validation_rule_test.dart` covers divergence, dependencies, validator coexistence, and parent hide/show restoration. |
| ACTIVE-DEPRECATED-COMPATIBILITY | `lib/core/form/rule/action.dart`, `lib/features/form_submission/application/element/rule.extension.dart` | `RuleActionType.Error` remains active only for older cached form JSON without `validationRule`. Current fields with `validationRule` suppress the generated Error copy so the expression is not evaluated twice. | High | The server must continue emitting compatibility Error actions for deployed older app versions. Remove server compatibility output only after the minimum supported field version has advanced. |
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

Classification: REACHABLE-INCOMPLETE as a product capability. The local code path is executable when deployed assignment permissions allow it, but synced editing is not yet a validated general production policy.

Confidence: high for the local save/upload path; medium for edit permissions and server update semantics, which still need runtime confirmation with a synced local record. There is no active server-submission pull path.

Why this matters: editing a synced repeat-heavy record rebuilds and resaves the whole JSON. Local repeat metadata is stable, but server update/return behavior must preserve existing IDs and accept only new IDs for newly created rows.

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
| Dormant repeat controls | `FormElementControlBuilder.createRepeatFormArray` retains one map control per stored row; `FormInstance.materializeRepeatItem` creates field controls only for the open editor. | RESOLVED primary control-memory multiplier | High | Control/stream count now scales near row count plus the active editor, not rows times fields. |
| Eager element tree creation | `FormElementBuilder.buildRepeatSection` maps every row into `RepeatItemInstance`. | ACTIVE | High | Memory and startup time scale with row count times field count. |
| Recursive initial dependency evaluation | Bootstrapper calls root `resolveDependencies()` and `evaluate(emitEvent: false)` after full tree build. | ACTIVE | High | Rule setup/evaluation scales across all elements, including repeats. |
| Repeat dependency semantics | `findElementInParentSection` resolves row-local, nested, sibling-to-repeat, and root-to-repeat dependencies; live fixture tests characterize these cases. | ACTIVE | High | Current semantics are tested, while fallback tree walks can still contribute cost. |
| Choice filters per row | `FieldInstance.evaluate` reevaluates choice filters from `evalContext`. | ACTIVE | High | Option-heavy fields inside repeats can multiply expression cost. |
| Paginated UI with full data source | `RepeatTable` uses `PaginatedDataTable`, but `RepeatTableDataSource` holds all row instances. | ACTIVE | High | Pagination may reduce visible rows but not build/load memory cost. |
| Whole JSON save on row edit | A top-level row save calls `formInstance.saveFormData()`; nested row saves defer to the enclosing row edit session. | ACTIVE | High | Committing a top-level row serializes and writes the whole form object. |
| Repeat identity server round trip | Local save/upload preserves backend metadata, but synced editing is not a validated production workflow. | REACHABLE-INCOMPLETE | Medium | Enabling synced edits requires proof that existing IDs survive and only new nested rows receive new IDs. |
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
3. On field devices that previously hung, which measured phase now dominates: dependency/evaluation, table refresh, whole-JSON reduction, or the SQLite update?
4. Does `PaginatedDataTable` create only visible row widgets, or do row/cell builders still cause expensive traversal across all repeat elements during refresh?
5. Are calculated fields expected to become a supported production feature, given that calculation writeback is currently absent?

## Current Follow-Up

The active form flow and ownership boundary are established. Use
`06-large-repeat-hang-data-loss.md` for residual performance investigation,
`09-production-boundaries-and-work-strategy.md` for durable product policy, and
`11-current-work.md` for current priority.
