# Large Repeat Hang And Data-Loss Investigation

Generated: 2026-07-10

Scope: active large-repeat performance and possible unsaved-work loss in the current production form flow. This document builds on:

- `02-form-flow.md`
- `04-state-di-runtime-map.md`
- `05-classification-reconciliation.md`

This is still pre-refactor mapping. No persistence format change, repeat renderer rewrite, expression-engine rewrite, or data model migration is assumed here.

Update 2026-07-23: the retained-control hypothesis in this document is now closed. Dormant repeat rows use one map control and materialize field controls only while edited; the 300-row retained-heap probe fell from about 20.9 MB to 2.6 MB. The eager element/dependency graph, linear rule fan-out, and whole-JSON save remain active considerations. Use `09-production-boundaries-and-work-strategy.md` for the current implementation and acceptance evidence; the older hypothesis rows below are retained as historical investigation evidence.

## Validation Legend

- STATIC-VALIDATED: the code path or bug shape is directly proven by active call sites and implementations.
- STATIC-PARTIAL: the code proves a risk is possible, but runtime traces are still needed to prove magnitude or that it explains the reported production symptom.
- RUNTIME-REQUIRED: static evidence is not enough; needs reproduction, profiling, or real data.

Strict active test: this document only treats paths as core-active when commenting/removing them without replacement would break active form load/render/repeat/edit/save or core data collection. Generated, stale, supporting, or form-looking code is not treated as active by name alone.

## Executive Conclusion

The large-repeat hang is probably not one single issue. Static evidence shows a stack of multiplicative costs:

1. Existing repeat rows are loaded eagerly into `reactive_forms` controls.
2. The app builds a second eager element tree for the same repeat rows.
3. Dependency resolution and evaluation walk the full tree.
4. Row edit/save reduces and writes the whole submission JSON.
5. Whole-form save metrics exist, but concurrent-save guarding is not characterized.
6. Field subscriptions are cancelled, while listener/rebuild volume still scales with mounted fields.
7. Repeat metadata is persisted locally; server round-trip editing remains unvalidated.

The previously proven save-ordering bug is closed. The unresolved performance problem remains the multiplicative combination of eager controls/elements, recursive expression work, whole-JSON reduction/write, and memory pressure on slower devices.

## Ranked Hypotheses With Validation

| Rank | Hypothesis | Validation | Evidence | What is proved | What still needs runtime confirmation |
| --- | --- | --- | --- | --- | --- |
| 1 | Save ordering could lose work when navigation/finalization outran persistence. | RESOLVED for active call sites; production causality remains unknown. | Active form and repeat-row save callers now await `FormInstance.saveFormData()`, which awaits the DAO write. | Navigation/finalization no longer intentionally proceeds before the current save completes. | Concurrent taps and process death during a write remain separate risks. |
| 2 | Opening large repeat submissions is expensive because controls and model rows are built eagerly. | STATIC-VALIDATED. | `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart`; `lib/core/form/builder/form_element_control_builder.dart:51-58`; `lib/core/form/builder/form_element_builder.dart:79-96`; `lib/features/form_submission/application/element/form_instance.dart:40-47`. | Every initial repeat row becomes a `FormGroup` and a `RepeatItemInstance` before the form screen renders. `FormInstance` then builds an element-path map by iterating the whole tree. | Exact row-count threshold where startup becomes unacceptable on target Android devices. Need timings for 50, 100, 200, 300 rows. |
| 3 | Initial and triggered expression evaluation scale across all repeat rows. | STATIC-VALIDATED for traversal; STATIC-PARTIAL for performance magnitude. | `form_flow_bootstrapper_controller.dart`; `lib/features/form_submission/application/element/section_instance.dart`; `lib/features/form_submission/application/element/repeat_section.dart`; `lib/features/form_submission/application/element/form_element.dart`; `lib/core/form/rule/action.dart`; `lib/core/form/rule/choice_filter.dart`. | Root bootstrap calls `resolveDependencies()` and `evaluate()`. Section and repeat evaluation recursively evaluate children/rows. Rule expressions are parsed during evaluation. The current `evaluate()` evaluates each rule once for logging and again for apply/reset. | Which real forms have the riskiest dependency graph. Need counts of rules, dependencies, choice filters, evaluations per keystroke/row save, and total eval time. |
| 4 | Whole-submission JSON save makes one-row edits pay full-form cost. | STATIC-VALIDATED. | `lib/features/form_submission/application/element/form_instance.dart`; `lib/features/form_submission/application/element/section_instance.dart`; `lib/features/form_submission/application/element/repeat_section.dart`; `lib/database/tables/data_submissions.table.dart`; `lib/database/converters/null_aware_map.converter.dart`. | Saving reduces the full form tree, merges it into `formData`, JSON-encodes the whole map, and updates one `data_instances.form_data` column. Repeat row save calls the same whole-submission save. | Actual JSON size and DB write time for real 200-300 row submissions. |
| 5 | Field listener/rebuild volume contributes to row-editor cost. | RESOLVED for leak shape; STATIC-PARTIAL for performance magnitude. | `FieldWidget` returns `subscription.cancel` from hook cleanup. | The previously identified missing-cancel bug is closed. | Count simultaneously mounted listeners and rebuild/evaluation cascades on representative forms. |
| 6 | Repeat metadata can be lost across future server-backed edits. | RESOLVED locally; RUNTIME-REQUIRED for server round trip. | Builder, `RepeatItemInstance`, `RepeatMetadataNormalizer`, `FormInstance.saveFormData()`, and upload compatibility normalization. | Existing IDs are preserved and missing metadata is generated before local save/upload. | Validate a server-submitted nested repeat edit before enabling synced edits in production. |
| 7 | Paginated repeat table reduces visible rows but not load/save/model cost. | STATIC-VALIDATED. | `lib/features/form_submission/presentation/section/repeat_table.widget.dart:68-74`, `:104-144`; `lib/features/form_submission/presentation/section/repeat_table_rows_source.dart:15-23`, `:62-78`, `:209-216`. | `RepeatTableDataSource` stores all repeat items. `rowCount` is the full list. `getRow()` builds visible row cells by walking that row's fields. Pagination does not make bootstrap, dependency resolution, save, or memory lazy. | How many `getRow()` calls happen per update on target Flutter/DataTable behavior. |
| 8 | Repeated dependency lookup can become expensive or resolve ambiguously. | STATIC-PARTIAL. | `lib/features/form_submission/application/element/element_dependency.extension.dart:77-108`. | Dependency resolution searches parent sections first, then falls back to walking the whole tree. This can be costly for unresolved or global dependencies, and risky with repeated field names. | Whether real repeat expressions resolve row-local fields correctly in nested repeats and how often fallback tree walking occurs. |
| 9 | Form scope disposal can discard unsaved in-memory state after failures or process interruption. | STATIC-PARTIAL. | Form state lives in a per-submission GetIt scope and completion/navigation paths drop it after awaited saves. | The known normal-path save race is closed. | Confirm failed-save handling, concurrent taps, Android process death, and unusual back-navigation behavior. |
| 10 | Client memory pressure is likely with 200-300 rows. | STATIC-PARTIAL. | Same evidence as eager control/model build plus `FieldWidget` subscriptions and full tree maps. | The code creates many controls, instances, streams, keys, and subscriptions. Cost scales with rows times fields. | Heap/GC measurements on target devices. |

## Files And Functions To Inspect First

### Save Correctness

- `lib/features/form_submission/presentation/form_submission_screen.widget.dart`
  - `_saveAndShowBottomSheet`
  - `_onSaveForm`
  - `_onCompletionDialogButtonClicked`
  - `backButtonPressed`
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart`
  - `_showEditPanel`
  - `_handleSave`
- `lib/features/form_submission/application/element/form_instance.dart`
  - `saveFormData`
  - `markSubmissionAsFinal`
- `lib/database/dao/data_submissions_dao.dart`
  - `updateData`
  - `markFinal`

Why first: this is the only area where static evidence already proves a correctness bug shape. It can explain lost work even if performance remains bad.

### Large Repeat Performance

- `lib/core/form/builder/form_element_control_builder.dart`
  - `createRepeatFormArray`
  - `createSectionFormGroup`
- `lib/core/form/builder/form_element_builder.dart`
  - `buildRepeatSection`
  - `buildRepeatItem`
- `lib/features/form_submission/application/element/section_instance.dart`
  - `resolveDependencies`
  - `evaluate`
  - `reduceValue`
- `lib/features/form_submission/application/element/repeat_section.dart`
  - `resolveDependencies`
  - `evaluate`
  - `reduceValue`
- `lib/features/form_submission/application/element/form_element.dart`
  - `evaluate`
  - `resolveDependencies`
- `lib/features/form_submission/application/element/element_dependency.extension.dart`
  - `evalContext`
  - `notifySubscribers`
  - `findElementInParentSection`

Why second: this proves where the hang likely comes from, but the safe fix is not obvious without trace data.

### Repeat Metadata

- `lib/features/form_submission/application/element/repeat_item_instance.dart`
  - `uid`
  - `setUid`
  - `reduceValue`
- `lib/core/form/builder/form_element_builder.dart`
  - `buildRepeatItem`
- `lib/features/form_submission/presentation/section/edit_row_screen.dart`
  - `_onTryToClose`
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart`
  - `_onTryToClose`
- `lib/database/extensions/data_submission.extension.dart`
  - `toUpload`

Why separate: local repeat metadata is implemented. Server round-trip editing remains a product acceptance check and must not be conflated with large-repeat performance work.

## Runtime Measurements Needed

Use a real or generated copy of the large activity form with 50, 100, 200, and 300 repeat rows.

| Measurement | Confirms/rejects | Where to instrument |
| --- | --- | --- |
| Bootstrap phase timings: draft/template load, control build, element build, dependency resolve, initial evaluate, `FormInstance` map build, first frame. | Whether hang is mainly open-time eager build/evaluate. | `FormFlowBootstrapperController._buildFormInstance`, `FormInstance` constructor. |
| Counts: repeat sections, rows per repeat, fields per row, total controls, total element instances, total rules, total dependency edges. | Whether cost matches row-count growth. | Builders and dependency resolution. |
| Evaluation counters: number of `evaluate()` calls, rule evaluations, choice-filter evaluations, fallback tree walks. | Whether expression-heavy forms are worse because evaluation cascades. | `FormElementInstance.evaluate`, `ChoiceFilter.evaluate`, `findElementInParentSection`. |
| Save timings: reduce time, JSON byte length, JSON encode time, DB update time, total save time. | Whether row edits block on whole-form JSON persistence. | `FormInstance.saveFormData`, `NullAwareMapConverter.requireToSql`, `DataInstancesDao.updateData`. |
| Save ordering trace: save-start, save-end, save-error, repeated taps, row-screen pop, bottom-sheet open, mark-final, drop-scope. | Whether failed writes or concurrent save attempts still create an unsafe lifecycle. | Form screen and repeat row save handlers. |
| Subscription count per field/control after opening and closing row edit 10-20 times. | Whether cancellation stays balanced and how listener volume scales. | `FieldWidget` effect/dispose trace. |
| Repeat metadata trace across server round trip: row `_id` before upload, stored server JSON, reopened row `_id`, edited upload payload. | Whether future synced edits preserve stable identity. | `RepeatMetadataNormalizer`, `saveFormData`, DAO upload, server submission path. |
| Memory/GC snapshots before open, after open, after editing rows, after close/reopen. | Whether memory pressure contributes to hangs or process death. | Flutter DevTools/profile build on device. |

## Minimal Safety Improvements

These are not structural optimizations. They are guardrails to reduce data loss while collecting proof.

1. Await every active `saveFormData()` call before row close, bottom sheet display, finalization, navigation pop, or scope drop.
2. Add an in-flight save guard so concurrent taps or row saves cannot run overlapping whole-submission writes.
3. Return or surface save failures and block `dropScope()`/`markFinal()` when the save fails.
4. Add timing and size traces around save reduction, JSON encoding, and DB update.
5. Log repeat row count and JSON size at save time.
6. Do not change the persistence format in this PR.
7. Do not change repeat metadata in this PR unless a separate runtime test proves the server contract and expected JSON shape.

## First PR Slice Evaluation

### Closed Safety Slices

- Active form and repeat-row save callers await the database write.
- `FormInstance.saveFormData()` emits debug-only phase timings, repeat-row count, and JSON size.
- Field widget subscriptions cancel on disposal.
- Repeat metadata is generated/preserved before local save and upload.

These changes are safety prerequisites, not a claim that large-repeat sluggishness is fixed. There is no proven concurrent-save guard yet.

## Runtime Confirmation Questions

1. Does a row edit save complete before the edit screen pops in current production behavior?
2. Can `MarkAsFinal` run before the previous save write has finished?
3. After a hang or forced process kill during/after save, is the last edited row present in `data_instances.formData`?
4. How long does `formSection.value` take for 50, 100, 200, and 300 repeat rows?
5. How large is the encoded `formData` JSON at those row counts?
6. How many `evaluate()` calls happen when editing one field inside a repeat row?
7. Does opening and closing repeat row edit screens increase active `valueChanges` listeners?
8. Does a server-submitted repeat row keep its original `_id` after load, save, reopen, and upload?
9. Are forms with more rules slower because of rule count, dependency fallback walks, choice filters, or save size?
10. On target Android devices, does memory rise enough at 200-300 rows to trigger process death or OS pressure?

## Carry-Forward Risk Map

| Area | Current label | Carry-forward action |
| --- | --- | --- |
| Awaited save calls | RESOLVED | Keep the ordering invariant; characterize concurrent taps and failed writes separately. |
| Eager repeat control/model build | STATIC-VALIDATED | Profile after save guard; likely second performance PR area. |
| Whole-submission JSON save | STATIC-VALIDATED | Measure first; structural changes later only if approved. |
| Expression/repeat evaluation cost | STATIC-PARTIAL | Add counters/timings before changing semantics. |
| Field subscription cleanup | RESOLVED for cancellation | Measure listener/rebuild volume rather than assuming a leak. |
| Repeat metadata persistence | RESOLVED locally | Run a server round-trip test before enabling synced edits. |
| Memory pressure | STATIC-PARTIAL | Needs profile-mode device measurements. |

## Next Investigation Step

Use the existing harness and save metrics with representative nested/expression-heavy forms, then choose the next slice from measured phase cost:

1. If bootstrap dominates, investigate lazy repeat control/model construction.
2. If evaluation dominates, investigate dependency resolution and expression evaluation counters.
3. If save dominates, investigate save reduction/JSON encode/DB write strategy.
4. Treat server round-trip repeat identity as a separate synced-edit acceptance check, not a performance fix.
