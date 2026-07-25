# Agent Onboarding

Validated: 2026-07-24

Purpose: give coding agents a durable starting point without making them rediscover the repository or treat historical code as current architecture.

## Repository And Production Status

DataRun is a Flutter mobile application for assignment-driven, offline-capable field data collection. It downloads configuration and form templates, stores them in a per-user Drift database, captures submissions locally, and uploads completed submissions.

`v6.0.0+50` is the last production baseline fully verified in these documents.
It was released from commit `ff20d6fc` and rolled out through Google Play to
100% of users. A real Play `5.3.1+21` to Play `6.0.0+50` in-place upgrade
preserved the cached session, configuration, drafts, repeat data, completed
submissions, and upload behavior. Reconcile this baseline at each release
rather than assuming it describes the current store version.

The former local `drun_sdk` package was consolidated into the root `datarunmobile` package. All active Dart production code is under `lib/`; the stale remote SDK repository is not authoritative. The move preserved the database filename/schema lineage, storage keys, network payloads, sync registration order, and form behavior.

## Context Map Ownership

Read `09-production-boundaries-and-work-strategy.md` first. It owns current
product contracts, the production compatibility boundary, and durable working
rules. Read `11-current-work.md` for current priority. Do not treat
`12-completed-work.md` as authority; it is a historical index.

Then read only the focused map for the boundary being changed:

- `01-production-code-path-map.md`: broad entrypoints and production call paths.
- `02-form-flow.md`: form load/render/repeat/edit/save and form-state ownership.
- `03-config-fetching.md`: configuration fetch, parsing, registration, and offline cache.
- `04-state-di-runtime-map.md`: state owners, DI, scopes, and generated registration.
- `05-classification-reconciliation.md`: strict active/inactive legend and unresolved misleading surfaces.
- `06-large-repeat-hang-data-loss.md`: closed repeat improvements and current residual scaling risks.
- `decisions/07-repeat-uid-contract.md`: accepted repeat identity and metadata
  contract.
- `08-validation-baseline.md`: current executable checks and limits.

Focused maps own technical detail. Do not duplicate their tables into `09`; update the owner document when evidence changes.

## Runtime Boundaries

### App And Composition

- `lib/main.dart` is the Flutter entrypoint.
- `lib/app/di/injection.dart` coordinates generated Stacked/app DI and explicit database registration.
- `lib/di/injection.dart` owns the single `appLocator = GetIt.instance`.
- `lib/app/stacked/app.dart` owns active generated routes and Stacked navigation/dialog registration.
- `lib/core/auth/auth_manager.dart` owns authenticated session transitions and the per-user GetIt scope.
- `lib/di/init_active_session_scope.dart` explicitly registers the nine configuration datasources used by `SyncManager`.
- `lib/database/db_factory/` opens one Drift database per user.

Do not infer ownership from directories such as `core`, `data`, or `features`, or from a file's former SDK location. Prove it from callers, lifecycle, persistence, network effects, and registration.

### Active Form Flow

1. A table or assignment action opens `FormFlowBootstrapper`.
2. `FormFlowBootstrapperController` creates or loads a `DataInstance` and opens a submission-named GetIt scope.
3. `FormTemplateRepository` loads the exact cached form version plus options from Drift.
4. `FormElementControlBuilder` builds the root control graph. Stored repeat rows receive one lightweight map control while dormant.
5. `FormElementBuilder` builds the full element/rule graph, including repeat-row element instances.
6. The bootstrapper resolves dependencies, evaluates initial rules, and registers `FormInstance`.
7. `FormSubmissionScreen` and field/repeat widgets render from the scoped `FormInstance`.
8. Opening a repeat row materializes that row's field controls; closing the editor commits or discards transactionally and disposes those controls.
9. `FormInstance.saveFormData()` reduces the entire active form to one nested map and writes `data_instances.formData`.
10. `SubmissionUploadService` uploads eligible completed rows as whole saved JSON objects.

Form authority is divided by responsibility, not duplicated:

- `reactive_forms` controls own field values, enabled state, validators, errors, and validity.
- `FormElementState`/`FieldElementState` hold presentation and rule projection only.
- the element tree owns hierarchy, dependencies, rule application, repeat lifecycle, and reduction.
- `FormInstance` owns one submission lifecycle and persistence orchestration.
- Riverpod owns feature/presentation state such as lists, filters, selection, and preferences; it is not a second form-value store.

## Inactive Or Incomplete Form-Looking Surfaces

The following are not alternative active form stores:

- normalized `repeat_instances` and `data_values` persistence was removed in schema 5;
- the write-only `data_elements` sync/table path was removed in schema 6;
- obsolete form repositories, value stores, rule-effect state, Riverpod form-instance sketches, alternate repeat editors, and duplicate template builders were removed;
- submission pulling is excluded and its datasource was removed;
- `lib/data/metadata_submission_update.provider.dart` remains reachable from reference fields but currently returns no records;
- calculated fields parse but do not calculate and are unsupported/incomplete;
- `user_form_permissions` is fetched and stored, but active authorization reads are not proven; `assignment_forms` is the proven access source.

Do not recreate a removed path because its former table or class name sounds appropriate.

## Evidence And Classification

Docs, comments, generated code, table names, tests, and historical branches are evidence, not authority. Prefer, in order:

1. observed production behavior and data;
2. active call paths and persistence/network effects;
3. current product contracts in `09`;
4. focused maps;
5. names and historical intent.

Apply the comment-out test at function or registration level:

- `ACTIVE-CORE`: removing it without replacement breaks a core production workflow.
- `ACTIVE-SUPPORT`: reached and useful, but not itself a core capability.
- `REACHABLE-INCOMPLETE`: runtime can reach it, but its contract is unfinished.
- `REGISTERED-UNUSED`: generated or registered without a proven consumer.
- `SCHEMA-ONLY`: persisted table/column without a proven active feature.
- `SOURCE-DEAD`: no active import, route, retrieval, effect, or reference.
- `UNKNOWN`: current evidence cannot decide.

A reachable file may contain source-dead methods. Generated registration alone does not make code active.

## Build And Validation

Common commands:

```bash
flutter pub get
flutter test --no-pub
flutter analyze --no-pub
flutter build apk --debug --no-pub
dart run build_runner build
flutter run
```

Use the matrix in `08-validation-baseline.md` to select checks. Generated output is active for Stacked, injectable, Riverpod, Drift, Freezed, JSON serialization, and localization; run the relevant generator and review its diff intentionally.

Release builds require the local upload key outside git. Google Play signs distributed APKs with the separate Play App Signing key, so a locally signed APK cannot update a Play installation in place. Production upgrade tests must use a Play-distributed track.

## Safe Working Rules

Before editing:

1. Check the branch and dirty tree.
2. Read `09` and the focused map.
3. State the behavior/data contract.
4. Trace the active owner and rule out inactive lookalikes.
5. Identify persistence, network, identity, migration, offline, and generated-code effects.
6. Choose the smallest slice that closes one behavior.

While editing:

- preserve user changes already in the tree;
- avoid changing persistence formats or schema unless the slice requires it;
- do not manually edit generated files when a generator owns them;
- do not add a second owner, compatibility wrapper, provider, or service to bypass an unclear boundary;
- when relevant known debt is safely inside the slice, move consumers toward the established owner and remove the superseded path;
- when debt is unrelated, record it in `11-current-work.md` only if it is
  accepted and prioritized; otherwise use a GitHub issue instead of broadening
  the change;
- treat product/data invariants as protected behavior, not current implementation structure.

## Definition Of Done

A code change is closed only when:

- the active path and inactive lookalikes are identified;
- one explicit behavior/data contract is implemented;
- state and lifecycle ownership remain singular and clear;
- persistence, sync, offline, identity, migration, and compatibility risks are evaluated;
- focused characterization tests pass;
- analyzer/build/generation checks appropriate to the slice are run or reported;
- a production-style device smoke is completed when user data, auth, sync, migration, or forms are touched;
- the focused map is corrected when evidence changed;
- out-of-scope uncertainty is left explicit.

For form/repeat/save changes, also prove save/reopen, completion validity, hidden/show behavior, repeat identity, nested dependencies where relevant, and existing submission compatibility.

## Lightweight Production Workflow

`develop` is the integration baseline and `main` is production. A branch/PR is optional ceremony for solo work; a focused commit and reviewed diff are mandatory.

For each production change:

1. Start from current `develop`.
2. Keep one behavior per commit or tightly related commit series.
3. Run focused tests, the full test suite, analyzer, and the appropriate build.
4. Smoke the touched workflow on a real device when needed.
5. Review `git diff` and migration/signing/release implications.
6. Promote a tested commit to `main`, intentionally set version/build, tag it, and retain release artifacts.
7. For data-affecting releases, run a Play-distributed in-place upgrade from the current production version.
8. After rollout, monitor adoption, Play vitals, and GlitchTip before declaring production stability.

## Current High-Risk Areas

- The repeat control-memory problem is reduced, but the full element/dependency graph remains eager.
- Outside-to-repeat rule fan-out remains linear in dependent rows.
- Saving still reduces, JSON-encodes, and writes the whole submission.
- Synced edit/delete authorization and server round-trip behavior are incomplete.
- The bounded Reference implementation is on `develop` but remains
  deployment/activation-gated by `10-bounded-reference-field-draft.md`.
  Calculated fields remain incomplete.
- Server error response shapes and whole-resource configuration sync need server-side contracts before deeper client changes.
- Multiple state/DI libraries remain active by distinct responsibility; consolidate only after proving an actual duplicate owner.

The ordered current queue belongs in `11-current-work.md`. Completed work moves
to `12-completed-work.md`; do not leave completed checkboxes in the current
queue.
