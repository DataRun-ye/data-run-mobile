# Validation Baseline Before Refactoring

Validated: 2026-07-22

Scope: smallest practical executable baseline for behavior-preserving cleanup and ownership work. Rerun commands before relying on these results.

## Current Baseline

| Area | Command | Status | Evidence / notes |
| --- | --- | --- | --- |
| Dependency resolution | `flutter pub get` | PASS | Root package resolves. Former `drun_sdk` dependencies are declared directly in the root package. |
| Tests | `flutter test --no-pub` | PASS | All 39 current tests pass. They cover schema 3/4 to 5 migration, sync registration and status projection, form-bootstrap guards, route-owned scope/form-graph teardown, explicit completion-sheet behavior, repeat metadata/validation/metrics, submission completion/edit access/upload/table pagination and selected actions, assignment ownership, managed-team/activity projection, and live sync-badge state. |
| Static analysis | `flutter analyze --no-pub` | NO ERRORS; LINT DEBT | Reports 110 existing warning/info findings after the current ownership cleanup. Most were previously hidden under the nested SDK analyzer boundary and became visible after consolidation. Do not increase this count; clean it in bounded ownership slices rather than mixing it into mechanical moves. |
| Debug Android build | `flutter build apk --debug --no-pub` | PASS | Produces `build/app/outputs/flutter-apk/app-debug.apk`. Java source/target 8 deprecation warnings remain. |
| Code generation | `dart run build_runner build` | PASS, EXPENSIVE | Full generation passed after consolidation and took about eight minutes. It still warns that `FormMetadataService` depends on unregistered `AndroidDeviceInfoService`. Review generated diffs intentionally. |
| Release build | `flutter build appbundle --release` | MANUAL RELEASE GATE | Requires the local upload signing key and is not a normal inner-loop check. A local upload-key build cannot replace the Play-installed app directly because Play App Signing uses a different installed-app certificate. |

## Required Checks By Slice

| Change type | Required checks |
| --- | --- |
| Docs-only | Confirm the diff is docs-only and current paths are valid. |
| Mechanical file/ownership move | `flutter pub get`, full `flutter test --no-pub`, `flutter analyze --no-pub`, generated-code equivalence where relevant, and `flutter build apk --debug --no-pub`. |
| Runtime behavior | Full tests plus focused characterization for the touched contract and a debug build. Smoke the affected workflow when persistence, sync, auth, or forms are touched. |
| Drift schema/migration | Migration fixture tests from production-observed schema 3, full tests, debug build, and explicit old-data preservation review. |
| Generated code | Run the relevant generator, review generated changes, then run the normal checks for the behavior changed. |

## Known Limits

- The 39 tests are targeted characterization checks, not broad product coverage.
- Large-repeat metrics are deterministic harness measurements, not proof of behavior on slower field devices.
- Login/config sync, form entry, local save, and submission upload still require production-style smoke checks for changes crossing those boundaries.
- The analyzer is not yet a green gate because inherited lint debt remains, but analyzer errors or new warnings are regressions.
