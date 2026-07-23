# Repeat Metadata Contract

Generated: 2026-07-10
Updated: 2026-07-22

Scope: define and record the implemented repeat row identity contract. This document supersedes the earlier `repeatUid`-only assumption after validating the backend submission path.

Related maps:

- `02-form-flow.md`
- `05-classification-reconciliation.md`
- `06-large-repeat-hang-data-loss.md`

## Backend-Validated Contract

Repeat rows in mobile `formData` should use the backend V1 shape:

```json
{
  "_id": "26-char ULID",
  "_index": 1,
  "_parentId": "submission uid for top-level repeats, parent repeat _id for nested repeats",
  "_submissionUid": "submission uid"
}
```

Rules:

1. New repeat rows get a client-generated `_id`.
2. Existing `_id` values are preserved and must not be overwritten during edits.
3. Legacy local `repeatUid` may be used as a fallback when `_id` is missing, but new saves should write `_id`.
4. `_index` is 1-based repeat creation/order index. Preserve existing `_index` when present; otherwise derive it from current row order.
5. `_parentId` is the submission UID for top-level repeats and the parent repeat row `_id` for nested repeats.
6. `_submissionUid` is the owning submission UID.
7. The implementation must not recreate the removed normalized repeat/data-value persistence path or depend on old form-state/provider paths.

Use ULID, not UUIDv7, for the first mobile implementation. The backend generates repeat IDs with `CodeGenerator.nextUlid()`, and analytics `events.event_id` / `parent_event_id` columns are `varchar(26)`. UUIDv7 strings are 36 characters and can break that path.

## Backend Evidence

Active upload/save path:

```text
DataSubmissionResource
-> DataSubmissionV1ServiceImpl.upsertAll
-> preProcess
-> MigrationRepeatIdGenerator.generateMissingIdsForMigration
-> CompositeSubmissionValidator
-> DataSubmissionService.upsertAll
-> data_submission.form_data JSONB
-> outbox
-> ETL
```

Key evidence:

- `/home/hamza/datarun/data-run-api/src/main/java/org/nmcpye/datarun/web/rest/v1/datasubmission/DataSubmissionResource.java` handles `POST /dataSubmission` and `/bulk`.
- `/home/hamza/datarun/data-run-api/src/main/java/org/nmcpye/datarun/web/rest/v1/datasubmission/service/DataSubmissionV1ServiceImpl.java` runs `MigrationRepeatIdGenerator.generateMissingIdsForMigration(...)` before validation/upsert.
- `MigrationRepeatIdGenerator` recognizes existing `_id` or legacy `_uid`, not mobile `repeatUid`.
- `MigrationRepeatIdGenerator` fills missing `_id`, `_parentId`, `_submissionUid`, and `_index`.
- `DefaultDataSubmissionService.upsertAll(...)` persists the whole JSON into `data_submission.form_data`; it does not write normalized repeat tables.
- `TransformServiceRobust` reads repeat instance identity from nearest repeat row `_id` and repeat order from `_index`.
- `TransformServiceV2` uses repeat instance IDs as event IDs for repeat rows.
- `analytics.events.event_id` and `parent_event_id` are `varchar(26)`, matching backend ULID length.

Current backend behavior remains compatible with older mobile payloads because it generates missing repeat metadata before save. Mobile now also generates and persists compatible metadata before local save/upload so later edit/update behavior can preserve row identity.

## Current Mobile Behavior

| Area | Current code path | Behavior |
| --- | --- | --- |
| Load repeat row model | `lib/core/form/builder/form_element_builder.dart` | Reads `_id`, with `_uid` and `repeatUid` as compatibility fallbacks, into `RepeatItemInstance.uid`. |
| New repeat row save path | `lib/features/form_submission/application/element/repeat_item_instance.dart`; `lib/features/form_submission/application/element/form_instance.dart` | `RepeatItemInstance.reduceValue()` assigns a 26-character ULID only when the row has no existing ID; whole-form normalization completes the metadata before persistence. Navigation does not create or overwrite row identity. |
| Save serialization | `lib/features/form_submission/application/element/repeat_item_instance.dart`, `form_instance.dart` | Row reduction writes `_id`; whole-form normalization supplies/preserves `_index`, `_parentId`, and `_submissionUid` before local persistence. |
| Upload | `lib/database/dao/data_submissions_dao.dart`, `database/extensions/data_submission.extension.dart` | Upload normalizes legacy local JSON, persists compatibility additions, then sends the saved whole `formData`. |

`test/dev/repeat_metadata_normalizer_test.dart` characterizes new IDs, legacy fallback, nesting metadata, and idempotency. A production server round-trip edit remains required before synced editing is treated as validated product behavior.

## Active/Inert Boundary

Implementation should stay in the active whole-JSON path:

- `lib/features/form_submission/application/element/repeat_item_instance.dart`
- `lib/core/form/builder/form_element_builder.dart`
- `lib/features/form_submission/application/element/repeat_section.dart`
- `lib/features/form_submission/application/element/form_instance.dart`
- `lib/database/dao/data_submissions_dao.dart`
- `lib/database/extensions/data_submission.extension.dart`

Do not base this work on these inactive or legacy-risk paths unless a later runtime pass proves they are active:


The old app-side `FormRepositoryImpl`/`FormValueStore` path was removed after it
was proven unreachable from production form loading and saving.

## Implemented Slice

Slice name:

```text
fix: write backend-compatible repeat metadata
```

Goal achieved on `develop`: generate and preserve backend-compatible repeat metadata in mobile `formData` without a DB schema change or repeat-rendering refactor.

Scope:

1. Preserve existing row `_id`.
2. Fallback from legacy `repeatUid` or `_uid` only when `_id` is missing.
3. Generate a 26-character ULID for new rows with no existing id.
4. Serialize `_id`, `_index`, `_parentId`, and `_submissionUid`.
5. Preserve existing `_index` when present; otherwise assign 1-based order.
6. For nested repeats, set `_parentId` to the parent repeat row `_id`.
7. For top-level repeats, set `_parentId` to the submission UID to match the active backend migration generator.
8. Leave the application database schema unchanged.
9. Leave large-repeat performance, hidden mandatory validation, and team scoping for separate slices.

## Acceptance Criteria

Behavioral:

1. A newly added repeat row saved through the normal row save path has `_id`, `_index`, `_parentId`, and `_submissionUid` in `data_instances.form_data`.
2. A newly added repeat row saved through save-and-add-another has the same metadata.
3. Existing repeat rows loaded with `_id` keep the exact same `_id` after edit/save/reopen.
4. Legacy rows loaded with `repeatUid` but no `_id` preserve that identity by writing it as `_id`.
5. Legacy rows loaded with neither `_id` nor `repeatUid` receive a new ULID on next save.
6. Nested repeat rows get `_parentId` equal to the parent repeat row `_id`.
7. Upload payload includes repeat rows with backend-compatible metadata because `toUpload()` sends saved `formData`.
8. No normalized repeat/data-value capture path is reintroduced.

Smoke checks:

1. Create a new submission with one repeat row, save, reopen, confirm `_id` exists and is stable.
2. Add two repeat rows, save-and-add-another, reopen, confirm each row has a distinct `_id` and expected `_index`.
3. Edit a saved repeat row, save, reopen, confirm `_id` did not change.
4. Seed a row with old `repeatUid`, save, inspect DB JSON, confirm `_id` equals the old `repeatUid` and `repeatUid` is not required for upload.
5. Seed a legacy row without any id, save, inspect DB JSON, confirm `_id` was added.
6. Use a nested repeat fixture or targeted unit/harness test to confirm child `_parentId` equals the parent row `_id`.

## Remaining Validation

Local create/save/reopen behavior and normalization are covered by focused tests. Before enabling synced submission edits in production, run a server round-trip smoke that preserves an existing top-level and nested `_id`, adds a new row with a new ULID, and confirms the server returns or stores the same metadata.
