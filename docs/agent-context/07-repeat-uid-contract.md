# Repeat UID Behavior Contract

Generated: 2026-07-10

Scope: define the intended behavior for repeat item UIDs before implementing anything. This document uses active code paths as authority and treats earlier docs/comments/table names as evidence only.

Related maps:

- `02-form-flow.md`
- `05-classification-reconciliation.md`
- `06-large-repeat-hang-data-loss.md`

## Proposed Contract

Repeat item UID behavior should be:

1. Each repeat item has a client-generated `repeatUid`.
2. New repeat rows created on the client receive a `repeatUid` before they are persisted into submission JSON.
3. Existing repeat rows loaded for edit preserve their existing `repeatUid`.
4. A non-null repeat item UID is immutable in memory; later edits must not overwrite it.
5. Submission save/upload uses the `repeatUid` stored inside the whole `formData` JSON.
6. The implementation must not depend on inactive-looking `repeat_instances`, `data_values`, or old form-state/provider paths.
7. Missing `repeatUid` on legacy/existing row JSON should be treated as "needs client UID assignment on next save", not as a reason to use row index as identity.

This contract keeps repeat identity local to the active whole-submission JSON flow. It does not introduce normalized repeat-row persistence.

## Current Active Flow

| Question | Current code path | Evidence | Current behavior |
| --- | --- | --- | --- |
| Where repeat rows are loaded for editing | `FormFlowBootstrapperVm._formInstance` reads `DataInstance.formData`, builds controls, then builds element instances. | `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart:92-116` | Existing saved JSON is loaded all at once. Repeat rows are not loaded from a separate repeat table. |
| Where repeat controls are loaded | `FormElementControlBuilder.createRepeatFormArray` maps each existing repeat row JSON item into a `FormGroup`. | `lib/core/form/builder/form_element_control_builder.dart:51-58` | The reactive controls are built from template children. `repeatUid` is not a template child, so it is not represented as a form control. |
| Where repeat row models are loaded | `FormElementBuilder.buildRepeatInstance` maps each row into `buildRepeatItem`; `buildRepeatItem` passes `initialFormValue?['repeatUid']` into `RepeatItemInstance`. | `lib/core/form/builder/form_element_builder.dart:60-96` | Existing `repeatUid` can be preserved in the in-memory repeat item model if it exists in row JSON. |
| Where new repeat rows are created | `RepeatTable` add action calls `FormInstance.onAddRepeatedItem`; save-and-add-another also calls `onAddRepeatedItem`. | `lib/features/form_submission/presentation/section/repeat_table.widget.dart:112-120`, `:294-297`; `lib/features/form_submission/application/element/form_instance.dart:134-150` | New rows are created with no `initialFormValue`, so `RepeatItemInstance.uid` starts as null. |
| Where repeat rows are edited | `RepeatTable._showEditPanel` navigates to `EditRowScreen` using the existing `RepeatItemInstance`. | `lib/features/form_submission/presentation/section/repeat_table.widget.dart:177-211`; `lib/features/form_submission/presentation/section/edit_row_screen.dart:17-32` | Edit uses the current row model/control. Existing row UID is available through `RepeatItemInstance.uid` if it was loaded. |
| Where UID is currently generated | Close-confirm save paths call `repeatItem.setUid(CodeGenerator.generateUid())` when `uid == null`. | `lib/features/form_submission/presentation/section/edit_row_screen.dart:161-185`; `lib/features/form_submission/presentation/section/repeat_table.widget.dart:304-329` | UID generation is UI-path dependent. Normal row save buttons do not obviously set UID before `saveFormData()`. |
| Where UID overwrite is prevented | `RepeatItemInstance.setUid` throws if `_uid` is already non-null. | `lib/features/form_submission/application/element/repeat_item_instance.dart:21-25` | In-memory overwrite protection exists, but only for callers using `setUid`. |
| Where repeat rows are serialized | `FormInstance.saveFormData` reads `formSection.value`; `Section.reduceValue`, `RepeatSection.reduceValue`, and `RepeatItemInstance.reduceValue` produce the nested map/list. | `lib/features/form_submission/application/element/form_instance.dart:85-103`; `lib/features/form_submission/application/element/section_instance.dart:129-138`; `lib/features/form_submission/application/element/repeat_instance.dart:101-106`; `lib/features/form_submission/application/element/repeat_item_instance.dart:43-55` | `RepeatItemInstance.reduceValue` currently does not write `repeatUid`; the line that would write it is commented out. |
| Where saved JSON is persisted | `DataInstancesDao.updateData` writes `formData` into `data_instances.form_data`. | `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart:198-208` | The active persistence unit is one whole submission JSON object. |
| Where upload payload reads repeat rows | `DataSubmissionUploadExt.toUpload` includes `formData` directly. | `packages/drun_sdk/lib/database/extensions/data_submission.extension.dart:3-23`; `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart:68` | Upload uses whatever repeat row JSON was saved. It does not add repeat UIDs later. |

## Current New Submission Vs Edit Behavior

| Flow | Current behavior | Contract gap |
| --- | --- | --- |
| New submission, new repeat row, normal row save | Row is created with `uid == null`; active row save calls `formInstance.saveFormData()` but does not set UID first. | The saved row can be missing `repeatUid`. |
| New submission, new repeat row, close-confirm save | `_onTryToClose` can set a UID before closing if user chooses save-and-close from the warning dialog. | UID assignment depends on a specific close path, not the canonical save path. |
| Existing draft/synced submission, row has `repeatUid` in JSON | `buildRepeatItem` reads it into `RepeatItemInstance.uid`; `setUid` would reject overwrite. | The next save can still drop it because `reduceValue` does not serialize it. |
| Existing draft/synced submission, row lacks `repeatUid` in JSON | Row loads with `uid == null`; close paths treat it as new. | Legacy rows need UID assignment on next save, but the app should not treat row index as stable identity. |
| Upload after edit | Upload sends saved `formData`. | If save dropped UID, upload cannot recover it. |

## Active/Inert Boundary

UID implementation should stay in the active whole-JSON path:

- `RepeatItemInstance`
- `FormElementBuilder`
- `FormInstance.saveFormData`
- `DataInstancesDao.updateData`
- `DataSubmissionUploadExt.toUpload`

Do not base the UID contract on these inactive or legacy-risk paths unless a later runtime pass proves they are active:

- `packages/drun_sdk/lib/database/tables/repeat_instances.table.dart`
- `packages/drun_sdk/lib/database/dao/repeat_instances_dao.dart`
- `packages/drun_sdk/lib/datasource/remote_data_sources/repeat_instance_datasource.dart`
- `packages/drun_sdk/lib/database/tables/data_values.table.dart` as capture storage
- `lib/core/element_instance/form_state.provider.dart`
- `lib/features/form_submission/application/form_instance.provider.dart`
- `lib/core/form/data/form_repository_impl.dart`

## Impacted Files

Must understand before implementation:

- `lib/features/form_submission/application/element/repeat_item_instance.dart`
- `lib/core/form/builder/form_element_builder.dart`
- `lib/features/form_submission/application/element/repeat_instance.dart`
- `lib/features/form_submission/application/element/section_instance.dart`
- `lib/features/form_submission/application/element/form_instance.dart`
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart`
- `lib/features/form_submission/presentation/section/edit_row_screen.dart`
- `packages/drun_sdk/lib/database/dao/data_submissions_dao.dart`
- `packages/drun_sdk/lib/database/extensions/data_submission.extension.dart`

Likely test/smoke support:

- active example forms under `example/`
- any existing form submission tests if present
- a manual DB inspection path for `data_instances.form_data`

## Minimal Implementation Plan

Do not implement in the docs pass. Proposed smallest code change later:

1. Add an explicit `ensureUid()` method to `RepeatItemInstance`.
   - If `_uid` is null, assign `CodeGenerator.generateUid()`.
   - If `_uid` is non-null, return it unchanged.
2. Make `RepeatItemInstance.reduceValue()` serialize `repeatUid`.
   - Use `map['repeatUid'] = ensureUid();`
   - Keep existing field serialization unchanged.
3. Keep `setUid` immutability behavior.
   - It should still throw if callers try to overwrite an existing UID.
4. Avoid moving UID generation into `onAddRepeatedItem` unless the close-without-saving UX is adjusted.
   - Current close-warning logic uses `uid == null` to identify unsaved new rows.
   - Generating UID at add time would accidentally make new unsaved rows look existing.
5. Leave inactive repeat/data-value tables untouched.
6. After this contract is implemented, consider whether UI close-confirm `setUid(...)` calls are redundant, but do not remove them in the same minimal change unless tests prove the flow is unchanged.

Why this is minimal:

- Existing rows keep their loaded UID because `ensureUid()` uses null-coalescing assignment.
- New rows get a UID at the point they are serialized for actual save.
- Saved JSON gains `repeatUid` in the same active whole-submission persistence path.
- No DB schema change is required.
- No server upload code changes are required if server already consumes `formData`.

## Acceptance Criteria

Behavioral:

1. A newly added repeat row saved through the normal row save button has `repeatUid` in `data_instances.form_data`.
2. A newly added repeat row saved through save-and-add-another has `repeatUid` in `data_instances.form_data`.
3. An existing repeat row loaded with `repeatUid` keeps the exact same UID after edit/save/reopen.
4. An existing repeat row loaded without `repeatUid` receives one on next save.
5. Editing an existing row never replaces a non-null `repeatUid`.
6. Upload payload includes repeat rows with the saved `repeatUid` because `toUpload()` sends `formData`.
7. No `repeat_instances` or `data_values` capture path is introduced.

Code-level:

1. `RepeatItemInstance.reduceValue()` includes `repeatUid`.
2. UID assignment is centralized in the repeat item model, not scattered through UI save buttons.
3. Existing `setUid` overwrite protection remains.
4. The change is independent of the await-save fix, although the await-save fix should land first for save correctness.

Smoke checks:

1. Create a new submission with one repeat row, save, reopen, confirm `repeatUid` exists and is stable.
2. Add two repeat rows, save-and-add-another, reopen, confirm each row has a distinct `repeatUid`.
3. Edit a saved repeat row, save, reopen, confirm UID did not change.
4. Import or seed a submission with a repeat row containing `repeatUid`, edit it, save, inspect DB JSON, confirm same UID.
5. Seed a legacy row without `repeatUid`, save, inspect DB JSON, confirm a UID was added.
6. Build upload payload for a finalized submission and confirm nested repeat rows include `repeatUid`.

## Ordering With Other Work

Recommended order:

1. Tooling baseline on `develop`.
2. Docs PR containing this contract.
3. `fix/await-form-save` PR.
4. Repeat UID implementation PR.
5. Large-repeat performance measurement/refactor PRs.

Reason: UID persistence depends on save correctness. If saves can still race navigation or scope disposal, UID behavior tests may produce misleading failures.
