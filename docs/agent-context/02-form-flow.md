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
| Edit navigation from assignment detail | ACTIVE | `lib/features/assignment_detail/presentation/details_submissions_table.dart` | Existing submission rows navigate to `FormFlowBootstrapper` at line 201. | High | This is another active edit entrypoint for synced or draft records. |
| Assignment detail create path | ACTIVE | `lib/features/assignment_detail/presentation/assignment_detail_page.dart` | Calls `navigateToFormFlowBootstrapper` at line 140. | High | Confirms active production flow can create submissions without going through only the data instance table screen. |
| Bootstrapper view | ACTIVE | `lib/features/form_submission/presentation/form_flow_bootstrapper.dart` | Stacked view creates `FormFlowBootstrapperVm` at lines 73-80 and calls `bootstrapFlow(submissionId)` at line 83. | High | The bootstrapper is the hard boundary where the form instance scope is created. |
| Draft/load bootstrap logic | ACTIVE | `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart` | `createDraft` is called for new submissions at line 47; existing submissions are loaded with `_db.dataInstances.findById(submissionId).getSingle()` at line 54. | High | Existing server-submitted records and local drafts converge here before the full form tree is built. |
| Per-submission DI scope | ACTIVE | `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart` | Pushes a GetIt scope named by `dataInstance.id` at line 60 and registers `FormTemplateRepository`/`FormInstance` at lines 63-68. | High | Repeat state is held in a scoped in-memory `FormInstance`; stale scopes or scope lifetime bugs can affect edit/save behavior. |
| Template JSON load | ACTIVE | `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart` | Calls `FormTemplateRepository.create(versionUid: dataInstance.templateVersion)` at line 65. | High | The active flow loads one template version as a whole before rendering; no lazy section/repeat load was found. |
| Form controls build | ACTIVE | `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart` | Creates full `FormGroup` from `FormElementControlBuilder.formDataControls(...)` at line 103. | High | For 200-300 repeat rows, all repeat row controls are allocated up front. |
| Form element tree build | ACTIVE | `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart` | Calls `FormElementBuilder.buildFormElements(...)` at line 107, wraps it in a root `Section`, then calls `resolveDependencies()` and `evaluate(emitEvent: false)` before navigation. | High | Repeat trees, dependencies, and initial rule evaluation are all eager. |
| Form template repository | ACTIVE | `lib/data/form_template_repository.dart` | `create` loads template, options, and option sets at lines 18-27; `rootSection` builds a tree from template fields and sections. | High | Template flattening/tree construction is central to repeat path names and dependency lookup. |
| Template local query service | ACTIVE | `lib/data/form_template_list_service.dart` | `fetchByFilter` uses `formTemplateVersionsDao.selectFormTemplatesWithRefs(...)` at line 154; `getTemplateByVersionOrLatest` loads version data at lines 166-197. | High | This is the active local cache layer for form JSON before rendering. |
| Template storage table | ACTIVE | `packages/drun_sdk/lib/database/tables/form_template_versions.table.dart` | Stores `fields`, `sections`, and `options` as text columns with converters. | High | Confirms active form definition is stored as JSON-like blobs, not normalized per field table reads at render time. |
| Template sync datasource | ACTIVE | `packages/drun_sdk/lib/datasource/remote_data_sources/form_template_datasource.dart` | Injectable active datasource at lines 9-10; extracts `formTemplateVersions` at lines 18 and 35-49. | High | This is the sync path that populates the local template version JSON used by forms. |
| Form screen | ACTIVE | `lib/features/form_submission/presentation/form_submission_screen.widget.dart` | `FormSubmissionScreen` is active at line 23; watches `submissionEditStatusProvider` at lines 48-49; uses `FormInstanceEntryViewSliver` at line 114; save calls `appLocator<FormInstance>().saveFormData()` at line 211; final submit calls `markSubmissionAsFinal()` at line 275. | High | This is the main rendering/save host. It mixes Riverpod edit status with GetIt-held form instance state. |
| Root rendering sliver | ACTIVE | `lib/features/form_submission/presentation/form_entry_view_silver.widget.dart` | Reads `appLocator<FormInstance>()` and maps root elements to `SectionWidget`, `RepeatTableSliver`, or `FieldWidget` at lines 11-41. | High | Rendering starts by iterating all root elements. Repeats are rendered as tables, not virtualized row forms. |
| Section rendering | ACTIVE | `lib/features/form_submission/presentation/section/section.widget.dart` | Watches `element.propertiesChanged`; recursively renders `SectionWidget`, `RepeatTableSliver`, and `FieldWidget` at lines 13-85. | High | Hidden/visible rules and repeat nesting trigger rebuilds through `propertiesChanged`. |
| Field rendering | ACTIVE | `lib/features/form_submission/presentation/field/field.widget.dart` | `FieldWidget` is active at line 12; subscribes to control value changes and renders `FieldFactory.fromType(element)` at line 55. | High | Every field inside every repeat row can attach value-change behavior. Static scan found cleanup code that returns the subscription object rather than clearly cancelling it; runtime confirmation needed. |
| Field widget factory | ACTIVE | `lib/features/form_submission/application/form_widget_factory.dart` | `FieldFactory` is called by `FieldWidget`; maps field `ValueType` to concrete reactive widgets. | High | Large repeat row cost depends on the number and type of fields created per row. |
| Repeat controls build | ACTIVE | `lib/core/form/builder/form_element_control_builder.dart` | Repeatable sections create a `FormArray<Map<String,Object?>>`; existing initial rows map through `createSectionFormGroup(...)` at lines 51-58. | High | All initial repeat rows become controls up front. This is a primary performance and memory pressure point. |
| Repeat element tree build | ACTIVE | `lib/core/form/builder/form_element_builder.dart` | `buildRepeatInstance` maps every initial list row into a `RepeatItemInstance` at lines 79-91; `buildRepeatItem` reads `initialFormValue?['repeatUid']` at line 69. | High | Client/server repeat UID behavior depends on whether `repeatUid` exists in row JSON. |
| Repeat section model | ACTIVE | `lib/features/form_submission/application/element/repeat_instance.dart` | `RepeatSection` owns `BehaviorSubject<List<RepeatItemInstance>>`, `addAll`, `reduceValue`, `resolveDependencies`, and `evaluate`. | High | Repeat collection changes and rule evaluation are centralized here. Large repeats may emit and evaluate many rows. |
| Repeat row model | ACTIVE | `lib/features/form_submission/application/element/repeat_item_instance.dart` | Has `_uid`, `uid`, `setUid`, index-based `name`, and `reduceValue`; `map['repeatUid'] = _uid ?? CodeGenerator.generateUid()` is commented out at line 47. | High | Static evidence shows repeat UIDs can be read and set, but are not currently written back by `reduceValue`. This is the central repeat UID risk. |
| Add/remove repeat rows | ACTIVE | `lib/features/form_submission/application/element/form_instance.dart` | `onAddRepeatedItem` creates a new row control/tree and evaluates it at lines 134-149; `onRemoveRepeatedItem` removes from model and `FormArray` at lines 153-157. | High | Add/remove is index-based. Without persisted repeat UIDs, editing server-submitted rows may not preserve stable row identity. |
| Repeat table sliver | ACTIVE | `lib/features/form_submission/presentation/section/repeat_table_sliver.dart` | Wraps `RepeatTable` and watches repeat properties. | High | This is the active repeat rendering bridge. |
| Repeat table | ACTIVE | `lib/features/form_submission/presentation/section/repeat_table.widget.dart` | Initializes `RepeatTableDataSource` at line 69; renders `PaginatedDataTable` at line 108; add calls `onAddRepeatedItem` at line 116; row edit opens `_showEditPanel`; save calls `formInstance.saveFormData()` at line 200. | High | Repeats are displayed through `PaginatedDataTable`, but the data source still holds all rows. Add/save inside row edit writes the whole form JSON. |
| Repeat row edit screen | ACTIVE | `lib/features/form_submission/presentation/section/edit_row_screen.dart` | Active routed widget; wraps row `ReactiveForm` at line 114; sets repeat UID with `CodeGenerator.generateUid()` around line 184 when saving a new row. | High | UID generation appears to happen in UI save flow, but persistence is uncertain because row `reduceValue` does not write `repeatUid`. |
| Repeat table data source | ACTIVE | `lib/features/form_submission/presentation/section/repeat_table_rows_source.dart` | Extends `DataTableSource` at line 15; `updateItems` at line 38; `getRow` at line 62 iterates fields for a repeat row. | High | For large repeats, row rendering scans row fields. `updateItems` appears suspicious because its predicate compares `item.elementPath == item.elementPath`; runtime behavior should be verified before changing performance. |
| Form instance save | ACTIVE | `lib/features/form_submission/application/element/form_instance.dart` | `saveFormData` at line 85 reads existing submission, computes `formSection.value`, preserves metadata keys, and calls `_db.dataInstancesDao.updateData(...)`. | High | Every save writes one whole `formData` map. Repeat changes are not saved as separate row/value records. |
| Mark final | ACTIVE | `lib/features/form_submission/application/element/form_instance.dart` | `markSubmissionAsFinal` delegates to DAO at line 176. | High | Finalization changes sync eligibility after whole JSON save. |
| Submission edit status | ACTIVE | `lib/features/form_submission/application/submission_list.provider.dart` | `submissionEditStatusProvider` starts at line 118 and is watched by form screen and edit icons. | Medium | Determines whether synced server submissions can be edited again. There is also bootstrapper-local edit-status logic, so this is duplicated decision logic. |
| Data instance table | ACTIVE | `packages/drun_sdk/lib/database/tables/data_submissions.table.dart` | `formData` is a single nullable text column mapped through `NullAwareMapConverter` at lines 39-40; `syncState` and `isToUpdate` are also stored. | High | Confirms active submission persistence is whole JSON per submission. |
| JSON map converter | ACTIVE | `packages/drun_sdk/lib/database/converters/null_aware_map.converter.dart` | Converts maps through JSON encode/decode. | High | Repeat rows are persisted inside one encoded map; partial repeat row persistence is not active here. |
| Draft creation | ACTIVE | `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart` | `createDraft` starts at line 162, creates a submission id with `CodeGenerator.generateUid()` at line 171, sets `syncState: draft` and `isToUpdate: false`. | High | Submission id generation is separate from repeat row UID generation. |
| Whole JSON update | ACTIVE | `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart` | `updateData` starts at line 198 and writes `syncState: draft`, `formData`, timestamps, and client update time. | High | Editing a synced record likely rewrites it as draft while keeping existing `isToUpdate`; confirm server update semantics at runtime. |
| Final sync upload | ACTIVE | `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart` | `upload` starts at line 51; payload is `submissions.map((s) => s.toUpload())` at line 68; success sets `syncState: synced` and `isToUpdate: true` at lines 93-96. | High | Sync sends the whole JSON payload, including repeats as nested data. |
| Upload payload shape | ACTIVE | `packages/drun_sdk/lib/database/extensions/data_submission.extension.dart` | `toUpload()` includes `formData` directly at line 19 plus submission metadata. | High | No separate repeat row payload was found in active upload path. |
| Remote submission import | INACTIVE | The dormant `DataInstanceDatasource` was removed after confirming it had no runtime imports or DI registration. `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart` still contains an unused `fromApiJson` mapping inherited from its DAO mixin. | High | Production synchronization is push-only. Do not infer that server submissions are pulled into local form state from the remaining DAO parser. |
| Submission table summaries | ACTIVE | `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart` | `selectable` starts at line 562 and extracts display field values with `FormDataUtil.extractTemplateValue(...)` at lines 641-642. | High | Large repeat values can also affect list/table display, because summary extraction walks nested form data. |
| Summary form data utility | ACTIVE | `packages/drun_sdk/lib/core/data_instance/form_data_util.dart` | `extractTemplateValue` reads nested form data and aggregates values. | High | Repeat-heavy submissions can have display cost before opening the form. |
| Summary aggregation | ACTIVE | `packages/drun_sdk/lib/core/data_instance/form_data_aggregator.dart` | Used by `FormDataUtil`; contains example/debug main code too. | Medium | Active through summary extraction, but example code in the file is not evidence of runtime behavior. |
| Rule action evaluation | ACTIVE | `lib/features/form_submission/application/element/form_element.dart` | `elementRuleActions` are derived from template rules at line 61; `evaluate` starts at line 243; `resolveDependencies` starts at line 397. | High | Dependency resolution/evaluation can run for every element in every repeat row. |
| Dependency lookup in repeats | ACTIVE | `lib/features/form_submission/application/element/element_dependency.extension.dart` | Builds `evalContext` at line 4, normalizes values at line 11, notifies dependents at line 72, and resolves dependency names from parent sections at line 77. | High | Repeat correctness depends on resolving dependencies to the current repeat row/section rather than another row or global field. |
| Section rule traversal | ACTIVE | `lib/features/form_submission/application/element/section_instance.dart` | `resolveDependencies` and `evaluate` recurse children at lines 49-71. | High | Eager recursive traversal can be costly on large nested repeat forms. |
| Repeat rule traversal | ACTIVE | `lib/features/form_submission/application/element/repeat_instance.dart` | `resolveDependencies` and `evaluate` recurse each repeat item at lines 52-74. | High | Large repeat rows multiply rule evaluation cost. |
| Field choice filters | ACTIVE | `lib/features/form_submission/application/element/field_instance.dart` | `filterDependencies` at line 27; `evaluate` calls `choiceFilter!.evaluate(evalContext)` at lines 76-99. | High | Choice filtering inside repeats can reevaluate option visibility per row. |
| Rule parsing | ACTIVE | `packages/drun_sdk/lib/core/form/rule/rule_parse_extension.dart` | Extracts dependencies, visibility rules, filter dependencies, and calculation dependencies. | High | Determines which fields subscribe to which other fields, including repeat-local dependencies. |
| Rule expression evaluation | ACTIVE | `packages/drun_sdk/lib/core/form/rule/action.dart` and `choice_filter.dart` | `RuleAction.evaluate` is at line 90; `ChoiceFilter.evaluate` is at line 18. | High | Runtime expression cost increases with dependency graph size and repeat row count. |
| UID generation helper | ACTIVE | `packages/drun_sdk/lib/core/code_generator.dart` | Used for submission ids and referenced by repeat UID code. | High | Any repeat UID fix must separate submission id behavior from repeat row identity behavior. |

## Inactive, Incomplete, Or Legacy-Risk Form-Looking Files

| Classification | File path | Evidence | Confidence | Why it matters for large repeats or repeat UIDs |
| --- | --- | --- | --- | --- |
| OBSOLETE-REMOVED | Commented Riverpod form-instance, element-state, and table-state provider experiments | Their implementations were entirely commented and had no executable references. Active form state remains scoped GetIt `FormInstance` plus `reactive_forms`. | High | These alternate state sketches can no longer be mistaken for repeat rendering or persistence paths. |
| OBSOLETE-REMOVED | Commented element-properties/submission-creation providers and popup/org-unit/repeat-edit widgets | The files contained only commented implementations and had no executable consumers. | High | Active element rebuilding, draft creation, org-unit fields, and repeat editing use different paths mapped above. |
| INACTIVE | `lib/features/form_submission/application/repository/submission_capture_repository_impl.dart` | Implementation class is commented. | High | Old per-field/value submission logic should not be assumed active. |
| LEGACY-RISK | `lib/features/form_submission/application/repository/submission_capture_repository.dart` | Interface exists, but no active implementation was found in current form flow. | Medium | Could mislead future work toward a repository abstraction not used by current saves. |
| LEGACY-RISK | `lib/features/form_submission/presentation/section/edit_row_panel.dart` | Still compiled and imported by repeat UI, but the active `_showEditPanel` path navigates to `EditRowScreen`; `showEditDialog`/panel path appears secondary. | Medium | Could still be called from local dialog code paths; do not delete or modify until runtime confirms. |
| LEGACY-RISK | `lib/features/form_submission/presentation/section/sliver_form_dialog.dart` | Compiled widget with repeat/field rendering, but no active navigation call was proven in this scan. | Medium | Another possible row/section renderer that could be reintroduced or indirectly used. |
| LEGACY-RISK | `lib/core/element_instance/data_value_repository.dart` | Directly reads/writes `db.dataValues`; active capture save does not call it, but it is registered in DI and used by display mapping services. | Medium | Data values table exists and can confuse repeat persistence work. It is not active for form save. |
| OBSOLETE-REMOVED | Legacy `lib/core/form` repository/value-store, alternate evaluation engine, UI model/intent, dependency graph, scan helper, and commented builder trees | No production source imported these closed trees, no active DI registration existed, and the sole external data-integrity provider had no consumers. They were removed after analyzer and form-test validation. | High | These alternate form, validation, and expression implementations can no longer be confused with the active whole-JSON form engine. |
| UNKNOWN | `lib/features/form_submission/application/evaluation_engine.dart` | No active imports found in current form element evaluation path. | Low | It may be abandoned or experimental; avoid assuming it evaluates repeat expressions. |
| LEGACY-RISK | `packages/drun_sdk/lib/database/tables/repeat_instances.table.dart` | Table is included in `AppDatabase`, but active form save stores repeat rows inside `data_submissions.formData`. | Medium | Form-related table name is misleading for current capture. It may be old sync design or future work. |
| LEGACY-RISK | `packages/drun_sdk/lib/database/dao/repeat_instances_dao.dart` | DAO exists; no active capture save call found. | Medium | Do not use it as proof that repeat rows are separately persisted. |
| INACTIVE | `packages/drun_sdk/lib/datasource/remote_data_sources/repeat_instance_datasource.dart` | `@Injectable` annotation is commented; `remote_datasource_order_map.dart` comments out `repeatInstance`. | High | Repeat instance sync is not registered in active SDK session datasource list. |
| LEGACY-RISK | `packages/drun_sdk/lib/database/tables/data_values.table.dart` and `data_values_dao.dart` | Table/DAO exist and are exposed through `DSdk.dataValue`, but current capture save uses `dataInstancesDao.updateData`. | Medium | Data values are not the active repeat/field save path, even if used by display or older code. |
| INACTIVE | `packages/drun_sdk/lib/datasource/remote_data_sources/data_value_datasource.dart` | `@Injectable` annotation is commented. | High | Data value sync is not part of active form capture sync. |
| INACTIVE | `packages/drun_sdk/lib/database/tables/metadata_submissions.table.dart` and `remote_data_sources/metadata_submission_datasource.dart` | Table and datasource are commented. | High | Not active local persistence before sync. |
| INACTIVE | `packages/drun_sdk/lib/datasource/remote_data_sources/form_template_version_datasource.dart` | Injectable/order annotations are commented. Active template datasource extracts form versions. | High | Do not use this as the active form JSON sync path. |
| LEGACY-RISK | `lib/features/form/presentation/submission_list_page_1.dart`, `_3.dart`, `_4.dart`, `_5.dart` | Static/demo-looking pages reference `dataValues`; no active route registration found in current Stacked routes. | Medium | These pages can confuse the current submission table/form edit path. |
| INCOMPLETE | `lib/features/form_submission/application/element/field_instance.dart` | `CalculatedFieldInstance.evaluate` contains commented calculation assignment logic at lines 135-143. | High | Calculated fields may declare dependencies but not update values, which matters inside repeat rows. |
| INCOMPLETE | `lib/features/form_submission/application/element/repeat_item_instance.dart` | `repeatUid` writeback in `reduceValue` is commented at line 47. | High | This is the main incomplete-looking repeat UID persistence point. |

## Repeat UID Behavior Map

Observed active behavior:

1. Existing repeat row JSON may be read from `initialFormValue?['repeatUid']` in `lib/core/form/builder/form_element_builder.dart:69`.
2. New rows can receive a generated UID in UI save paths in `edit_row_screen.dart` and `repeat_table.widget.dart`.
3. `RepeatItemInstance.reduceValue()` currently does not write `repeatUid` back into the saved row map because the write line is commented.
4. `FormInstance.saveFormData()` persists `formSection.value` into one whole `dataInstances.formData` JSON object.
5. Upload sends that whole `formData` through `DataInstance.toUpload()`.

Classification: INCOMPLETE for persisted repeat UID behavior.

Confidence: high for static evidence; medium for runtime impact because a runtime save test is still needed to prove whether any other layer injects `repeatUid`.

Why this matters: server-submitted records with repeat rows can only preserve stable client row identity if the row UID survives load, edit, save, and upload. Static evidence shows UID read/set points exist, but the central save reduction path appears not to include it.

## Synced Local Record Edit Map

Active path:

1. A locally created submission is uploaded through `DataInstancesDao.upload()`.
2. A successful upload leaves the local row in `synced` state with `isToUpdate: true`.
3. Edit routes load that existing local `DataInstance` by `submissionId`.
4. `FormFlowBootstrapperVm` builds the form from existing `instance.formData`.
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

- `repeat_instances` table/DAO/datasource.
- `data_values` capture datasource.
- `metadata_submissions`.
- The removed `FormValueStore` and `FormRepositoryImpl` capture path was not active.

## Large Repeat Risk Map

| Risk | Evidence | Classification | Confidence | Impact for 200-300 repeat rows |
| --- | --- | --- | --- | --- |
| Eager control creation | `FormElementControlBuilder.createRepeatFormArray` maps every initial row into a `FormGroup`. | ACTIVE | High | Opening a large repeat form allocates controls for every row before user interaction. |
| Eager element tree creation | `FormElementBuilder.buildRepeatInstance` maps every row into `RepeatItemInstance`. | ACTIVE | High | Memory and startup time scale with row count times field count. |
| Recursive initial dependency evaluation | Bootstrapper calls root `resolveDependencies()` and `evaluate(emitEvent: false)` after full tree build. | ACTIVE | High | Rule setup/evaluation scales across all elements, including repeats. |
| Repeat-local dependency lookup ambiguity | `findElementInParentSection` walks parent sections then falls back to full tree. | ACTIVE | Medium | Cross-row or same-name fields may resolve unexpectedly; runtime tests needed for nested repeats. |
| Choice filters per row | `FieldInstance.evaluate` reevaluates choice filters from `evalContext`. | ACTIVE | High | Option-heavy fields inside repeats can multiply expression cost. |
| Paginated UI with full data source | `RepeatTable` uses `PaginatedDataTable`, but `RepeatTableDataSource` holds all row instances. | ACTIVE | High | Pagination may reduce visible rows but not build/load memory cost. |
| Whole JSON save on row edit | Repeat row save calls `formInstance.saveFormData()`. | ACTIVE | High | Editing one row serializes and writes the whole form object. |
| Repeat UID not persisted by reducer | `repeat_item_instance.dart` comments out `repeatUid` writeback. | INCOMPLETE | High | Server updates may not be able to match repeat rows reliably after edit. |
| Suspicious data source update predicate | `RepeatTableDataSource.updateItems` uses a self-comparison predicate. | UNKNOWN | Medium | Row updates may be broader or less precise than intended; verify behavior before optimizing. |
| Possible field subscription cleanup issue | `FieldWidget` subscribes to `control.valueChanges`; static scan did not prove cancellation. | UNKNOWN | Medium | Repeated row edit/open cycles may leak listeners if cleanup is wrong. |
| Duplicate edit-status logic | Bootstrapper and `submissionEditStatusProvider` both compute editability. | LEGACY-RISK | Medium | A synced submission may be editable in one layer and disabled in another if logic diverges. |

## Smallest Set To Understand Before Changing Repeat Performance Or Repeat UID Behavior

Treat these as the minimum "do not touch until understood" set for repeat performance or repeat UID work:

- `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart`
- `lib/core/form/builder/form_element_control_builder.dart`
- `lib/core/form/builder/form_element_builder.dart`
- `lib/features/form_submission/application/element/form_instance.dart`
- `lib/features/form_submission/application/element/form_element.dart`
- `lib/features/form_submission/application/element/element_dependency.extension.dart`
- `lib/features/form_submission/application/element/section_instance.dart`
- `lib/features/form_submission/application/element/repeat_instance.dart`
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
- `packages/drun_sdk/lib/database/tables/data_submissions.table.dart`
- `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart`
- `packages/drun_sdk/lib/database/extensions/data_submission.extension.dart`
- `packages/drun_sdk/lib/database/converters/null_aware_map.converter.dart`
- `packages/drun_sdk/lib/core/form/rule/action.dart`
- `packages/drun_sdk/lib/core/form/rule/choice_filter.dart`
- `packages/drun_sdk/lib/core/form/rule/rule_parse_extension.dart`
- `packages/drun_sdk/lib/core/data_instance/form_data_util.dart`
- `packages/drun_sdk/lib/core/data_instance/form_data_aggregator.dart`

## Questions Requiring Runtime Confirmation

1. When a new repeat row is saved, does `repeatUid` appear in `data_instances.formData`, or is it lost because `RepeatItemInstance.reduceValue()` does not write it?
2. When a server-submitted record with repeat rows is edited and re-uploaded, how does the server match repeat rows without a persisted `repeatUid`?
3. Does `submissionEditStatusProvider` always agree with the bootstrapper's local `submissionEditStatus` logic for synced, draft, finalized, and failed records?
4. Does `FieldWidget` correctly cancel `control.valueChanges` subscriptions when fields inside repeat edit screens are disposed?
5. Does `RepeatTableDataSource.updateItems` behave correctly despite the self-comparison predicate?
6. For nested repeats or repeated field names, does `findElementInParentSection` resolve dependencies to the intended row-local field every time?
7. How long does bootstrap take on a real form with 200-300 repeat rows and representative choice filters/calculated fields?
8. Does `PaginatedDataTable` create only visible row widgets, or do row/cell builders still cause expensive traversal across all repeat elements during refresh?
9. Are `repeat_instances` or `data_values` ever touched by sync/runtime code outside the scanned production form path?
10. Are calculated fields expected to work in production forms, given that `CalculatedFieldInstance.evaluate` calculation writeback is commented?

## Next Investigation Step

Run one instrumented manual/runtime pass with a real example form containing repeats:

1. Create a draft with two repeat rows, save, and inspect the exact `formData` JSON for `repeatUid`.
2. Import or use a synced submission with repeat rows, edit one row, save/finalize/upload, and inspect local `formData` plus server response.
3. Record bootstrap time, number of repeat rows, number of field instances, and whether field subscriptions are disposed after row edit navigation.

Do this before any refactor or optimization so the static map can be corrected with runtime facts.
