# Active And Inactive Classification

Validated: 2026-07-24

Purpose: provide one strict classification legend and identify the remaining surfaces most likely to mislead future agents. Detailed runtime evidence belongs in the focused maps.

## Strict Comment-Out Test

Classify functions, registrations, and call paths rather than whole files whenever a reachable file contains unused behavior.

| Label | Meaning | Comment-out test |
|---|---|---|
| `ACTIVE-CORE` | Required by the current production product | Removing it without replacement breaks startup/auth, configuration/offline access, assignment/form access, form capture/save, or submission upload |
| `ACTIVE-SUPPORT` | Reached and useful, but not itself a core product capability | Removing it degrades a reached helper or UI concern without disabling core data collection |
| `REACHABLE-INCOMPLETE` | Runtime can invoke it, but the behavior or policy is unfinished | It is not dead merely because it fails or returns no useful data |
| `REGISTERED-UNUSED` | Generated or registered, but no active consumer is proven | Registration alone is not evidence of production use |
| `SCHEMA-ONLY` | Present in a shipped schema but not used by an active feature | Source removal may be safe; dropping storage still requires an explicit migration |
| `SOURCE-DEAD` | No active import, route, DI retrieval, persistence effect, or runtime reference | Removal should preserve production behavior, subject to focused checks |
| `UNKNOWN` | Current static/runtime evidence cannot decide | Requires tracing, production data inspection, or characterization |

Do not classify code as `ACTIVE-CORE` because it compiles, has a plausible name, appears in generated output, is registered but never retrieved, or is mentioned in old docs/comments.

## Current Core Authorities

| Boundary | Classification | Current authority |
|---|---|---|
| App entry and navigation | `ACTIVE-CORE` | `lib/main.dart`; generated Stacked router/navigation from `lib/app/stacked/app.dart` |
| Session and user scope | `ACTIVE-CORE` | `lib/core/auth/auth_manager.dart`; `AuthApi`; `TokenRefresher`; `SessionOperationTracker` |
| Configuration sync | `ACTIVE-CORE` | explicit datasource list in `lib/di/init_active_session_scope.dart`; `SyncManager`; `SyncResourcesController` |
| Offline configuration | `ACTIVE-CORE` | per-user `AppDatabase`, active datasources, DAOs, and cached form/version JSON |
| Form lifecycle | `ACTIVE-CORE` | submission-scoped `FormInstance` and `FormTemplateRepository` |
| Field value/validity | `ACTIVE-CORE` | `reactive_forms` controls |
| Form presentation/rules | `ACTIVE-CORE` | `FormElementInstance` tree and presentation-only element state |
| Repeat editing | `ACTIVE-CORE` | `RepeatRowEditSession`, `RepeatTable`, `EditRowScreen`, and `FormInstance` orchestration |
| Submission persistence | `ACTIVE-CORE` | whole `data_instances.formData` JSON through `DataInstancesDao` |
| Submission upload | `ACTIVE-CORE` | `SubmissionUploadService` and DAO-owned state transitions; no pull datasource |
| Submission table state | `ACTIVE-CORE` | form/assignment-scoped `TableController` plus user-scoped `SubmissionTableService` |
| Locale | `ACTIVE-CORE` | app-level preference plus device/build fallback in `app_locale_policy.dart` |
| Error presentation | `ACTIVE-SUPPORT` | typed `ServerFailure`/network categories and localized presentation; Stacked `DialogService` is the reached generic dialog owner |

## Remaining Misleading Or Incomplete Surfaces

| Surface | Classification | Evidence | Required decision |
|---|---|---|---|
| `OuLevelDatasource` and `ou_levels` | `REGISTERED-UNUSED` / `SCHEMA-ONLY` | active sync registration writes the table, but no production reader exists outside datasource/schema/generated code | Stop syncing in a bounded registration slice; drop the table only through a production migration |
| Debug/example `main()` in `form_data_aggregator.dart` | `SOURCE-DEAD` fragment inside an active file | aggregation methods are consumed by submission summaries; the standalone `main()`/`print` block has no caller | Remove the debug fragment in a bounded no-behavior cleanup |
| `lib/data/metadata_submission_update.provider.dart` and Reference field UI | `REACHABLE-INCOMPLETE` | `ValueType.Reference` routes to the widget, but the provider returns an empty list; none of 19 captured live form versions uses the type | Define backing metadata and future product use, or reject/remove the unsupported field path |
| Calculated field parsing/render path | `REACHABLE-INCOMPLETE` | `ValueType.Calculated` is parsed, but calculation writeback is commented and captured live forms do not use it | Define expression/value ownership before implementing, or reject the type explicitly |
| `user_form_permissions` fetch/table | `REACHABLE-INCOMPLETE` | datasource is in the active sync list and persists rows, but active access decisions are proven through `assignment_forms` | Define it as an authorization source with tests, or stop syncing and later migrate the table |
| Synced submission edit | `REACHABLE-INCOMPLETE` | local edit/save/upload code exists and delegates to one access query, but deployed permissions and server round-trip repeat identity are not validated as product policy | Define authorization, lifecycle, conflict, and identity behavior before enabling broadly |
| Synced/offline deletion | `REACHABLE-INCOMPLETE` | local delete and soft-delete payload traces exist, but retry/state/server-time behavior is not characterized end to end | Define one lifecycle and payload owner |
| Server failure response shapes | `ACTIVE-SUPPORT` residual | mobile compatibility decoder handles current variants, but server responses still mix nested errors, RFC-style fields, strings, and partial bulk maps | Add structured `code`, `args`, `traceId`, and bulk details server-side without breaking old clients |
| Whole-resource configuration transfer | `ACTIVE-CORE` residual | active sync still downloads sequential `paged=false` resource bodies | Measure deployed payloads before defining a delta/version server contract |

## Closed Misleading Surfaces

These were proven non-authoritative and removed. Do not recreate them:

- the physical `drun_sdk` package boundary and duplicate generated SDK registration;
- submission pull and its `DataInstanceDatasource`;
- normalized repeat/data-value tables, DAOs, datasources, and value-store paths;
- write-only `data_elements` datasource/table;
- metadata-submission table/datasource artifacts;
- obsolete form repositories, rule-effect/value state, provider sketches, builders, editors, and UI demos;
- duplicate sync coordinators/executors/providers;
- duplicate template tree construction and generated-only form-list services;
- duplicate submission table selection/command owners;
- unused Stacked snackbar, bottom-sheet, custom dialog/sheet registrations and hand-written viewmodels;
- abandoned party/manifest persistence and UI;
- unused assignment service and team-management demos;
- old `go_router` experiment and duplicate login screen.

Removal of source does not imply that an unknown table left behind by an unshipped experiment should be dropped from a user database. Database removal remains migration-governed.

## Classification Procedure

Before demoting or deleting a surface:

1. Search imports, exports, route calls, DI/provider registration and retrieval, generated references, persistence reads/writes, and tests.
2. Trace from a production entrypoint or active owner, not from the candidate name.
3. Check whether only part of a reachable file is unused.
4. Check shipped Drift schemas and migration fixtures separately from Dart reachability.
5. Add the smallest adjacent characterization or registration check.
6. Remove one bounded capability/lookalike and update its focused map.

The current unresolved work order belongs only in `09-production-boundaries-and-work-strategy.md`.
