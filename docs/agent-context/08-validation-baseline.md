# Validation Baseline Before Refactoring

Generated: 2026-07-10

Scope: smallest practical check baseline for future PRs. This is not a test strategy rewrite and does not change runtime behavior.

## Bottom Line

The current usable baseline is:

1. `flutter pub get` must pass.
2. `flutter build apk --debug` must pass for code changes that can affect runtime/build behavior.
3. `flutter analyze` must be run and reported, but it is currently red.
4. `flutter test` must be run and reported, but it is currently red because the discovered tests are stale/commented out.

Do not treat the current test suite as coverage for production form behavior.

## Command Matrix

| Area | Command | Status on 2026-07-10 | Evidence / notes |
| --- | --- | --- | --- |
| Toolchain | `flutter --version` | PASS | Flutter 3.41.9 stable, Dart 3.11.5. In this sandbox it needed access to the FVM cache outside the repo. |
| Dependency resolution | `flutter pub get` | PASS | Root app resolves. Reports 73 newer packages outside constraints; this is not a failure. |
| Static analysis | `flutter analyze` | FAIL | 50 issues. Mostly unused/unnecessary imports, deprecated API use, `sort_constructors_first`, and experimental Sentry API warning. Includes app and `packages/drun_sdk`. |
| Root tests | `flutter test` | FAIL | Both discovered test files fail to load because they have no active `main()` method. |
| Debug Android build | `flutter build apk --debug` | PASS | Produces `build/app/outputs/flutter-apk/app-debug.apk`. |
| Code generation | `dart run build_runner build` | AVAILABLE | Generator command rewrites generated files, so run it only in changes that intentionally touch generated code. |
| SDK tests | `cd packages/drun_sdk && dart test` | UNAVAILABLE / NOT BASELINE | No `packages/drun_sdk/test` directory found. SDK `flutter_test` dev dependency is commented out. Root `flutter analyze` still analyzes SDK code. |
| Release build | `flutter build apk --release` | NOT BASELINE | Release signing intentionally requires valid local `android/key.properties`; do not use this as normal PR validation until signing is configured on the machine/CI. |

## Broken Or Outdated Tests Found

| File | Status | Why it matters |
| --- | --- | --- |
| `test/widget_test.dart` | Outdated/commented | Counter-template test is commented out and does not exercise this app. `flutter test` reports missing `main()`. |
| `test/get_it_test/get_it_test.dart` | Outdated/commented | Old GetIt/reflectable experiments are commented and reference stale packages/imports. `flutter test` reports missing `main()`. |
| `packages/drun_sdk/test/` | Missing | SDK has no separate test surface despite containing active parsing, persistence, and sync code. |

## Minimal Validation Strategy

Until real characterization tests exist, future code PRs should use this baseline:

| PR type | Required checks | How to read the result |
| --- | --- | --- |
| Docs-only | Verify diff is docs-only. Runtime checks optional. | No app behavior changed. |
| Tooling/build config | `flutter pub get`, `flutter build apk --debug` | Both should pass before merge. |
| Runtime app or SDK code | `flutter pub get`, `flutter analyze`, `flutter test`, `flutter build apk --debug` | Build must pass. Analyze/test failures must be reported and should not get worse. |
| Generated-code PR | `dart run build_runner build`, then normal runtime checks | Generated diffs must be intentional and reviewed. |
| Form/save/repeat PR | Normal runtime checks plus targeted characterization tests once added | Do not rely on current stale tests as proof. |

The first cleanup target should not be "fix all tests." The practical target is to add a few focused tests around active behavior, then make `flutter test` meaningful again.

## First Characterization Test PR Recommendation

Create a small test PR before deeper form refactoring. Keep it focused on active behavior:

1. Repeat metadata preservation test.
   - Prove an existing repeat row `_id` loaded from JSON is preserved after reduce/save behavior.
   - Prove a new repeat row receives backend-compatible repeat metadata before persistence.
   - Target active files: `repeat_item_instance.dart`, `repeat_section.dart`, and the active builder/reducer path.

2. Submission save characterization.
   - Prove `FormInstance.saveFormData()` awaits the DAO write and persists the whole `formData` JSON expected by upload.
   - Prefer a fake/in-memory DAO seam only if the current code already supports it; do not introduce a large test framework.

3. Form JSON loading smoke test.
   - Use a small fixture modeled after `example/` forms.
   - Prove loading creates repeat controls/items from whole JSON and does not recreate normalized repeat/data-value persistence.

Acceptance for that test PR:

- `flutter test` runs at least one real active-behavior test.
- Old commented tests are either removed or replaced in the same small PR.
- No production behavior changes unless the PR is explicitly paired with a tiny bug fix.
- No new persistence format or refactor is introduced.
