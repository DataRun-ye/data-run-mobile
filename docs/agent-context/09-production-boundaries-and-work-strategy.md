# Production Boundaries And Working Strategy

Validated: 2026-07-24

Purpose: own the current product contracts, production compatibility boundary, closed v6 baseline, and ordered remaining work. Focused technical evidence remains in the other numbered maps.

## Current Production Baseline

- Production release: `6.0.0+50`.
- Source/tag: commit `ff20d6fc`, tag `v6.0.0`.
- Google Play status: production rollout completed at 100% on 2026-07-24.
- Observation status: adoption, installs, crash rate, and field telemetry are still pending. An empty metric before users update is not evidence of zero crashes.
- Current mobile Drift schema: 6.
- Production migration source observed from Play `5.3.1+21`: schema 3.
- Release artifacts: exact Play-uploaded AAB retained outside the repo under `/home/hamza/datarun/releases/v6.0.0/`; demo ARM64 APK and source release published at GitHub tag `v6.0.0`.

Production-style upgrade evidence:

1. Play `5.3.1+21` was installed and populated with a cached authenticated user, configuration, old form versions, drafts, repeats, nested repeats, completed unsynced data, and synced data.
2. Google Play updated that installation in place to `6.0.0+50`.
3. The app retained the session/config/submissions, migrated schema 3 to 6, opened old forms, preserved repeat and multi-select behavior, saved drafts/completed data, uploaded a new submission, and retained locale behavior.
4. No focused Flutter, Drift, SQLite, or crash failure appeared during that smoke. This proves the exercised migration/workflow, not all production devices.

The Play-installed APK uses the Google Play App Signing certificate. Local release builds use the Hamza/nmcpye upload key stored outside git. A local APK cannot update a Play installation in place; future production upgrade gates must use a Play-distributed track.

## Authority Order

When evidence disagrees:

1. Observed production behavior and production data.
2. Reachable call paths, persistence/network effects, and active registration.
3. Product contracts in this document.
4. The focused map for that boundary.
5. Names, comments, generated-only registrations, historical tests, and old docs.

Use the strict comment-out labels in `05-classification-reconciliation.md`. Revalidate the touched call path before changing it.

## Product Contracts

### Submission Lifecycle

- Submission synchronization is push-only. Submission pull is not registered or supported.
- A client-generated 11-character submission UID is the idempotency key for create/retry upload.
- Only completed submissions are eligible to upload.
- `finishedEntryTime` is written when the user marks a valid submission complete; draft saves do not create or advance it.
- Invalid completion exposes errors and lets the user remain for review or save a draft.
- An unsynced completed submission may return to draft and be completed again while retaining submission/repeat identities.
- Synced editing is not a validated general product capability. Current code permits it when `assignment_forms.canEditSubmissions` is true, so deployed permission data can expose an incomplete policy.

### Identity

- Server/network DTOs should expose external business `uid`, not internal database primary keys.
- Mobile Drift models commonly store that external UID in a property named `id`.
- New submission UIDs use the existing 11-character `CodeGenerator.generateUid()` format.
- Repeat rows use the contract in `07-repeat-uid-contract.md`: stable `_id`, `_index`, `_parentId`, and `_submissionUid`; new row IDs are ULIDs.
- Existing IDs survive edits; only new rows receive new IDs.
- `id`/`uid` compatibility guards may be retired only endpoint by endpoint after payload and persisted-data checks.

### Forms, Rules, And Offline Data

- New submissions use the latest locally cached form version.
- Existing submissions load their stored `templateVersion`, preserving old cached forms.
- Form submissions persist as one whole `data_instances.formData` JSON object.
- Normalized repeat/data-value persistence is obsolete and must not be recreated.
- Temporary hide/show retains active editing values and identity. Hidden elements are excluded from validation and save projection; after save/reopen, omitted hidden data is gone.
- A field shown again regains required, type, choice, and rule validation.
- `validationRule` is authoritative when present. Legacy `Error` actions remain compatibility behavior only for cached forms without `validationRule`.
- `reactive_forms` controls own values and validity. Element state owns presentation/rule projection only.
- Calculated fields are unsupported/incomplete.

### Repeat Editing And Performance

- Row editing is transactional: pristine close, save, discard, and continue-editing have explicit behavior.
- Discard restores the opening snapshot; discarding a new row removes that exact provisional row.
- Delete confirms once for one or many selected rows.
- Dormant repeat rows retain one map control; field controls exist only while a row editor is open.
- The element/dependency graph remains eager and whole-JSON save remains active. These are residual optimization candidates, not required implementation invariants.
- Nested, row-local, sibling-to-repeat, and root-to-repeat dependencies are characterized by live-form fixtures and tests.

### Authentication And Configuration Sync

- The app is offline-first. A committed cached session opens local work directly when its access token is valid.
- If an expired token cannot refresh because the device is offline or the failure is transient, cached local work remains available.
- Only an explicit refresh rejection (`401` or `403`) clears active credentials; cached profile/database files remain.
- Token refresh has one network/rotation owner and concurrent refreshes serialize.
- Logout/revocation drains active configuration/upload cleanup before closing the user database scope.
- Configuration sync is sequential and local writes are retained resource by resource.
- Failed or partial runs do not mark configuration globally ready or advance successful-sync metadata.
- Retry reruns only failed/unattempted resources. Leaving stops after the active request.
- Whole-resource `paged=false` transfer remains; delta/versioned transfer requires a server contract.

### Access And Deletion

- `assignment_forms` is the proven form/submission access source.
- `user_form_permissions` is fetched/stored but is not yet a proven authorization decision source.
- Synced edit requires explicit authorization, state, conflict, identity, and retry policy.
- Synced deletion is intended as soft deletion, but client state transition, offline retry, payload ownership, and server-time semantics are incomplete.
- Do not expose or consolidate synced edit/delete until these contracts are characterized end to end.

### Errors And Telemetry

- User-facing network/auth/submission failures cross typed categories and localized Arabic/English presentation.
- Cancellations are silent; internal exception/plugin details are not shown.
- Mobile decodes current nested/RFC/plain-text server responses and known `E3000`-`E3006`/`E4110`-`E4116` codes.
- Submission bulk upload distinguishes complete, partial, rejected, malformed, and transport outcomes; prepared rows cannot remain stuck in `uploading`.
- GlitchTip/Sentry release identity is `org.datarun.app@6.0.0+50`. Production telemetry excludes screenshots and projects only approved user identity.
- Server response shape remains inconsistent; a structured additive server contract is still required.

## Active Production Boundaries

### App, Session, And Configuration

```text
lib/main.dart
-> lib/app/di/injection.dart
-> lib/core/auth/auth_manager.dart
-> lib/di/init_active_session_scope.dart
-> lib/core/sync_manager/sync_manager.dart
-> nine ordered AbstractDatasource registrations
-> remote API + per-user Drift database
```

`lib/di/injection.dart` owns the single GetIt locator. `AuthManager` owns the user scope/database. `registerUserConfigurationDatasources()` is the sole active configuration membership/order source.

### Form Capture And Upload

```text
table/assignment action
-> FormFlowBootstrapperController
-> exact cached FormTemplateVersion
-> FormElementControlBuilder + FormElementBuilder
-> scoped FormInstance
-> FormSubmissionScreen / repeat row editor
-> FormInstance.saveFormData()
-> DataInstancesDao.updateData()
-> SubmissionUploadService
-> server bulk submission endpoint
```

The active ownership and lifecycle details are in `02-form-flow.md`. Repeat scaling evidence is in `06-large-repeat-hang-data-loss.md`.

## Closed In V6

Do not reopen these as uninvestigated tasks unless new evidence contradicts them:

| Area | Closed result | Detail owner |
|---|---|---|
| Production mapping/onboarding | Active paths, strict classification, and compatibility boundary established | `01`, `05`, this file |
| SDK boundary | Former package mechanically consolidated into root package without schema/payload changes | `01`, `04` |
| Dead source/schema | Broad proven-dead paths removed; repeat/data-value tables dropped in schema 5; unused data-elements table dropped in schema 6 | `03`, `05`, migration tests |
| DI/state ownership | Single locator; explicit datasource list; startup/login/sync/form/submission-table/locale owners established; duplicate stacks removed | `04` |
| Form value/rule ownership | Controls own value/validity; element state is presentation/rule projection; validationRule authority established | `02` |
| Form correctness | hidden/show validation, multi-select identity/validity, managed-team scoping, completion time, dirty back behavior fixed | `02`, focused tests |
| Repeat identity/editing | backend-compatible metadata, transactional row edit, nested discard, multi-delete confirmation, dirty propagation | `02`, `07` |
| Large-repeat first phase | canonical template tree, reduced rule fan-out, dormant controls, reusable dormant validation | `06` |
| Auth/session | transactional login, one refresh owner, offline startup, idempotent revocation, operation draining | `04`, auth tests |
| Config sync | truthful outcomes, queue stop, selective retry, cached-data preservation | `03` |
| Errors/upload | localized typed failures and complete/partial/rejected upload outcomes | error/upload tests |
| Tooling/release | generator scope reduced; Linux/Android/release build baseline; telemetry/signing/release gate completed | `08`, current release baseline |

## Production Compatibility Boundary

Before changing ownership, state, persistence, sync, or storage, preserve and test:

- Android application ID, upload/Play signing distinction, and in-place Play upgrade path;
- per-user database filename/location and secure/shared storage keys;
- every migration from production-observed schema 3;
- cached historical form versions referenced by submissions;
- 11-character submission UID and repeat metadata identity;
- whole-form JSON and upload DTO compatibility;
- offline drafts/finals, sync state, retry idempotency, and partial-failure recovery;
- active datasource membership/order and user/form GetIt scope lifecycle.

`test/fixtures/database/schema_v3.sql` captures the observed production schema. `test/dev/app_database_migration_test.dart` proves schema 3/4/5 to 6 upgrades preserve active cached form/submission JSON while removing only obsolete normalized repeat/data-value and data-element tables.

## Current Ordered Roadmap

### 1. Observe And Stabilize V6

- Track Play adoption, Android vitals, GlitchTip events, sync outcomes, and field feedback during the campaign.
- Treat production regressions as focused priority fixes.
- Do not infer stability until users update and exercise forms/sync.

### 2. Continue Bounded Ownership Cleanup

- Recheck remaining active services/providers feature by feature for actual overlapping authority.
- Treat registered-but-unread configuration such as `OuLevelDatasource` as a bounded demotion/migration candidate, not core behavior.
- Organize folders and same-layer services around proven responsibility/lifecycle, keeping mechanical moves separate from behavior changes.
- Remove residual source-dead/generated-only paths with adjacent registration/behavior checks.
- Do not force one state library across unrelated concerns; consolidate only a demonstrated duplicate owner.

### 3. Define Synced Edit, Delete, And Authorization

- Decide the `assignment_forms` versus `user_form_permissions` authority.
- Define synced read/edit states, repeat server round trip, update conflict/idempotency, soft-delete payload/state, offline retry, and server-time behavior.
- Implement as separate tested slices after the policy is explicit.

### 4. Close Remaining Supported-Feature Gaps

- Decide whether Reference fields receive a real offline metadata owner or are removed/rejected.
- Keep calculated fields explicitly unsupported until expression/value ownership and product use are defined.
- Standardize server error responses additively (`code`, `args`, `traceId`, bulk failure details) after a bounded server plan.

### 5. Revisit Transfer And Repeat Performance From Evidence

- Measure deployed configuration payloads before proposing delta/versioned server sync.
- Use v6 field reports and the existing 50/150/300-row harness to choose any next repeat slice.
- Current residual candidates are eager element/dependency graph, linear fan-out, table refresh, whole-JSON reduction/write, and form-level concurrent-save/process interruption.
- Do not introduce normalized repeat storage or speculative graph laziness without a measured dominant phase and compatibility plan.

## Evolution Rule

New feature work must not silently deepen a known ownership or boundary problem.

- Identify the current owner and relevant debt before implementation.
- If a bounded, behavior-preserving move to the established owner is necessary for the feature, include it and remove the superseded path.
- If debt is unrelated or would broaden production risk, keep the feature slice narrow and record the debt in this roadmap.
- Do not add compatibility wrappers, duplicate state, generic service layers, or alternate persistence merely to avoid understanding the current boundary.
- Protect product/data behavior, not accidental class/folder structure.

## Closure Rule

A bounded slice is closed only when:

1. The product/data contract is stated.
2. Active owners and inactive lookalikes are named.
3. Persistence, network, identity, migration, offline, and generated-code effects are evaluated.
4. The smallest executable check characterizes or fails before the fix and passes after.
5. Appropriate full checks pass without increasing analyzer debt.
6. A production-style device smoke runs when user data, auth, sync, migration, or forms are touched.
7. The focused map changes only when evidence changed.
8. Unresolved policy remains explicit instead of being implemented by assumption.

Future agents should start here, then read only the focused map for the boundary being changed. A full-repository rescan is justified only when work crosses an unclassified boundary.
