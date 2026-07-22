# Production Boundaries And Working Strategy

Validated: 2026-07-22

Purpose: define the current production contracts and the safest investigation and cleanup order. This is the current decision overlay for the earlier repository maps. It does not replace runtime evidence.

## Authority Order

When sources disagree, use this order:

1. Observed production behavior and production data.
2. Reachable runtime call paths, persistence effects, network payloads, and build registration.
3. Product contracts explicitly recorded in this document.
4. Focused maps in this directory as evidence snapshots.
5. Names, comments, generated registrations, old tests, and old documentation.

The earlier numbered maps remain useful evidence. Their classification or implementation status may be stale where this document records a later finding. In particular, `07-repeat-uid-contract.md` describes the backend-compatible repeat metadata shape, but its "planned implementation" status is stale: compatible repeat metadata generation is now present on `develop`. Revalidate the touched call path before changing it.

## Classification Legend

Classify at function, registration, or call-path level when an active file also contains dead code.

| Label | Meaning | Comment-out test |
|---|---|---|
| `ACTIVE-CORE` | Required by the current production product | Removing it without replacement breaks startup/auth, config/offline access, assignment/form access, form capture/save, or submission upload |
| `ACTIVE-SUPPORT` | Reached and useful, but not itself a core product capability | Removing it degrades a reached helper/UI concern without disabling the core workflow |
| `REACHABLE-INCOMPLETE` | Runtime can invoke it, but the behavior or contract is unfinished, inconsistent, or misconfigured | It cannot be called dead merely because it does not work correctly |
| `REGISTERED-UNUSED` | Registered or generated, but no active consumer was found | Registration alone is not proof of use |
| `SCHEMA-ONLY` | Included in the production Drift schema but not used by an active feature path | Removing Dart references may be safe; dropping the table still requires a migration |
| `SOURCE-DEAD` | No active import, route, DI retrieval, persistence effect, or runtime reference was found | Removal should not affect the product, but must still pass focused checks |
| `UNKNOWN` | Static evidence is insufficient | Requires runtime tracing, production data inspection, or a characterization check |

Anything outside `ACTIVE-CORE` must not be presented as current architecture without its qualifier. Generated code inherits the status of the runtime registration or call site that consumes it.

## Current Product Contracts

These are product decisions unless marked `UNKNOWN` or contradicted by current code.

### Submission Lifecycle

- Submission synchronization is **push-only**. Pulling submissions is not an active product capability.
- A client-generated 11-character submission UID is the idempotency key for create/retry upload. The server creates or updates by that UID.
- Current production scope is submission creation and push. Pull/edit/delete policy is not complete enough to expose as a general production capability.
- Synced submissions are intended to remain read-only until update behavior is validated. Static code currently permits editing when `assignment_forms.canEditSubmissions == true`, so read-only behavior depends on deployed permissions rather than an unconditional guard.
- An unsynced completed submission may be returned to draft and completed again. Existing submission and repeat identities must survive that cycle; new repeat rows receive new identities.
- `finishedEntryTime` means the time the user marks a valid submission complete. Draft saves must not set or advance it.
- Only completed submissions may be uploaded. Draft synchronization remains disabled.
- A completion attempt with invalid or missing required data must expose the errors and offer either draft save or return-to-form correction.

### Identifier Convention

- Server/network DTOs should expose the external business identifier as `uid`, not the server database primary key.
- The mobile Drift models usually store that server UID in a property named `id`. In mobile code, `id` therefore normally means the external UID, not a server internal primary key.
- New submission UIDs use the existing 11-character `CodeGenerator.generateUid()` format.
- Repeat-row metadata is a separate contract: repeat `_id` is a 26-character ULID, with `_index`, `_parentId`, and `_submissionUid` preserved or populated as defined in `07-repeat-uid-contract.md`.
- Compatibility guards that accept both `id` and `uid` may be retired only endpoint by endpoint after DTO and persisted-data checks. Do not remove them mechanically.

Evidence: `lib/core/code_generator.dart`, `lib/datasource/base_datasource.dart`, `lib/database/dao/data_submissions_dao.dart`, and the active submission v1 DTO/service in the server repository.

### Form And Offline Behavior

- Hidden field values are cleared. If a field becomes visible again, mandatory validation must apply again.
- New submissions use the latest locally available form version.
- Existing submissions load the exact stored `templateVersion`, allowing old local submissions to continue using an older cached form version.
- An expired token can return the app to an unauthenticated state, while the per-user local database remains on disk. The next login requires connectivity and reuses/resynchronizes that local context.
- Configuration resources such as forms are intended to be idempotently resynchronized. Submission pull is excluded from that contract.

Evidence: `lib/features/form_submission/application/element/form_element.dart`, `lib/features/form_submission/presentation/form_flow_bootstrapper_vm.dart`, `lib/database/dao/data_submissions_dao_expression_extension.dart`, and `lib/core/auth/auth_manager.dart`.

### Access And Deletion

- `assignment_forms` is the currently proven form/submission access source.
- `formPermissions` is intended to become authoritative for edit/delete decisions, but is not proven as an active decision source.
- Synchronized deletion is soft-delete intent. The current lifecycle is incomplete: competing delete paths exist, and the upload payload uses `deleted: true`; reliable offline delete upload and server-time semantics are not established.
- Do not expose or consolidate synced edit/delete behavior until its authorization, state transition, identity, and retry contracts are characterized.

## Active Runtime Boundaries

### Login, User Scope, And Configuration Sync

`lib/main.dart`
-> `lib/app/di/injection.dart`
-> `lib/core/auth/auth_manager.dart`
-> `registerUserSdkDeps()` in `lib/di/init_active_session_scope.dart`
-> `lib/core/sync_manager/sync_manager.dart`
-> sequential `AbstractDatasource` instances
-> API clients and Drift DAOs.

`registerUserSdkDeps()` is hand-maintained active behavior. Its raw, non-generic `AbstractDatasource` registrations allow `SyncManager` to retrieve one list and invoke each datasource sequentially. The former generated scoped registration alternative has been removed; the manual list is the only active registration path.

The legacy-named `rSdkLocator` and app locator resolve to the same `GetIt.instance`. The application owns composition, including storage, token storage, HTTP, form, assignment, table, database, and datasource services. Names and former package origin do not define ownership.

`UserDatasource` is registered as its concrete type, not as an `AbstractDatasource`; it is not part of the sequential bulk configuration list. Login fetches the user profile through `AuthApi` before creating the user scope.

### Form Capture And Submission Upload

The active form load/render/repeat/save path remains the one mapped in `02-form-flow.md`: one stored form JSON template is expanded into the app element/control tree, then the entire submission is reduced and persisted as one `data_instances.formData` JSON object. Upload serializes that saved object.

The repeat/data-value relational-looking tables are not the active form capture store. Their presence in the schema is not evidence that form data is saved through them.

## Confirmed Code/Contract Conflicts

These are bounded correctness or cleanup candidates, not settled architecture:

Closed on `develop`: submission pull is excluded from the active manual and generated session registrations, and the unreferenced `DataInstanceDatasource` implementation has been removed. Submission upload continues through `DataInstancesDao.upload()`. `test/dev/active_session_sync_registration_test.dart` locks the push-only registration boundary.

Draft saves now preserve `finishedEntryTime` instead of creating or advancing it; `markFinal()` remains the normal completion-time writer. `test/dev/data_submission_lifecycle_test.dart` characterizes both transitions.

Template-required fields were confirmed to stop blocking validation while hidden and become required when shown again. The actual defects were rule-driven mandatory removal and stale required validators on optional fields after hide/show; both are fixed and characterized in `test/dev/form_element_visibility_validation_test.dart`.

Team form fields now resolve managed-team choices only from the current assignment's manager team and activity. The previous provider discarded Drift's returned filtered query through cascade syntax, and the widget passed an assignment UID as a team UID. Missing or unknown assignment context now returns no choices. `test/dev/managed_teams_scope_test.dart` covers cross-activity and cross-manager rows.

Required multi-choice fields now reject empty lists in new and edited repeat rows. The validator remains synchronized with hidden/visible and rule-driven mandatory state. `test/dev/repeat_multi_choice_validation_test.dart` and `test/dev/form_element_visibility_validation_test.dart` cover the active row-validity boundary.

| Finding | Classification | Evidence | Required next proof |
|---|---|---|---|
| Synced edit is permission-dependent despite the temporary read-only product policy | `ACTIVE-CORE` policy gap | `form_flow_bootstrapper_vm.dart` and `submission_list.provider.dart` use `canEditSubmissions || !isSynced` | Confirm deployed assignment values and define one edit gate |
| Soft deletion has competing paths and an incomplete upload-state transition | `REACHABLE-INCOMPLETE` | `data_submissions_dao.dart`, `submission_list.provider.dart`, and `data_submission.extension.dart` | End-to-end delete state/payload characterization |
| `user_form_permissions` is fetched/stored but no active authorization read was proven | `REACHABLE-INCOMPLETE` | `UserFormAccessesDatasource` registration and table references | Trace or test intended consumer before activation or removal |

## Inactive And Misleading Surface Policy

Dead-looking code is investigated early so it cannot distort later decisions, but removal is ordered by production risk:

1. Remove `SOURCE-DEAD` comments, unused source paths, obsolete routes, and abandoned providers in one bounded domain at a time.
2. Remove `REGISTERED-UNUSED` generated/DI surfaces only after proving there is no indirect retrieval.
3. Correct or isolate `REACHABLE-INCOMPLETE` paths before they are mistaken for supported features.
4. Treat inactive tables as `SCHEMA-ONLY` until a production-safe Drift migration proves they can be dropped.
5. Consolidate active fragments only after consumers, network effects, persistence effects, and executable equivalence checks are known.

Do not create one repository-wide dead-code PR. Each cleanup must name the removed capability/lookalike, show reference evidence, and pass checks for the adjacent active path. If removal is premature, put the surface behind an explicit `legacy`, `inactive`, or experimental boundary and prevent active DI/routes from registering it.

## Production Compatibility Boundary

Before ownership reorganization, state-management consolidation, persistence refactoring, or table removal, preserve and test:

- Android application ID, signing identity, upgrade path, and local signing configuration outside git;
- per-user database location/name and secure/shared storage keys;
- Drift schema version and every migration from a production-observed database;
- cached historical form versions referenced by existing submissions;
- submission 11-character UID and repeat 26-character ULID identity;
- whole-form JSON compatibility and upload DTO shape;
- offline drafts/finals, sync state, and retry idempotency;
- active DI registration order where synchronization depends on it.

Google Play `5.3.1+21` was inspected through a read-only Android backup: its active per-user `datarun_<user>.db` is healthy at schema version 3. Current `AppDatabase.schemaVersion` is 5. `test/fixtures/database/schema_v3.sql` captures the production schema, and `test/dev/app_database_migration_test.dart` proves schema 3 and 4 upgrades preserve cached form/submission JSON while dropping only the obsolete normalized repeat/data-value tables. Schema 3 remains the required production migration source until field evidence proves another shipped version.

The Play-installed APK is signed by the Google Play App Signing certificate, while local release builds use the Hamza/nmcpye upload key. A locally built APK cannot update the Play installation in place. Production upgrade smoke must use a Play internal-testing build (or another Play-distributed track) so Google re-signs it with the installed-app certificate.

## Work Sequence

This is an ordering framework, not a commitment to months of infrastructure work.

### 1. Stabilize Known Contracts

Use small behavior PRs for confirmed conflicts that can affect live data or repeatedly mislead investigation. Each slice must add the smallest characterization check that proves the bug and the fix. Do not combine these changes.

### 2. Remove Low-Risk Misleading Source

Use focused maps and reference searches to remove source-dead form providers, old routes, abandoned synchronization coordinators, and other no-consumer code by domain. Update the relevant map status when the slice closes.

### 3. Clean Runtime Registration Prerequisites

Remove unused registrations and generated alternatives after a registration-level check. This prerequisite is complete: root database registration and the active per-user datasource list are explicit and covered by `test/dev/active_session_sync_registration_test.dart`.

### 4. Migrate Schema-Backed Dead Features

The inactive repeat/data-value DAOs, callers, and schema tables are removed. Migration 5 covers populated schema 3 and 4 databases.

### 5. Consolidate Boundaries Mechanically

Completed on `develop`: surviving `drun_sdk` sources were moved mechanically into the root `datarunmobile` package. Package imports and direct dependencies were updated without changing the Drift schema, database filename, upload shape, sync registration order, or form engine behavior. The former package license is preserved in `docs/licenses/drun-sdk-LGPL-3.0.txt`.

### 6. Reorganize By Proven Ownership

Next, organize folders by proven responsibility, lifecycle, and dependency direction. Keep file moves separate from behavioral changes where practical; directory names must describe established ownership rather than invent it.

Map each active state to its owner, lifetime, consumers, and persistence effects before consolidating Riverpod, GetIt, Stacked, reactive forms, or other state mechanisms. Migrate one bounded feature at a time. The goal is one coherent state owner per responsibility, not forcing one library into every concern. Remove a state library only when no active path still depends on it.

Where same-layer methods or services implement the same responsibility in scattered places, consolidate them only after their callers and database/network effects are characterized. Move consumers to one minimal owner, prove equivalent behavior, and then remove the superseded paths; do not create generic utility collections that preserve the ambiguity under a new name.

Then address form engine/expression simplification, synchronization boundaries, access policy, metadata ownership, and larger repeat performance as independently characterized domains.

## Closure Rule For Every Slice

A bounded piece of work is closed only when:

1. Its product/data contract is stated.
2. The active call path and inactive lookalikes are named.
3. Persistence, network, identity, migration, and offline effects are evaluated.
4. The smallest executable check fails before or characterizes the old behavior and passes after.
5. A production-style smoke path is run when user data or sync is touched.
6. The focused map is corrected only if the evidence changed.
7. Unresolved policy is left explicit rather than implemented by assumption.

Future agents should begin here, then read only the focused map for the boundary being changed. A full-repository rescan is required only when the proposed change crosses an unclassified boundary.
