# Agent Onboarding

Generated: 2026-07-10

Purpose: give future AI agents enough stable repository context to avoid repeating the same discovery work, misclassifying dead code as active, or making broad changes before the active production paths are understood.

This file is an onboarding guide. The numbered files in `docs/agent-context/` are the evidence maps.

Start with `09-production-boundaries-and-work-strategy.md`. It records the current product contracts, corrections to earlier classifications, production compatibility boundary, and investigation/cleanup order. Earlier maps remain evidence snapshots.

## Repository Purpose

This repo contains the DataRun mobile/data-collection app. It is a Flutter application for offline-capable field data collection, assignment-driven form access, local form entry, local submission storage, and sync/upload.

The surviving code from the former local `drun_sdk` package is consolidated into the root `datarunmobile` package. Current production behavior must be judged from this repo's active runtime paths; the stale remote SDK repository is not authoritative.

## Production Status

Treat this as a messy production repository for a running app. There is stale documentation, dead code, incomplete feature work, repeated logic, generated code churn, and multiple state-management approaches.

Do not assume an implementation is active because its name sounds right. Some tables and files look form-related but are not part of the active form capture path.

## Former SDK Boundary

All production Dart code now lives under `lib/`. The old physical app/SDK package boundary no longer exists; former SDK origin does not establish current ownership.

Important boundary points:

- `lib/main.dart` starts the production app.
- app DI is configured from `lib/app/di/injection.dart` and generated `lib/app/di/injection.config.dart`.
- Stacked routing is generated from `lib/app/stacked/app.dart`.
- the app opens a user-scoped Drift database and registers active configuration datasources after login/session restore.
- active sync/data persistence goes through `lib/database`, `lib/datasource`, and the active datasource list in `lib/di/init_active_session_scope.dart`.
- active form rendering uses app builders/models and form template JSON stored in Drift.

Do not assign ownership based on a file's former package location. First prove the active app path, consumers, lifecycle, and persistence/network effects.

## Known Messy Areas

- Riverpod, GetIt scopes, `reactive_forms`, `ChangeNotifier`, generated injectable registrations/providers, and Stacked routing/services coexist. Hand-written Stacked viewmodels have been removed, but Stacked is still the active generated navigation mechanism.
- Form state is not owned by one clean system.
- Generated files are significant and can be stale or noisy.
- There are old form-state, form-value, sync, data-value, repeat-instance, and metadata-submission paths that are not proven active for current form capture.
- Example forms live under `example/`, but examples are evidence only, not production truth.

## Existing Context Maps

Read these before touching related areas:

- `01-production-code-path-map.md`: broad first-pass production path map.
- `02-form-flow.md`: active/inactive form load, render, repeat, save, edit, repeat metadata, and local persistence map.
- `03-config-fetching.md`: server config/form/assignment/org-unit/metadata fetch and offline cache map.
- `04-state-di-runtime-map.md`: state management, DI, scopes, generated registration, and runtime ownership map.
- `05-classification-reconciliation.md`: strict active/inactive classification overlay. Use this legend.
- `06-large-repeat-hang-data-loss.md`: large repeat hang and save/data-loss risk investigation.
- `07-repeat-uid-contract.md`: backend-validated repeat metadata evidence; its original implementation-status wording is historical.
- `08-validation-baseline.md`: check/test baseline snapshot; rerun commands before relying on its status.
- `09-production-boundaries-and-work-strategy.md`: current product-contract and production-boundary authority overlay.

## Active Form Flow Map

Current active form entry/edit flow:

1. Form open/create routes go through Stacked navigation into `FormFlowBootstrapper`.
2. `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart` creates or loads a `DataInstance`.
3. It creates a per-submission GetIt scope.
4. It registers a `FormTemplateRepository`.
5. It builds the full `reactive_forms` `FormGroup` through `FormElementControlBuilder`.
6. It builds the full app-side form element tree through `FormElementBuilder`.
7. It wraps the tree in a root `Section`, resolves dependencies, evaluates rules, and registers `FormInstance`.
8. `FormSubmissionScreen` renders the active form using scoped `FormInstance`.
9. Sections render through `SectionWidget`.
10. Fields render through `FieldWidget` and `FieldFactory`.
11. Repeats render through `RepeatTableSliver`, `RepeatTable`, and `RepeatTableDataSource`.
12. Submission save calls `FormInstance.saveFormData()`.
13. `saveFormData()` reduces the whole form tree to one nested map and writes `data_instances.formData` through `DataInstancesDao.updateData`.
14. Upload sends that whole saved `formData` through `DataSubmissionUploadExt.toUpload()`.

Core active files:

- `lib/features/form_submission/application/form_flow_bootstrapper_controller.dart`
- `lib/data/form_template_repository.dart`
- `lib/core/form/builder/form_element_control_builder.dart`
- `lib/core/form/builder/form_element_builder.dart`
- `lib/features/form_submission/application/element/form_instance.dart`
- `lib/features/form_submission/application/element/form_element.dart`
- `lib/features/form_submission/application/element/section_instance.dart`
- `lib/features/form_submission/application/element/repeat_section.dart`
- `lib/features/form_submission/application/element/repeat_item_instance.dart`
- `lib/features/form_submission/application/element/field_instance.dart`
- `lib/features/form_submission/presentation/form_submission_screen.widget.dart`
- `lib/features/form_submission/presentation/section/repeat_table.widget.dart`
- `lib/features/form_submission/presentation/section/repeat_table_rows_source.dart`
- `lib/features/form_submission/presentation/section/edit_row_screen.dart`
- `lib/database/dao/data_submissions_dao.dart`
- `lib/database/tables/data_submissions.table.dart`
- `lib/database/extensions/data_submission.extension.dart`

## Known Inactive Or Incomplete Form-Related Areas

Treat these as inactive, incomplete, or legacy-risk unless runtime evidence proves otherwise:

- the obsolete per-field `submission_capture_repository` path was removed; do not recreate it beside the active whole-JSON save path.
- `lib/data/metadata_submission_update.provider.dart` and its reference-field UI remain reachable but incomplete; do not infer active persistence from their names.

The obsolete normalized repeat/data-value persistence path was removed in schema
5. Active form capture stores fields and repeat rows only in
`data_instances.formData`.

The closed legacy repository/value-store/evaluation/UI-model architecture formerly
under `lib/core/form` has been removed. The production-reached files remaining in
that directory are the two builders, the form-element iterator, and the
`HintProvider` interface/implementation.

These files may contain useful ideas or stale design intent, but they are not authority for current behavior.

## Docs Are Evidence, Not Authority

Docs are a map of what previous scans found. They can be wrong or incomplete after code changes.

When docs conflict with code:

1. prefer active runtime call paths;
2. prefer entrypoints, routes, active DI registrations, imports, and direct references;
3. prefer currently generated code only when the generated code is actually used by active runtime;
4. explicitly record uncertainty;
5. update the docs if a later pass proves an assumption wrong.

## Build, Run, And Check Commands

Known useful commands:

```bash
flutter pub get
flutter run
flutter build apk --debug
flutter analyze
flutter test
dart run build_runner build
```

Notes:

- `flutter build apk --debug` succeeded on `chore/tooling-compat` with Flutter `3.41.9` and Dart `3.11.5`; that branch was merged into `develop` as the build baseline.
- Release builds may involve signing and `android/key.properties`; do not change signing casually.
- Generated code is present. If a change affects Riverpod, Stacked, injectable, Drift, Freezed, JSON serialization, or localization, identify the correct generation command before editing generated files manually.
- If a command fails because dependencies or SDK caches need network or writes outside the workspace, report that clearly.

## Active Vs Inactive Classification

Use the strict comment-out test from `05-classification-reconciliation.md`:

- ACTIVE: removing the path without replacement would break startup/auth/navigation, sync/offline cache, assignment/form access, form load/render/repeat/edit/save, or submission table behavior.
- SUPPORTING-USED: reachable UI/helper behavior, but core data collection would still run if intentionally removed.
- INACTIVE: not referenced by active runtime flow found in static scans.
- INCOMPLETE: reachable or plausible code exists, but implementation is unfinished, placeholder-based, or returns empty/no-op data.
- LEGACY-RISK: old, duplicate, registered-only, generated-only, or conceptually related code that could be mistaken for active.
- UNKNOWN: static evidence cannot prove either way.

Do not classify code as ACTIVE merely because:

- it compiles;
- it is generated;
- it is registered in DI but not retrieved by active flow;
- it has a form/table/repeat-looking name;
- it appears in stale docs/comments;
- it is reachable only through commented code.

## Safe Working Rules For Agents

Before editing code:

1. Check branch and working tree.
2. Read the focused context maps.
3. Identify the active call path and likely inactive lookalikes.
4. Keep the PR slice narrow.
5. Avoid mixed-purpose commits.
6. Do not refactor while mapping.
7. Do not change persistence format, repeat metadata semantics, sync payloads, or generated code casually.
8. Do not revert user changes you did not make.
9. Prefer local patterns over new abstractions.
10. Run the smallest meaningful validation.

For docs-only work:

- stay on the docs branch when possible;
- keep docs in `docs/agent-context/` unless the file is root-level onboarding like `AGENTS.md`;
- update the numbered maps when assumptions change.

For code work:

- create a focused branch from the correct baseline;
- keep generated changes intentional;
- use `apply_patch` for manual edits;
- run formatting only for files touched or when the project convention requires it.

## Definition Of Done For Code Changes

A code PR is not done until:

- the active path was identified;
- inactive/legacy-looking alternatives were not accidentally edited;
- behavior change is described in plain language;
- risk to persistence/sync/offline behavior is called out;
- relevant tests, build, analyze, or smoke checks were run, or inability to run them is explicitly reported;
- generated files are consistent when generators are involved;
- docs are updated if a mapped assumption changed.

For form/repeat/save changes, also confirm:

- new submissions still save;
- existing submissions still edit;
- finalized/upload flow is not broken;
- repeat rows are not silently dropped;
- large-repeat risk was considered.

## Solo Production Workflow

Use this lightweight workflow for solo developer plus AI-agent work:

1. Treat `develop` as integration and `main` as production.
2. Keep each production fix small and named by behavior.
3. Before code, write the data contract or behavior contract in plain text.
4. During code, avoid DB schema changes unless truly required.
5. Before merging to `develop`, run `git diff develop...HEAD`, run the smallest relevant checks, and do one smoke test for the touched workflow.
6. Before promoting `develop` to `main`, intentionally bump version/build number, confirm old local drafts/finals still load or upload, call out rollback risk, and tag the release commit.
7. After release, verify one real device can open, save, and sync, and keep the previous APK/build available for rollback.

Release signing notes:

- Do not commit signing keys.
- Release builds require a local signing configuration pointing at the Google Play key, currently expected outside the repo at `/home/hamza/datarun/datarun-key`.
- Stop before `develop -> main` promotion when signing, production-style build, or update smoke behavior is uncertain.

## PR Slicing Rules

Keep PRs boring and reviewable.

Good slices:

- tooling compatibility baseline;
- docs/context maps;
- await-save correctness fix;
- subscription cleanup;
- repeat metadata contract implementation;
- large-repeat measurement instrumentation;
- one performance improvement chosen from measurement.

Bad slices:

- save race fix plus repeat metadata persistence plus render optimization;
- build tooling plus production behavior changes;
- generated churn plus unrelated refactor;
- data model migration without runtime proof;
- docs that claim behavior without code evidence.

Prefer stacked branches only when a build baseline is required and not merged yet. Once the baseline is merged, start behavior PRs from `develop`.

## Known Risks Around Forms, Elements, Large Repeats, And Expressions

Current known risks:

- form load builds all controls and element instances eagerly;
- repeats with 200-300 rows can create large control/model trees;
- rule/dependency evaluation walks sections and repeat rows;
- expression evaluation parses expressions during evaluation;
- `FieldWidget` value subscriptions cancel on disposal, but listener/rebuild volume still scales with mounted repeat fields;
- `saveFormData()` writes one whole `formData` JSON object;
- active save call sites now await persistence; failed-write and concurrent-tap behavior still need characterization;
- repeat metadata persistence matches the backend V1 shape locally: `_id`, `_index`, `_parentId`, `_submissionUid`; server round-trip editing is not yet validated;
- generated and old form-state paths can mislead agents into editing inactive code.

Current recommended order for known work:

1. Complete and validate the behavior-preserving former-SDK package consolidation.
2. Map each surviving service/state object's responsibility, owner, lifetime, consumers, and persistence/network effects.
3. Reorganize folders and same-layer services by that proven ownership, keeping mechanical moves separate from behavioral changes.
4. Consolidate state/DI mechanisms one bounded feature at a time; remove a library only after no active path depends on it.
5. Revisit form engine/expression ownership and large-repeat performance using the existing harness and real form structures.
6. Close incomplete access, synced edit/delete, and offline policy only after their contracts are explicit.
