# Large Repeat Hang And Data-Loss Investigation

Generated: 2026-07-10

Scope: active large-repeat performance and possible unsaved-work loss in the current production form flow. This document builds on:

- `02-form-flow.md`
- `04-state-di-runtime-map.md`
- `05-classification-reconciliation.md`

This is still pre-refactor mapping. No persistence format change, repeat renderer rewrite, expression-engine rewrite, or data model migration is assumed here.

Update 2026-07-21: rows that discuss repeat UID persistence reflect the original mobile-only scan. Backend validation later proved the active server contract is repeat metadata with `_id`, `_index`, `_parentId`, and `_submissionUid`; see `07-repeat-uid-contract.md`.

## Validation Legend

- STATIC-VALIDATED: the code path or bug shape is directly proven by active call sites and implementations.
- STATIC-PARTIAL: the code proves a risk is possible, but runtime traces are still needed to prove magnitude or that it explains the reported production symptom.
- RUNTIME-REQUIRED: static evidence is not enough; needs reproduction, profiling, or real data.
- NOT-FIRST-PR: valid risk, but not a safe first slice because it changes behavior or data semantics too broadly.

Strict active test: this document only treats paths as core-active when commenting/removing them without replacement would break active form load/render/repeat/edit/save or core data collection. Generated, stale, supporting, or form-looking code is not treated as active by name alone.

## Executive Conclusion

The large-repeat hang is probably not one single issue. Static evidence shows a stack of multiplicative costs:

1. Existing repeat rows are loaded eagerly into `reactive_forms` controls.
2. The app builds a second eager element tree for the same repeat rows.
3. Dependency resolution and evaluation walk the full tree.
4. Row edit/save reduces and writes the whole submission JSON.
5. Some active save calls are not awaited.
6. Field value subscriptions appear not to be cancelled.
7. Repeat row UIDs are read and sometimes set, but not written back by the reducer.

The strongest immediate correctness problem is not rendering performance. It is save lifecycle correctness: active UI paths fire `saveFormData()` without awaiting the database write, then can continue to completion/finalization/scope disposal. That is a small, provable bug surface and a better first PR than speculative performance tuning.

## Ranked Hypotheses With Validation

| Rank | Hypothesis | Validation | Evidence | What is proved | What still needs runtime confirmation |
| --- | --- | --- | --- | --- | --- |
| 1 | Active save paths can race navigation/finalization/scope disposal because saves are not awaited. | STATIC-VALIDATED for bug shape; STATIC-PARTIAL for production data-loss causality. | `lib/features/form_submission/presentation/form_submission_screen.widget.dart:189-212`, `:249-264`; `lib/features/form_submission/presentation/section/repeat_table.widget.dart:198-206`, `:262-270`; `lib/features/form_submission/application/element/form_instance.dart:85-103`; `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart:198-218`. | `_onSaveForm()` returns before `FormInstance.saveFormData()` finishes. Repeat row save also starts the async save without awaiting it. `dropScope()` and `markFinal()` can run after a non-awaited save has been started. | Whether reported erased work happened through this race, a crash during the write, or both. Need ordered logs: save-start, save-end, mark-final, navigator-pop, drop-scope. |
| 2 | Opening large repeat submissions is expensive because controls and model rows are built eagerly. | STATIC-VALIDATED. | `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:103-116`; `lib/core/form/builder/form_element_control_builder.dart:51-58`; `lib/core/form/builder/form_element_builder.dart:79-96`; `lib/features/form_submission/application/element/form_instance.dart:40-47`. | Every initial repeat row becomes a `FormGroup` and a `RepeatItemInstance` before the form screen renders. `FormInstance` then builds an element-path map by iterating the whole tree. | Exact row-count threshold where startup becomes unacceptable on target Android devices. Need timings for 50, 100, 200, 300 rows. |
| 3 | Initial and triggered expression evaluation scale across all repeat rows. | STATIC-VALIDATED for traversal; STATIC-PARTIAL for performance magnitude. | `form_flow_bootstrapper_vm.dart:115-116`; `lib/features/form_submission/application/element/section_instance.dart:49-75`; `lib/features/form_submission/application/element/repeat_instance.dart:52-78`; `lib/features/form_submission/application/element/form_element.dart:243-288`; `packages/drun_sdk/lib/core/form/rule/action.dart:72-93`; `packages/drun_sdk/lib/core/form/rule/choice_filter.dart:18-27`. | Root bootstrap calls `resolveDependencies()` and `evaluate()`. Section and repeat evaluation recursively evaluate children/rows. Rule expressions are parsed during evaluation. The current `evaluate()` evaluates each rule once for logging and again for apply/reset. | Which real forms have the riskiest dependency graph. Need counts of rules, dependencies, choice filters, evaluations per keystroke/row save, and total eval time. |
| 4 | Whole-submission JSON save makes one-row edits pay full-form cost. | STATIC-VALIDATED. | `lib/features/form_submission/application/element/form_instance.dart:85-103`; `lib/features/form_submission/application/element/section_instance.dart:129-138`; `lib/features/form_submission/application/element/repeat_instance.dart:101-106`; `packages/drun_sdk/lib/database/tables/data_submissions.table.dart:39-40`; `packages/drun_sdk/lib/database/converters/null_aware_map.converter.dart:16-17`. | Saving reduces the full form tree, merges it into `formData`, JSON-encodes the whole map, and updates one `data_instances.form_data` column. Repeat row save calls the same whole-submission save. | Actual JSON size and DB write time for real 200-300 row submissions. |
| 5 | Field value subscriptions are likely leaked on rebuild/dispose. | STATIC-VALIDATED for missing cancel call; STATIC-PARTIAL for symptom magnitude. | `lib/features/form_submission/presentation/field/field.widget.dart:28-39`. | `useEffect` listens to `control.valueChanges`; disposer returns `() => subscription`, which does not call `subscription.cancel()`. In a `void Function()` disposer, the returned object is ignored. | How many stale subscriptions accumulate in normal row edit/reopen flows and whether they trigger duplicated `element.updateValue()`/evaluation work. |
| 6 | Repeat row UID persistence is incomplete and can drop existing row identity. | STATIC-VALIDATED for current reducer behavior; RUNTIME-REQUIRED for server consequence. | `lib/core/form/builder/form_element_builder.dart:65-69`; `lib/features/form_submission/application/element/repeat_item_instance.dart:21-25`, `:43-55`; `lib/features/form_submission/presentation/section/edit_row_screen.dart:183-185`; `lib/features/form_submission/presentation/section/repeat_table.widget.dart:327-329`; `lib/features/form_submission/application/element/form_instance.dart:85-103`. | Existing `repeatUid` is read from row JSON. Some close-confirm paths can set a new UID. But `RepeatItemInstance.reduceValue()` has `repeatUid` writeback commented out, and `createSectionFormGroup()` only builds controls from template children. Saving replaces the repeat list with reduced row maps, so `repeatUid` is not preserved by the active reducer. | Server behavior when a synced submission with repeat rows is edited and re-uploaded without stable row UIDs. Needs real payload/reopen/upload test. |
| 7 | Paginated repeat table reduces visible rows but not load/save/model cost. | STATIC-VALIDATED. | `lib/features/form_submission/presentation/section/repeat_table.widget.dart:68-74`, `:104-144`; `lib/features/form_submission/presentation/section/repeat_table_rows_source.dart:15-23`, `:62-78`, `:209-216`. | `RepeatTableDataSource` stores all repeat items. `rowCount` is the full list. `getRow()` builds visible row cells by walking that row's fields. Pagination does not make bootstrap, dependency resolution, save, or memory lazy. | How many `getRow()` calls happen per update on target Flutter/DataTable behavior. |
| 8 | Repeated dependency lookup can become expensive or resolve ambiguously. | STATIC-PARTIAL. | `lib/features/form_submission/application/element/element_dependency.extension.dart:77-108`. | Dependency resolution searches parent sections first, then falls back to walking the whole tree. This can be costly for unresolved or global dependencies, and risky with repeated field names. | Whether real repeat expressions resolve row-local fields correctly in nested repeats and how often fallback tree walking occurs. |
| 9 | Form scope disposal can destroy the only complete in-memory state while save is still in flight. | STATIC-PARTIAL. | `form_flow_bootstrapper_vm.dart:57-69`, `:80-83`; `form_submission_screen.widget.dart:196-201`, `:249-264`; `04-state-di-runtime-map.md` form scope section. | Form state lives in a per-submission GetIt scope. Completion paths drop that scope. Combined with unawaited saves, this is a credible unsaved-work loss path. | Actual GetIt disposal timing and whether `FormInstance` remains reachable after route pop/drop-scope in current navigation stack. |
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
- `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart`
  - `updateData`
  - `markFinal`

Why first: this is the only area where static evidence already proves a correctness bug shape. It can explain lost work even if performance remains bad.

### Large Repeat Performance

- `lib/core/form/builder/form_element_control_builder.dart`
  - `createRepeatFormArray`
  - `createSectionFormGroup`
- `lib/core/form/builder/form_element_builder.dart`
  - `buildRepeatInstance`
  - `buildRepeatItem`
- `lib/features/form_submission/application/element/section_instance.dart`
  - `resolveDependencies`
  - `evaluate`
  - `reduceValue`
- `lib/features/form_submission/application/element/repeat_instance.dart`
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
- `packages/drun_sdk/lib/database/extensions/data_submission.extension.dart`
  - `toUpload`

Why separate: writing backend-compatible repeat metadata changes saved JSON semantics and may affect server update matching. It should not be bundled into the first save-safety PR.

## Runtime Measurements Needed

Use a real or generated copy of the large activity form with 50, 100, 200, and 300 repeat rows.

| Measurement | Confirms/rejects | Where to instrument |
| --- | --- | --- |
| Bootstrap phase timings: draft/template load, control build, element build, dependency resolve, initial evaluate, `FormInstance` map build, first frame. | Whether hang is mainly open-time eager build/evaluate. | `FormFlowBootstrapperVm._formInstance`, `FormInstance` constructor. |
| Counts: repeat sections, rows per repeat, fields per row, total controls, total element instances, total rules, total dependency edges. | Whether cost matches row-count growth. | Builders and dependency resolution. |
| Evaluation counters: number of `evaluate()` calls, rule evaluations, choice-filter evaluations, fallback tree walks. | Whether expression-heavy forms are worse because evaluation cascades. | `FormElementInstance.evaluate`, `ChoiceFilter.evaluate`, `findElementInParentSection`. |
| Save timings: reduce time, JSON byte length, JSON encode time, DB update time, total save time. | Whether row edits block on whole-form JSON persistence. | `FormInstance.saveFormData`, `NullAwareMapConverter.requireToSql`, `DataInstancesDao.updateData`. |
| Save ordering trace: save-start, save-end, save-error, row-screen pop, bottom-sheet open, mark-final, drop-scope. | Whether unawaited save races exist in real interaction. | Form screen and repeat row save handlers. |
| Subscription count per field/control after opening and closing row edit 10-20 times. | Whether `FieldWidget` leaks listeners. | `FieldWidget` effect/dispose trace. |
| Repeat metadata trace: row `_id` before save, saved DB JSON, reopened row `_id`, upload payload. | Whether repeat identity metadata is dropped and whether server update sees stable row identity. | `RepeatItemInstance.reduceValue`, `saveFormData`, `toUpload`. |
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

### Candidate PR

Title: `Guard and trace submission saves`

Primary files:

- `lib/features/form_submission/presentation/form_submission_screen.widget.dart`
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart`
- `lib/features/form_submission/application/element/form_instance.dart`

Possible supporting file only if needed:

- a small trace helper, or existing logger calls directly if a helper would add noise.

### Why This Is Not A Scam Slice

This PR fixes a statically proven correctness issue: active save callers do not await the asynchronous DB write. That is independently valuable even if large-repeat rendering remains slow.

It is also measurable:

- Before/after ordered logs can show whether bottom sheet/finalization/scope disposal happens before or after save completion.
- Save duration and JSON size logs give the first real numbers for 50/100/200/300 repeat rows.
- Manual reproduction can verify that repeated save taps do not create overlapping writes.
- Reopening the submission after save can confirm the latest row count survived.

It is small and reversible:

- No data schema change.
- No server contract change.
- No repeat rendering rewrite.
- No expression dependency rewrite.
- No migration.

### Minimum Acceptance Criteria

The PR should be rejected as too weak if it only adds logs. It must include the save lifecycle fix.

The PR should be rejected as too broad if it includes repeat virtualization, dependency graph rewrites, UID persistence, or JSON format changes.

Done means:

1. All active save call sites await save completion.
2. A save-in-flight guard prevents concurrent whole-form writes for the same `FormInstance`.
3. `markFinal` and `dropScope` are not reached after a failed save.
4. Trace logs include row count, reduce time, DB update time, and total save time.
5. A manual test path is documented for a 50-row and 200-row submission.

### Why Not Start With Other Fixes

| Alternative first PR | Decision | Reason |
| --- | --- | --- |
| Repeat rendering virtualization/lazy row model | NOT-FIRST-PR | Probably necessary later, but too structural before measurements. It risks changing UI behavior without first proving the slow phase. |
| Expression engine caching/rewrite | NOT-FIRST-PR | The active evaluation path is risky, but changing dependency semantics before traces could break form rules. |
| Persist repeat metadata in saved JSON | NOT-FIRST-PR | Static evidence says persistence is incomplete, but this changes saved JSON and server update semantics. Needs a focused backend-contract runtime test first. |
| Replace whole JSON persistence | NOT-FIRST-PR | Too large and explicitly outside current constraints. |
| Instrumentation-only PR | Reject | It measures but does not fix the proven unawaited-save race. |
| Save lifecycle guard plus traces | Accept | Fixes a real correctness bug and gives the minimum measurements needed for the next performance PR. |

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
| Unawaited save calls | STATIC-VALIDATED | First PR should fix and trace. |
| Eager repeat control/model build | STATIC-VALIDATED | Profile after save guard; likely second performance PR area. |
| Whole-submission JSON save | STATIC-VALIDATED | Measure first; structural changes later only if approved. |
| Expression/repeat evaluation cost | STATIC-PARTIAL | Add counters/timings before changing semantics. |
| Field subscription cleanup | STATIC-VALIDATED for missing cancel | Candidate small correctness fix, but can be separate from save guard if it risks widget lifecycle changes. |
| Repeat metadata persistence | STATIC-VALIDATED for missing reducer writeback | Dedicated runtime test and server-contract decision before code change. |
| Memory pressure | STATIC-PARTIAL | Needs profile-mode device measurements. |

## Next Investigation Step

Do the first PR as a safety-and-measurement slice only if it includes the awaited-save fix. After that PR, run a controlled large-repeat test and use the trace output to decide the next slice:

1. If bootstrap dominates, investigate lazy repeat control/model construction.
2. If evaluation dominates, investigate dependency resolution and expression evaluation counters.
3. If save dominates, investigate save reduction/JSON encode/DB write strategy.
4. If repeat identity loss is reproduced, plan a separate repeat metadata contract PR with server payload examples.
