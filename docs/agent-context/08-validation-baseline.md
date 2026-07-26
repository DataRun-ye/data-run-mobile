# Validation Baseline Before Refactoring

Validated: 2026-07-25

Scope: smallest practical executable baseline for behavior-preserving cleanup and ownership work. Rerun commands before relying on these results.

## Current Baseline

| Area | Command | Status | Evidence / notes |
| --- | --- | --- | --- |
| Dependency resolution | `flutter pub get` | PASS | Root package resolves. Former `drun_sdk` dependencies are declared directly in the root package. |
| Tests | `flutter test --no-pub` | PASS | The full suite passed for the `v6.0.2` release source at `fbd75b48`. Coverage includes schema 3 through 7 migration, auth/session lifecycle, config sync outcomes, form ownership and validation, repeat lifecycle/dependencies/metadata/performance, Reference catalog/field/upload, submission table state, locale, telemetry, and active DI registration. |
| Static analysis | `flutter analyze --no-pub` | NO ERRORS; LINT DEBT | The release gate reported no analyzer errors. Existing warning/info debt remains; reduce it only in bounded ownership slices. |
| Debug Android build | `flutter build apk --debug --no-pub` | PASS | Produces `build/app/outputs/flutter-apk/app-debug.apk`. Java source/target 8 deprecation warnings remain. |
| Code generation | `dart run build_runner build` | PASS | Generator ownership is constrained to active outputs. The measured clean run is about 95 seconds including builder compilation; a no-change run is about 5 seconds. Review generated diffs intentionally. |
| Release build and upgrade | `flutter build appbundle --release` plus Play-distributed upgrade | PASS FOR `v6.0.2+53` | Build 52 passed Play Internal Testing upgrade smoke on Redmi. Build 53 changed only the build number, was accepted by Play, and is live in production. Local upload-key APKs cannot replace Play-signed installs. |

## Required Checks By Slice

| Change type | Required checks |
| --- | --- |
| Docs-only | Confirm the diff is docs-only and current paths are valid. |
| Mechanical file/ownership move | `flutter pub get`, full `flutter test --no-pub`, `flutter analyze --no-pub`, generated-code equivalence where relevant, and `flutter build apk --debug --no-pub`. |
| Runtime behavior | Full tests plus focused characterization for the touched contract and a debug build. Smoke the affected workflow when persistence, sync, auth, or forms are touched. |
| Drift schema/migration | Migration fixture tests from production-observed schema 3, full tests, debug build, and explicit old-data preservation review. |
| Generated code | Run the relevant generator, review generated changes, then run the normal checks for the behavior changed. |

## Known Limits

- The tests are targeted characterization checks, not broad product coverage.
- Large-repeat metrics are deterministic harness measurements, not proof of behavior on slower field devices.
- The V6 foundation and `v6.0.2` release passed production-style upgrade
  smokes; future changes crossing login/config sync, form entry, local save, or
  upload still require a focused device smoke.
- The analyzer is not yet a green gate because inherited lint debt remains, but analyzer errors or new warnings are regressions.
