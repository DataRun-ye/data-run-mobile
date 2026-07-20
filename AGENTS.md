# Agent Onboarding

This repository contains the running production DataRun mobile/data-collection app and the local SDK package it consumes.

Before changing code, read:

- `docs/agent-context/agents-onboarding.md`
- `docs/agent-context/05-classification-reconciliation.md`
- the focused map for the area you are touching, especially `02-form-flow.md`, `03-config-fetching.md`, `04-state-di-runtime-map.md`, `06-large-repeat-hang-data-loss.md`, and `07-repeat-uid-contract.md`.

Core rules:

- Treat docs, comments, table names, generated files, and old code as evidence, not authority.
- Classify code as ACTIVE only when removing it without replacement would break startup/auth/navigation, sync/offline cache, assignment/form access, form load/render/repeat/edit/save, or submission table behavior.
- Prefer active runtime entrypoints, imports, route registrations, DI registrations actually used, and call paths over names that sound relevant.
- Keep code changes small, reversible, and scoped to one behavior.
- Do not mix tooling, docs, save correctness, repeat metadata behavior, and performance refactors in one PR.
- Do not base form persistence changes on inactive-looking `repeat_instances`, `data_values`, or old form-state/provider paths unless runtime evidence proves they are active.

Known high-risk form areas:

- active form state is scoped `GetIt` `FormInstance` plus `reactive_forms`, not the old commented Riverpod form providers.
- form loading builds the full form JSON, full control tree, and full element tree eagerly.
- submissions are saved as one whole `formData` JSON object.
- large repeats, expressions, field subscriptions, and repeat metadata persistence are known risk areas; use `docs/agent-context/07-repeat-uid-contract.md` as the current contract instead of old `repeatUid` assumptions.

Common commands:

```bash
flutter pub get
flutter run
flutter build apk --debug
flutter analyze
flutter test
dart run build_runner build --delete-conflicting-outputs
```

Definition of done for code changes:

- Active path identified and inactive lookalikes ruled out.
- Smallest practical PR slice chosen.
- Relevant generated files handled intentionally.
- Build/checks run or explicitly reported as not run.
- User-facing behavior, persistence, sync, and migration risk called out.
